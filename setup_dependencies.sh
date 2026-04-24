#!/usr/bin/env bash
# setup_dependencies.sh
#
# Install all SHARC hard dependencies on Ubuntu 24.04 (inside a Docker container).
# Run as root, from the root of the SHARC repository:
#
#   chmod +x setup_dependencies.sh && ./setup_dependencies.sh
#
# If you maintain your own Scarab installation, point to it so this script
# skips the clone/build step:
#
#   ./setup_dependencies.sh --scarab-dir /path/to/your/scarab
#   # or equivalently:
#   SCARAB_ROOT=/path/to/your/scarab ./setup_dependencies.sh
#
# Re-running is safe: each step is skipped if the target already exists.

set -euo pipefail

# ============================================================
#  Argument parsing
# ============================================================
# --scarab-dir overrides the SCARAB_ROOT env var, which overrides the default.
while [[ $# -gt 0 ]]; do
    case $1 in
        --scarab-dir)
            SCARAB_ROOT="$2"
            shift 2
            ;;
        *)
            echo "Unknown argument: $1" >&2
            echo "Usage: $0 [--scarab-dir <path>]" >&2
            exit 1
            ;;
    esac
done

# ============================================================
#  Configuration — adjust paths here if needed
# ============================================================
PIN_NAME="pin-3.15-98253-gb56e429b1-gcc-linux"
PIN_ROOT="/${PIN_NAME}"
# SCARAB_ROOT: use --scarab-dir, or SCARAB_ROOT env var, or the default /scarab.
SCARAB_ROOT="${SCARAB_ROOT:-/scarab}"
SCARAB_COMMIT="3b38da01acf86ce35bc1785c97d638e29eab0647"
DYNAMORIO_VERSION="DynamoRIO-Linux-9.0.19314"
DYNAMORIO_HOME="/${DYNAMORIO_VERSION}"
SIMPOINT_BIN="/usr/local/bin/simpoint"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RESOURCES_DIR="${RESOURCES_DIR:-${SCRIPT_DIR}/resources}"

# Decide whether to build Scarab: skip if the directory already exists.
# This covers both --scarab-dir pointing at a pre-built copy and re-runs
# of this script after Scarab was already built at the default path.
if [ -d "${SCARAB_ROOT}" ]; then
    SKIP_SCARAB_BUILD=true
    echo "Scarab found at '${SCARAB_ROOT}' — build step will be skipped."
else
    SKIP_SCARAB_BUILD=false
fi

# ============================================================
#  1. System packages
# ============================================================
echo "[1/7] Installing system packages..."
export DEBIAN_FRONTEND=noninteractive

apt-get update -q
apt-get install -y --no-install-recommends \
    build-essential manpages-dev software-properties-common \
    ca-certificates gpg-agent wget curl git vim unzip bc \
    python3 python3-pip \
    cmake binutils \
    libunwind-dev libboost-dev zlib1g-dev libsnappy-dev liblz4-dev libconfig++-dev \
    gcc-11 g++-11 \
    gcc-12 g++-12 \
    libomp-dev lcov \
    libsfml-dev

# Controller binaries always need a working g++.  We also need a C++ compiler
# that matches what Scarab was built with — but only when building Scarab here.
#
# * Pre-built Scarab  → g++-12 is sufficient; skip the slow g++-9 PPA step.
# * Building Scarab   → try g++-9 first (what Scarab was developed against);
#                       fall back to g++-12 if the PPA doesn't carry it for Noble.
if [ "${SKIP_SCARAB_BUILD}" = true ]; then
    SCARAB_GCC=12
    echo "  -> Using g++-12 (Scarab already built, no need for g++-9)"
else
    if add-apt-repository -y ppa:ubuntu-toolchain-r/test 2>/dev/null \
       && apt-get update -q \
       && apt-get install -y --no-install-recommends gcc-9 g++-9 2>/dev/null; then
        SCARAB_GCC=9
        echo "  -> g++-9 installed from toolchain PPA"
    else
        SCARAB_GCC=12
        echo "  -> g++-9 unavailable; will build Scarab with g++-12"
    fi
