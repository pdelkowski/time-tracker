// Generated by CoffeeScript 1.9.3
(function() {
  'use strict';
  window.app = angular.module("timeTracker", ["timeTrackerDeps"]);

  app.run([
    '$rootScope', '$state', '$stateParams', function($rootScope, $state, $stateParams) {
      $rootScope.$state = $state;
      $rootScope.$stateParams = $stateParams;
      return $rootScope.app = {
        name: 'TimeTracker',
        author: 'Piotr Delkowski',
        version: '1.0',
        year: new Date().getFullYear(),
        isMobile: function() {
          var check;
          if (/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)) {
            check = true;
          } else {
            check = false;
          }
          return check;
        }
      };
    }
  ]);

}).call(this);