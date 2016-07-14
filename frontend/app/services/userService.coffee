'use strict'

app.service 'UserService', ['$http', '$q', '$rootScope', 'API_URL', ($http, $q, $rootScope, API_URL) ->
  @create = (title) ->
    return $http.post API_URL + 'task', {"title": title}

  @login = (credentials) ->
    return $http.post(API_URL + 'auth', credentials)

  @tasks = () ->
    return $http.get(API_URL + 'task')

  @get_running_task = () ->
    return $http.get(API_URL + 'task/current')

  @pause_task = ($task_id) ->
    return $http.put(API_URL + 'task/' + $task_id, {"state": "pause"})

  @stop_task = ($task_id, title) ->
    return $http.put(API_URL + 'task/' + $task_id, {"state": "stop", "title": title})

  @continue_task = ($task_id) ->
    return $http.put(API_URL + 'task/' + $task_id, {"state": "continue"})

  @get_csv_download_link = () ->
    return (API_URL + 'task/csv')

  return
]
