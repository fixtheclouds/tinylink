(function () {
  angular.module('app').controller('linksController', Controller);

  Controller.$inject  = ['$scope', 'Links'];

  function Controller($scope, Links) {

    // Vars
    var link = {
      url: null,
      short_url: null,
      http_status: null
    };

    // Scope
    $scope.link = angular.copy(link);
    $scope.latest = null;

    $scope.submit = function () {
      Links.create($scope.link).$promise.then(function (response) {
        UIkit.notify({
          message : 'Short URL has been successfully saved!',
          status  : 'success',
          timeout : 5000,
          pos     : 'bottom-center'
        });
        $scope.latest = {
          url: response.url,
          short_url: window.location.origin + '/' + response.short_url
        };
        $scope.link = angular.copy(link);
        $scope.total += 1;
      }, function (response) {
        response.data.forEach(function (error) {
          UIkit.notify({
            message : error,
            status  : 'danger',
            timeout : 5000,
            pos     : 'bottom-center'
          });
        })
      });
    };

  }
})();
