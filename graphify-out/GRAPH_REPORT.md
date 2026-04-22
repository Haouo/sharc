# Graph Report - resources/  (2026-04-22)

## Corpus Check
- 48 files · ~109,434 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 871 nodes · 2041 edges · 40 communities detected
- Extraction: 66% EXTRACTED · 34% INFERRED · 0% AMBIGUOUS · INFERRED: 686 edges (avg confidence: 0.74)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_JSON Library (nlohmann)|JSON Library (nlohmann)]]
- [[_COMMUNITY_Plant Runner & Sim Executor|Plant Runner & Sim Executor]]
- [[_COMMUNITY_Simulation & Experiment Core|Simulation & Experiment Core]]
- [[_COMMUNITY_Controller Build System|Controller Build System]]
- [[_COMMUNITY_ComputationData & TimeStepSeries|ComputationData & TimeStepSeries]]
- [[_COMMUNITY_Batch Data Structures|Batch Data Structures]]
- [[_COMMUNITY_ACC Dynamics & Batch Integration|ACC Dynamics & Batch Integration]]
- [[_COMMUNITY_ACC Controller C++|ACC Controller C++]]
- [[_COMMUNITY_Controller Interface Layer|Controller Interface Layer]]
- [[_COMMUNITY_C++ Controller Framework|C++ Controller Framework]]
- [[_COMMUNITY_ExperimentList Management|ExperimentList Management]]
- [[_COMMUNITY_ACC Dynamics (Python)|ACC Dynamics (Python)]]
- [[_COMMUNITY_MPC Solver Interface|MPC Solver Interface]]
- [[_COMMUNITY_Scarab Trace Processor Tests|Scarab Trace Processor Tests]]
- [[_COMMUNITY_Batcher Iteration Logic|Batcher Iteration Logic]]
- [[_COMMUNITY_Utility Functions & Tests|Utility Functions & Tests]]
- [[_COMMUNITY_LMPC Controller|LMPC Controller]]
- [[_COMMUNITY_NLMPC Controller|NLMPC Controller]]
- [[_COMMUNITY_CustomController Header|CustomController Header]]
- [[_COMMUNITY_CustomController Source|CustomController Source]]
- [[_COMMUNITY_Python Package Init|Python Package Init]]
- [[_COMMUNITY_Debug Levels Header|Debug Levels Header]]
- [[_COMMUNITY_Main Entry Point|Main Entry Point]]
- [[_COMMUNITY_Dynamics Evolution Function|Dynamics Evolution Function]]
- [[_COMMUNITY_State Derivative Computation|State Derivative Computation]]
- [[_COMMUNITY_Setup Script|Setup Script]]
- [[_COMMUNITY_Loop Data Parser|Loop Data Parser]]
- [[_COMMUNITY_Trace Portability Script|Trace Portability Script]]
- [[_COMMUNITY_Tests Init|Tests Init]]
- [[_COMMUNITY_Tests Context|Tests Context]]
- [[_COMMUNITY_Eigen Vector Types|Eigen Vector Types]]
- [[_COMMUNITY_CustomController Template|CustomController Template]]
- [[_COMMUNITY_Vector Comparison Utility|Vector Comparison Utility]]
- [[_COMMUNITY_StatusReader Class|StatusReader Class]]
- [[_COMMUNITY_Controller Dimensions Init|Controller Dimensions Init]]
- [[_COMMUNITY_Debug Levels Module|Debug Levels Module]]
- [[_COMMUNITY_Utils Module|Utils Module]]
- [[_COMMUNITY_ScarabData|ScarabData]]
- [[_COMMUNITY_TimeStepSeries Copy Tests|TimeStepSeries Copy Tests]]
- [[_COMMUNITY_TimeStepSeries Concat Tests|TimeStepSeries Concat Tests]]

## God Nodes (most connected - your core abstractions)
1. `ComputationData` - 53 edges
2. `ControllerInterface` - 46 edges
3. `PipesControllerInterface` - 46 edges
4. `TimeStepSeries` - 43 edges
5. `DelayProvider` - 35 edges
6. `type()` - 30 edges
7. `assertFileExists()` - 27 edges
8. `MockControllerInterface` - 25 edges
9. `namespace()` - 23 edges
10. `push_back()` - 23 edges

