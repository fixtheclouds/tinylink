(function () {
  angular.module('app').factory('Links', Factory);

  Factory.$inject = ['$resource'];

  function Factory($resource) {
    return $resource('/links/:id', {}, {
      create: {
        method: 'POST'
      }
    });
  }
})();