fi

# Set the chosen version as the system default.
update-alternatives \
    --install /usr/bin/gcc gcc /usr/bin/gcc-${SCARAB_GCC} 100 \
    --slave   /usr/bin/g++ g++ /usr/bin/g++-${SCARAB_GCC}

# Also register g++-12 as an alternative so you can switch with
#   update-alternatives --config gcc
if [ "${SCARAB_GCC}" != "12" ]; then
    update-alternatives \
        --install /usr/bin/gcc gcc /usr/bin/gcc-12 80 \
        --slave   /usr/bin/g++ g++ /usr/bin/g++-12
fi

# ============================================================
#  2. Intel PIN
# ============================================================
echo "[2/7] Installing Intel PIN..."
if [ ! -d "${PIN_ROOT}" ]; then
    wget -q \
        "https://software.intel.com/sites/landingpage/pintool/downloads/${PIN_NAME}.tar.gz" \
        -O /tmp/pin.tar.gz
    tar -xzf /tmp/pin.tar.gz -C /
    rm /tmp/pin.tar.gz
    echo "  -> Extracted to ${PIN_ROOT}"
else
    echo "  -> Already present at ${PIN_ROOT}, skipping"
fi

# ============================================================
#  3. Scarab
# ============================================================
echo "[3/7] Scarab..."
if [ "${SKIP_SCARAB_BUILD}" = true ]; then
    # Validate that the provided path looks like a real Scarab installation.
    if [ ! -f "${SCARAB_ROOT}/bin/scarab_globals/scarab_paths.py" ] && \
       [ ! -d "${SCARAB_ROOT}/src" ]; then
        echo "  WARNING: '${SCARAB_ROOT}' doesn't look like a Scarab repo (missing src/ and bin/)." >&2
        echo "           Double-check the path.  Continuing anyway." >&2
    fi
    echo "  -> Using existing Scarab at ${SCARAB_ROOT}"
    # Still ensure Scarab's Python deps are installed in this environment.
    if [ -f "${SCARAB_ROOT}/bin/requirements.txt" ]; then
        pip3 install --break-system-packages -r "${SCARAB_ROOT}/bin/requirements.txt"
        echo "  -> Scarab Python requirements installed"
    fi
else
    git clone https://github.com/Litz-Lab/scarab.git "${SCARAB_ROOT}"
    git -C "${SCARAB_ROOT}" checkout "${SCARAB_COMMIT}"

    pip3 install --break-system-packages -r "${SCARAB_ROOT}/bin/requirements.txt"

    echo "  -> Compiling (this takes a few minutes)..."
    make -C "${SCARAB_ROOT}/src" -j"$(nproc)"
    echo "  -> Scarab built at ${SCARAB_ROOT}"
fi

# ============================================================
#  4. DynamoRIO  (needed for parallel / trace mode)
# ============================================================
echo "[4/7] Installing DynamoRIO..."
if [ ! -d "${DYNAMORIO_HOME}" ]; then
    mkdir -p "${DYNAMORIO_HOME}"
    wget -q \
        "https://github.com/DynamoRIO/dynamorio/releases/download/cronbuild-9.0.19314/${DYNAMORIO_VERSION}.tar.gz" \
        -O /tmp/dynamorio.tar.gz
    # --strip-components=1 removes the top-level directory so files land
    # directly in $DYNAMORIO_HOME rather than $DYNAMORIO_HOME/$DYNAMORIO_VERSION/
    tar -xzf /tmp/dynamorio.tar.gz --strip-components=1 -C "${DYNAMORIO_HOME}"
    rm /tmp/dynamorio.tar.gz
    echo "  -> Extracted to ${DYNAMORIO_HOME}"
else
    echo "  -> Already present at ${DYNAMORIO_HOME}, skipping"
fi