## Surprising Connections (you probably didn't know these)
- `TestMockExecutionDrivenScarabRunner` --semantically_similar_to--> `Test_MockTracesToComputationTimesProcessor (Mock trace processor tests)`  [INFERRED] [semantically similar]
  resources/tests/test_scarabizor.py → resources/tests/test_computation_times_processor.py
- `test_from_experiment_config_batched` --conceptually_related_to--> `Simulation Batch With No Misses (data layout table)`  [INFERRED]
  resources/tests/test_SimulationClass.py → resources/sharc/README.md
- `matToStdVector()` --calls--> `push_back()`  [INFERRED]
  resources/controllers/src/main_controller.cpp → resources/include/nlohmann/json.hpp
- `checkAndStripInputLoopNumber()` --calls--> `split()`  [INFERRED]
  resources/sharc/utils.py → resources/include/nlohmann/json.hpp
- `Indicators to alert the C++ code the status of the (Python) simulation.` --uses--> `ComputationData`  [INFERRED]
  resources/sharc/controller_interface.py → resources/sharc/data_types.py

## Hyperedges (group relationships)
- **Controller factory pattern** — controller_h_register_controller_macro, controller_cpp_registercontroller, controller_cpp_createcontroller, acc_controller_h_acc_controller, lmpc_controller_h_lmpccontroller, nlmpc_controller_h_nlmpccontroller [EXTRACTED 0.95]
- **MPC control loop via pipes** — main_controller_cpp_main, controller_h_controller, main_controller_cpp_pipevectorreader, main_controller_cpp_pipevectorwriter, scarab_markers_h [INFERRED 0.90]
- **Debug infrastructure** — debug_levels_hpp_global_debug_levels, debug_levels_hpp_debuglevels, utils_hpp_printvector, utils_hpp_printmat, acc_controller_cpp_setup, lmpc_controller_cpp_setup [INFERRED 0.85]
- **Simulation Execution Pipeline** — simulationexecutor_class, controllerinterface_class, plantrunner_module, dynamics_class, timestepseries_class [INFERRED 0.85]
- **Delay Provider Implementations** — delayprovider_class, scarabdelayprovider_class, onetimestepdelayprovider_class, nonedelayprovider_class, gaussiandelayprovider_class [EXTRACTED 1.00]
- **Scarab Simulation Components** — executiondrivenscarabrunner_class, mockexecutiondrivenscarabrunner_class, tracestocomputationtimesprocessor_class, scarabtracestocomputationtimesprocessor_class, mocktracestocomputationtimesprocessor_class, scarabstatsreader_class, paramsdata_class [EXTRACTED 1.00]
- **Dynamics Class Hierarchy** — dynamics_class, odedynamics_class, ltidynamics_class, accdynamics_class, cartpoledynamics_class [EXTRACTED 1.00]
- **Batching Pipeline Classes** — batchinit_class, batch_class, batcher_class, timestepseries_class, simulation_class [EXTRACTED 0.90]
- **Integration Tests Using Fake Delays Pattern** — test_acc_fake_delays_test_run_fake_serial, test_acc_fake_delays_test_run_fake_parallel, test_simulation_test_run_fake_serial, test_simulation_test_run_fake_parallel, test_consistency_test_fake_delays [INFERRED 0.88]
- **Mock Controller Test Infrastructure** — sharc_mocks_mockdelayprovider, sharc_mocks_mockcontrollerinterface, test_controller_interface_testcontrollerinterface, test_plant_runner_test_get_u [EXTRACTED 0.92]
- **Batch Missed Computation Detection and Recovery** — sharc_readme_batch_with_miss, sharc_readme_rationale_restart_from_miss, test_batches_test_batch, test_timestepseries_test_find_first_missed_computation [INFERRED 0.87]

## Communities

