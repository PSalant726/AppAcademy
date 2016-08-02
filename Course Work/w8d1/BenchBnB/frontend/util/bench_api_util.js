const BenchApiUtil = {
  fetchAllBenches(bounds, successCallback){
    $.ajax({
      url: 'api/benches',
      method: 'GET',
      data: {bench: bounds},
      dataType: 'json',
      success: function(response){
        successCallback(response);
      }
    });
  },

  createBench(data, successCallback){
    $.ajax({
      url: 'api/benches',
      method: 'POST',
      data: {bench: data},
      dataType: 'json',
      success: function(response){
        successCallback(response);
      }
    });
  }
};

module.exports = BenchApiUtil;
