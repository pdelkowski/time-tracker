// Generated by CoffeeScript 1.9.3
(function() {
  'use strict';
  app.service('ActionService', [
    '$document', '$location', function($document, $location) {
      this.getCurrentUrl = function() {
        return $location.absUrl();
      };
    }
  ]);

}).call(this);