### Community 0 - "JSON Library (nlohmann)"
Cohesion: 0.05
Nodes (108): createController(), accept(), add(), at(), back(), basic_json(), begin(), binary() (+100 more)

### Community 1 - "Plant Runner & Sim Executor"
Cohesion: 0.03
Nodes (59): Send the current state to the controller and wait for the responses.      Return, Open resources that need to be closed when finished., cast_vector(), DataNotRecievedViaFileError, delay(), metadata(), print_sample_time_values(), print_time_step_values() (+51 more)

### Community 2 - "Simulation & Experiment Core"
Cohesion: 0.05
Nodes (40): context.py scarabizor import path setup, from_experiment_config_batched(), from_experiment_config_unbatched(), Simulation, main(), ExecutionDrivenScarabRunner, from_file(), MockExecutionDrivenScarabRunner (+32 more)

### Community 3 - "Controller Build System"
Cohesion: 0.05
Nodes (44): ABC, BaseControllerExecutableProvider, CmakeControllerExecutableProvider, ControllerInterface, DelayProvider, get_delay(), PipesControllerInterface, Indicators to alert the C++ code the status of the (Python) simulation. (+36 more)

### Community 4 - "ComputationData & TimeStepSeries"
Cohesion: 0.06
Nodes (24): return t_delay, metadata, ComputationData, _from_lists(), Check the equality of the time series EXCLUDING metadata., This function overwrites the computation times recorded in the time series., Truncate this series to end at the last index in time step "last_k"., Search through the time series to find, Check the equality of the *data* EXCLUDING metadata. (+16 more)

### Community 5 - "Batch Data Structures"
Cohesion: 0.07
Nodes (23): Batch, BatchInit, first(), _from_lists(), array(), Simulation Batch With No Misses (data layout table), Simulation With A Missed Computation (data layout and recovery), Rationale: restart batch from first missed computation row (+15 more)

### Community 6 - "ACC Dynamics & Batch Integration"
Cohesion: 0.06
Nodes (46): ACCDynamics, BaseControllerExecutableProvider, Batch, Batcher, Simulation Batching with Missed Computation Handling, BatchInit, CartPoleDynamics, CmakeControllerExecutableProvider (+38 more)

### Community 7 - "ACC Controller C++"
Cohesion: 0.07
Nodes (36): ACC_Controller::calculateControl(), ACC_Controller::setup(), ACC_Controller::updateStateSpaceMatrices(), ACC_Controller::updateTerminalConstraint(), ACC_Controller class, Controller::createController() factory, Controller::registerController(), Controller (base class) (+28 more)

### Community 8 - "Controller Interface Layer"
Cohesion: 0.08
Nodes (7): ACC_Controller(), Get an (possibly) updated value of u.      Returns: u, u_delay, u_pending, u_pen, ControllerInterface, MockControllerInterface, MockDelayProvider, TestControllerInterface, Test_get_u

### Community 9 - "C++ Controller Framework"
Cohesion: 0.07
Nodes (19): Controller(), getLatestControl(), initializeDimensions(), main(), matToStdVector(), my_setenv(), PipeDoubleReader, PipeDoubleWriter (+11 more)

### Community 10 - "ExperimentList Management"
Cohesion: 0.13
Nodes (8): ExperimentList, assert_all_results_almost_equal (Approximate equality checker), assert_all_results_equal (Result equality checker), test_fake_delays (Consistency test with fake delays), test_serial_vs_parallel_with_fake_delays, test_working_dir_unchanged_by_sharc, TestConsistency, TestCase

### Community 11 - "ACC Dynamics (Python)"
Cohesion: 0.1
Nodes (10): ACCDynamics, Dynamics, OdeDynamics, Define a default exogenous input function.       To implement this in subclasses, CartPoleDynamics, LTIDynamics, Implement the abstract system_derivative method from OdeDynamics., Implement the abstract system_derivative method from OdeDynamics. (+2 more)

