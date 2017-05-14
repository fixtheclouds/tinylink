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
    $scope.loading = false;

    $scope.submit = function () {
      $scope.loading = true;
      Links.create($scope.link).$promise.then(function (response) {
        $scope.loading = false;
        UIkit.notify({
          message : 'Short URL has been successfully saved!',
          status  : 'success',
          timeout : 5000,
          pos     : 'bottom-center'
        });
        $scope.latest = {
          short_url: response.url
        };
        $scope.link = angular.copy(link);
        $scope.total += 1;
      }, function (response) {
        $scope.loading = false;
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

    // Pattern to match valid short URL characters
    $scope.shortUrlRegex = /^[\$\-_.+!*'(),a-zA-Z\d]{1,8}$/;

    /**
     * Full URL validator;
     * @link https://regex101.com/library/eN9vI3
     */
    $scope.urlRegex = /^(http|ftp|https)?(\:\/\/)?[\w-]+(\.[\w-]+)+([\w.,@?^!=%&amp;:\/~+#-]*[\w@?^=%&amp;\/~+#-])+$/;

  }
})();