# ============================================================
#  5. SimPoint 3.2
# ============================================================
echo "[5/7] Building SimPoint 3.2..."
if [ ! -f "${SIMPOINT_BIN}" ]; then
    TMP_SP="$(mktemp -d)"
    wget -q \
        "http://cseweb.ucsd.edu/~calder/simpoint/releases/SimPoint.3.2.tar.gz" \
        -O "${TMP_SP}/simpoint.tar.gz"
    tar -xzf "${TMP_SP}/simpoint.tar.gz" -C "${TMP_SP}"
    wget -q \
        "https://raw.githubusercontent.com/intel/pinplay-tools/main/pinplay-scripts/PinPointsHome/Linux/bin/simpoint_modern_gcc.patch" \
        -O "${TMP_SP}/patch.txt"
    patch -d "${TMP_SP}/SimPoint.3.2" -p1 < "${TMP_SP}/patch.txt"
    make -C "${TMP_SP}/SimPoint.3.2" -j"$(nproc)"
    install -m 755 "${TMP_SP}/SimPoint.3.2/bin/simpoint" "${SIMPOINT_BIN}"
    rm -rf "${TMP_SP}"
    echo "  -> Installed to ${SIMPOINT_BIN}"
else
    echo "  -> Already installed at ${SIMPOINT_BIN}, skipping"
fi

# ============================================================
#  6. Python packages
# ============================================================
echo "[6/7] Installing Python packages..."
# --break-system-packages is required on Ubuntu 24.04 (PEP 668 enforcement)
pip3 install --break-system-packages \
    python-slugify pandas numpy matplotlib ipykernel scipy

if [ -f "${RESOURCES_DIR}/sharc/requirements.txt" ]; then
    pip3 install --break-system-packages -r "${RESOURCES_DIR}/sharc/requirements.txt"
fi

if [ -f "${SCRIPT_DIR}/examples/acc_example/requirements.txt" ]; then
    pip3 install --break-system-packages -r "${SCRIPT_DIR}/examples/acc_example/requirements.txt"
fi

if [ -f "${SCARAB_ROOT}/bin/requirements.txt" ]; then
    pip3 install --break-system-packages -r "${SCARAB_ROOT}/bin/requirements.txt"
fi

# ============================================================
#  7. Environment variables
# ============================================================
echo "[7/7] Writing environment variables to ~/.bashrc..."

ENV_BLOCK="
# ===== SHARC =====
export PIN_ROOT=\"${PIN_ROOT}\"
export SCARAB_ROOT=\"${SCARAB_ROOT}\"
export SIMDIR=\"${SCARAB_ROOT}\"
export DYNAMORIO_HOME=\"${DYNAMORIO_HOME}\"
export SCARAB_ENABLE_PT_MEMTRACE=1
export SCARAB_ENABLE_MEMTRACE=1
export LD_LIBRARY_PATH=\"\${PIN_ROOT}/extras/xed-intel64/lib:\${PIN_ROOT}/intel64/runtime/pincrt\${LD_LIBRARY_PATH:+:\${LD_LIBRARY_PATH}}\"
export PYTHONPATH=\"\${SCARAB_ROOT}/bin:${RESOURCES_DIR}\${PYTHONPATH:+:\${PYTHONPATH}}\"
export PATH=\"\${PATH}:\${SCARAB_ROOT}:\${SCARAB_ROOT}/src:\${SCARAB_ROOT}/bin:${RESOURCES_DIR}/sharc:${RESOURCES_DIR}/sharc/scripts\"
# ===== End SHARC ====="

if ! grep -q "===== SHARC =====" "${HOME}/.bashrc" 2>/dev/null; then
    printf '%s\n' "${ENV_BLOCK}" >> "${HOME}/.bashrc"
    echo "  -> Written to ${HOME}/.bashrc"
else
    echo "  -> Already present in ${HOME}/.bashrc, skipping"
fi

# ============================================================
#  Done
# ============================================================
echo ""
echo "All dependencies installed successfully."
echo "Run: source ~/.bashrc"
echo ""
echo "Optional: if you use the libMPC examples, also run:"
echo "  git submodule update --init libmpc"
echo "  libmpc/configure.sh && mkdir libmpc/build && cd libmpc/build && cmake .. && cmake --install ."