### Community 12 - "MPC Solver Interface"
Cohesion: 0.17
Nodes (20): calculateControl(), setConstraints(), setOptimizerParameters(), setReferences(), setup(), setWeights(), updateStateSpaceMatrices(), updateTerminalConstraint() (+12 more)

### Community 13 - "Scarab Trace Processor Tests"
Cohesion: 0.18
Nodes (7): MockTracesToComputationTimesProcessor, Delete the statitics files that were created. This is designed to be used in tes, Override the superclass' simulate trace to not use Scarab to get the computation, ScarabTracesToComputationTimesProcessor, TracesToComputationTimesProcessor, Test_MockTracesToComputationTimesProcessor, Test_ScarabTracesToComputationTimesProcessor

### Community 14 - "Batcher Iteration Logic"
Cohesion: 0.29
Nodes (3): Batcher, create_batcher_without_misses(), Test_Batcher

### Community 15 - "Utility Functions & Tests"
Cohesion: 0.15
Nodes (10): items(), iterator_wrapper(), Test that it can sum a list of integers, Test that it can sum a list of integers, Test that it can sum a list of integers, Test that it can sum a list of integers, Test that it can sum a list of integers, TestPatchDictionary (+2 more)

### Community 16 - "LMPC Controller"
Cohesion: 1.0
Nodes (0): 

### Community 17 - "NLMPC Controller"
Cohesion: 1.0
Nodes (0): 

### Community 18 - "CustomController Header"
Cohesion: 1.0
Nodes (0): 

### Community 19 - "CustomController Source"
Cohesion: 1.0
Nodes (0): 

### Community 20 - "Python Package Init"
Cohesion: 1.0
Nodes (0): 

### Community 21 - "Debug Levels Header"
Cohesion: 1.0
Nodes (0): 

### Community 22 - "Main Entry Point"
Cohesion: 1.0
Nodes (0): 

### Community 23 - "Dynamics Evolution Function"
Cohesion: 1.0
Nodes (1): Evolve the state from t0 to tf given the initial state x0, control input u, and

### Community 24 - "State Derivative Computation"
Cohesion: 1.0
Nodes (1): Compute the derivative of the state.                  Parameters:         - t: C

### Community 25 - "Setup Script"
Cohesion: 1.0
Nodes (0): 

### Community 26 - "Loop Data Parser"
Cohesion: 1.0
Nodes (1): Check that an input line, formatted as "Loop <k>: <data>"      has the expected

### Community 27 - "Trace Portability Script"
Cohesion: 1.0
Nodes (0): 

### Community 28 - "Tests Init"
Cohesion: 1.0
Nodes (0): 

### Community 29 - "Tests Context"
Cohesion: 1.0
Nodes (0): 

### Community 30 - "Eigen Vector Types"
Cohesion: 1.0
Nodes (1): yVec (Eigen output vector type)

### Community 31 - "CustomController Template"
Cohesion: 1.0
Nodes (1): CustomController class (commented out template)

### Community 32 - "Vector Comparison Utility"
Cohesion: 1.0
Nodes (1): assertVectorAlmostLessThan (template function)

### Community 33 - "StatusReader Class"
Cohesion: 1.0
Nodes (1): StatusReader class

### Community 34 - "Controller Dimensions Init"
Cohesion: 1.0
Nodes (0): 

### Community 35 - "Debug Levels Module"
Cohesion: 1.0
Nodes (1): debug_levels module

### Community 36 - "Utils Module"
Cohesion: 1.0
Nodes (1): utils module

### Community 37 - "ScarabData"
Cohesion: 1.0
Nodes (1): ScarabData

### Community 38 - "TimeStepSeries Copy Tests"
Cohesion: 1.0
Nodes (1): TestCopy (TimeStepSeries copy tests)

### Community 39 - "TimeStepSeries Concat Tests"
Cohesion: 1.0
Nodes (1): TestConcatenate (TimeStepSeries concatenation tests)

