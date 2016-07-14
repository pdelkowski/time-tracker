'use strict'

app.controller 'headerCtrl', ['$window', '$scope', ($window, $scope) ->
  if( $window.sessionStorage.username )
    $scope.authed = true
  else
    $scope.authed = false
]
