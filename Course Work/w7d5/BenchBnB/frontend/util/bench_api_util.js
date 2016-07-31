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
  }
};

module.exports = BenchApiUtil;