## Knowledge Gaps
- **89 isolated node(s):** `json_sax_acceptor`, `return t_delay, metadata`, `Check the equality of the *data* EXCLUDING metadata.`, `Check the equality of the time series EXCLUDING metadata.`, `This function overwrites the computation times recorded in the time series.` (+84 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **Thin community `LMPC Controller`** (2 nodes): `LMPCController()`, `LMPCController.h`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `NLMPC Controller`** (2 nodes): `NLMPCController()`, `NLMPCController.h`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `CustomController Header`** (1 nodes): `CustomController.h`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `CustomController Source`** (1 nodes): `CustomController.cpp`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Python Package Init`** (1 nodes): `__init__.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Debug Levels Header`** (1 nodes): `debug_levels.hpp`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Main Entry Point`** (1 nodes): `__main__.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Dynamics Evolution Function`** (1 nodes): `Evolve the state from t0 to tf given the initial state x0, control input u, and`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `State Derivative Computation`** (1 nodes): `Compute the derivative of the state.                  Parameters:         - t: C`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Setup Script`** (1 nodes): `setup.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Loop Data Parser`** (1 nodes): `Check that an input line, formatted as "Loop <k>: <data>"      has the expected`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Trace Portability Script`** (1 nodes): `portabilize_trace.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Tests Init`** (1 nodes): `__init__.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Tests Context`** (1 nodes): `context.py`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Eigen Vector Types`** (1 nodes): `yVec (Eigen output vector type)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `CustomController Template`** (1 nodes): `CustomController class (commented out template)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Vector Comparison Utility`** (1 nodes): `assertVectorAlmostLessThan (template function)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `StatusReader Class`** (1 nodes): `StatusReader class`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Controller Dimensions Init`** (1 nodes): `Controller::initializeDimensions()`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Debug Levels Module`** (1 nodes): `debug_levels module`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `Utils Module`** (1 nodes): `utils module`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `ScarabData`** (1 nodes): `ScarabData`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `TimeStepSeries Copy Tests`** (1 nodes): `TestCopy (TimeStepSeries copy tests)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.
- **Thin community `TimeStepSeries Concat Tests`** (1 nodes): `TestConcatenate (TimeStepSeries concatenation tests)`
  Too small to be a meaningful cluster - may be noise or needs more connections extracted.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `ComputationData` connect `ComputationData & TimeStepSeries` to `Plant Runner & Sim Executor`, `Simulation & Experiment Core`, `Controller Build System`, `Batch Data Structures`, `Controller Interface Layer`, `ExperimentList Management`?**
  _High betweenness centrality (0.100) - this node is a cross-community bridge._
- **Why does `type()` connect `Plant Runner & Sim Executor` to `JSON Library (nlohmann)`, `Simulation & Experiment Core`, `Controller Build System`, `ComputationData & TimeStepSeries`, `Batch Data Structures`, `ACC Dynamics (Python)`, `Utility Functions & Tests`?**
  _High betweenness centrality (0.084) - this node is a cross-community bridge._
- **Why does `TimeStepSeries` connect `ComputationData & TimeStepSeries` to `Plant Runner & Sim Executor`, `Simulation & Experiment Core`, `Batch Data Structures`, `Batcher Iteration Logic`?**
  _High betweenness centrality (0.075) - this node is a cross-community bridge._
- **Are the 43 inferred relationships involving `ComputationData` (e.g. with `TestACCExample` and `TestConsistency`) actually correct?**
  _`ComputationData` has 43 INFERRED edges - model-reasoned connections that need verification._
- **Are the 33 inferred relationships involving `ControllerInterface` (e.g. with `ExperimentList` and `Experiment`) actually correct?**
  _`ControllerInterface` has 33 INFERRED edges - model-reasoned connections that need verification._
- **Are the 33 inferred relationships involving `PipesControllerInterface` (e.g. with `ExperimentList` and `Experiment`) actually correct?**
  _`PipesControllerInterface` has 33 INFERRED edges - model-reasoned connections that need verification._
- **Are the 25 inferred relationships involving `TimeStepSeries` (e.g. with `TestACCExample` and `Test_Simulation_run`) actually correct?**
  _`TimeStepSeries` has 25 INFERRED edges - model-reasoned connections that need verification._