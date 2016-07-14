'use strict'

app.controller 'loginCtrl', (['$window', '$location', '$scope', 'UserService', 'StorageService', 'ExceptionMapperService', ($window, $location, $scope, UserService, StorageService, ExceptionMapperService) ->
  # Alerts
  $scope.alerts = []

  $scope.addAlert = (alert_type = 'error', msg = 'Wystąpił błąd') ->
    if alert_type == 'success'
      $scope.alerts.push({alert_type: 'success', msg: msg})

    if alert_type == 'error'
      $scope.alerts.push({type: 'danger', msg: msg})

  $scope.closeAlert = (index) ->
    $scope.alerts.splice(index, 1)

  # Clear form
  ClearForm = () ->
    $scope.userEmail = ''
    $scope.userPassword = ''

  # Login action
  $scope.logIn = () ->
    data =
      username: $scope.userName
      password: $scope.userPassword

    response = UserService.login(data)
    response.success (data, status, headers) ->
      delete $window.sessionStorage.auth_token
      delete $window.sessionStorage.username

      basic_auth_token = StorageService.encrypt_base64($scope.userName + ":" + $scope.userPassword)

      $window.sessionStorage.username = $scope.userName
      $window.sessionStorage.auth_token = basic_auth_token
      $window.location.href = '/'

    .error (data, status, headers) ->
      delete $window.sessionStorage.username
      delete $window.sessionStorage.auth_token
      $scope.alerts = []
      errorMsgs = ExceptionMapperService.parseError(data['msg'])
      for error in errorMsgs
        $scope.addAlert('error', error)
      ClearForm()
])


app.controller 'logoutCtrl', (['$window', '$location', '$scope', ($window, $location, $scope) ->

  delete $window.sessionStorage.username
  delete $window.sessionStorage.auth_token
  $window.location.href = '/'
  # $location.path('/')
])
