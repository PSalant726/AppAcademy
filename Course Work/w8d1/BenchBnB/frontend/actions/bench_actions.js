const BenchApiUtil = require('../util/bench_api_util');
const AppDispatcher = require('../dispatcher/dispatcher.js');
const BenchConstants = require('../constants/bench_constants.js');

const BenchActions = {
  fetchAllBenches(bounds){
    BenchApiUtil.fetchAllBenches(bounds, BenchActions.receiveAllBenches);
  },

  receiveAllBenches(benches){
    AppDispatcher.dispatch({
      actionType: BenchConstants.BENCHES_RECEIVED,
      benches: benches
    });
  },

  createBench(data){
    BenchApiUtil.createBench(data, BenchActions.receiveSingleBench);
  },

  receiveSingleBench(bench){
    AppDispatcher.dispatch({
      actionType: BenchConstants.BENCH_RECEIVED,
      bench: bench
    });
  }
};

module.exports = BenchActions;
