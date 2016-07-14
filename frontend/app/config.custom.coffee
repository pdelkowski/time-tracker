'use strict'

app.factory 'authInterceptor', ($rootScope, $q, $window, $location) ->
  {
    request: (config) ->
      # config.headers = {}
      if $window.sessionStorage.auth_token
          config.headers.Authorization = 'Basic ' + $window.sessionStorage.auth_token

      config
    response: (response) ->
      if response.status == 401
        delete $window.sessionStorage.username
        delete $window.sessionStorage.password
        $location.path('/login')
      else
      response or $q.when(response)
  }

app.config ($httpProvider, $locationProvider, $logProvider) ->
  $httpProvider.interceptors.push 'authInterceptor'
  #$locationProvider.html5Mode(true).hashPrefix('!')
  return
