const Store = require("flux/utils").Store;
const AppDispatcher = require('../dispatcher/dispatcher.js');
const BenchConstants = require('../constants/bench_constants.js');

const BenchStore = new Store(AppDispatcher);

let _benches = {};

BenchStore.all = function(){
  let benches = {};
  return Object.assign(benches, _benches);
};

BenchStore.resetAllBenches = function(benches){
  // _benches = benches;
  _benches = {};
  benches.forEach(bench => {
    _benches[bench.id] = bench;
  });
};

BenchStore.resetSingleBench = function(bench){
  _benches[bench.id] = bench;
};

BenchStore.__onDispatch = function(payload){
  switch (payload.actionType) {
    case BenchConstants.BENCHES_RECEIVED:
      BenchStore.resetAllBenches(payload.benches);
      BenchStore.__emitChange();
      break;
    case BenchConstants.BENCH_RECEIVED:
      BenchStore.resetSingleBench(payload.bench);
      BenchStore.__emitChange();
      break;
  }
};

module.exports = BenchStore;
