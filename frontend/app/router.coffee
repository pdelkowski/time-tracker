'use strict'

app.config ['$stateProvider', '$httpProvider', '$urlRouterProvider', '$controllerProvider', '$compileProvider', '$filterProvider', '$provide', '$ocLazyLoadProvider', 'JS_REQUIRES', ($stateProvider, $httpProvider, $urlRouterProvider, $controllerProvider, $compileProvider, $filterProvider, $provide, $ocLazyLoadProvider, jsRequires) ->
  app.controller = $controllerProvider.register
  app.directive = $compileProvider.directive
  app.filter = $filterProvider.register
  app.factory = $provide.factory
  app.service = $provide.service
  app.constant = $provide.constant
  app.value = $provide.value

  app.constant 'API_URL', 'http://localhost:8000/api/v1/'

  # app.config(($httpProvider) ->

  #   getCookie = (name) ->
  #     for cookie in document.cookie.split ';' when cookie and
  #       name is (cookie.trim().split '=')[0]
  #           return decodeURIComponent cookie.trim()[(1 + name.length)...]
  #       null
  #   $httpProvider.defaults.headers.common['X-CSRFToken'] = getCookie("csrftoken")

  #   # These three lines are all you need for CORS support
  #   $httpProvider.defaults.useXDomain = true
  #   $httpProvider.defaults.withCredentials = true
  #   $httpProvider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded; charset=UTF-8'
  #   delete $httpProvider.defaults.headers.common['X-Requested-With']
  # )

  # $httpProvider.defaults.useXDomain = true
  # delete $httpProvider.defaults.headers.common['X-Requested-With']
  $ocLazyLoadProvider.config
    debug: true,
    events: true,
    modules: jsRequires.modules

  $urlRouterProvider.otherwise "/"

  $stateProvider.state 'root',
    abstract: true,
    views:
      'header':
          templateUrl: "partials/header.html",
          controller: 'headerCtrl',
  .state 'homepage',
    parent: 'root',
    url: "/",
    views:
      'content':
        templateUrl: "partials/homepage.html",
        controller: 'homeCtrl',
        resolve:
          tasks: ['$window', '$location', 'UserService', ($window, $location, UserService) ->
            if( !$window.sessionStorage.auth_token )
                $location.path('/login')
            return UserService.tasks()
          ]
          running_task: ['UserService', (UserService) ->
            return UserService.get_running_task()
          ]
  .state 'login',
    parent: 'root',
    url: "/login",
    views:
      'content':
        templateUrl: "partials/login.html",
        controller: 'loginCtrl',
  .state 'logout',
    parent: 'root',
    url: "/logout",
    views:
      'content':
        templateUrl: "partials/login.html",
        controller: 'logoutCtrl',
  #.state 'dashboard',
    #title: 'Dashboard',
    #parent: 'root',
    #url: "/dashboard",
    #views:
      #'content':
          #templateUrl: "partials/dashboard.html",
          #controller: 'dashboardCtrl',
          #resolve:
            #account: ['$window', 'UserService', ($window, UserService) ->
              #username = $window.sessionStorage.user
              #return UserService.profile(username)
            #]
            #events: ['$window', 'UserService', ($window, UserService) ->
              #username = $window.sessionStorage.user
              #return UserService.events(username)
            #]
]
