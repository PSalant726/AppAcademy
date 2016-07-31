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
  }
};

module.exports = BenchActions;
