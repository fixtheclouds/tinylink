(function () {
  angular.module('app').factory('Links', Factory);

  Factory.$inject = ['$resource'];

  /**
   * RESTful angular resource for Links
   */
  function Factory($resource) {
    return $resource('/links/:id', {}, {
      create: {
        method: 'POST'
      }
    });
  }
})();
