'use strict'

app.controller 'homeCtrl', (['$log', '$window', '$scope', '$location', '$interval', 'UserService', 'tasks', 'running_task', ($log, $window, $scope, $location, $interval, UserService, tasks, running_task) ->
    formatInteger = (i) ->
        num = parseInt(i)
        formatted = ("000" + num).slice(-2)
        return formatted

    redrawCounter = (seconds) ->
        if seconds == 0
            $scope.counter = '00:00:00'
        else
            minutes = parseInt(seconds/60)
            seconds = formatInteger(seconds % 60)
            hours = formatInteger(minutes/60)
            minutes = formatInteger(minutes % 60)
            $scope.counter = hours + ':' + minutes + ':' + seconds

    updateCounter = (seconds) ->
        seconds += 1
        redrawCounter(seconds)

    timer = undefined
    timerSeconds = 0
    startTimer = () ->
        if angular.isDefined(timer)
            return
        timer = $interval((->
            timerSeconds += 1
            redrawCounter(timerSeconds)
            return
            ), 1000)

    pauseTimer = () ->
        if angular.isDefined(timer)
            $interval.cancel timer
            timer = undefined
            $scope.pauseButton = false
            $scope.startButton = true

    resetTimer = () ->
        if angular.isDefined(timer)
            $interval.cancel timer
            timer = undefined
            $scope.pauseButton = false
            $scope.stopButton = false
            $scope.startButton = true


    $scope.pauseCounter = () ->
        console.log "Pausing counter"
        UserService.pause_task($scope.running.id)
        pauseTimer()

    $scope.stopCounter = () ->
        console.log "Stopping counter"
        $scope.alerts = []
        if( !$scope.running.title )
           $scope.alerts = ["You need to provide comment to complete this task"]
        else
            UserService.stop_task($scope.running.id, $scope.running.title).then ((response) ->
              $scope.tasks.push(response.data.task)

              resetTimer()
              redrawCounter(0)
              timerSeconds = 0
              $scope.pauseButton = false
              $scope.stopButton = false
              $scope.startButton = true
              $scope.running = null
              return
            ), (response) ->
              $scope.alerts = ["There has been an error during stopping task"]
              return


    $scope.startCounter = () ->
        console.log "Starting counter"
        $scope.alerts = []
        if( $scope.running and $scope.running.id )
            UserService.continue_task($scope.running.id)
        else
            title = null
            if( $scope.running and $scope.running.title )
                title = $scope.running.title

            UserService.create(title).then ((response) ->
              $scope.running = response.data.task
              return
            ), (response) ->
              $scope.alerts = ["There has been an error"]
              return

        startTimer()
        $scope.pauseButton = true
        $scope.stopButton = true
        $scope.startButton = false

    if tasks.data.error == true
        console.log "there is error"
        $scope.tasks = null
    else
        $scope.tasks = tasks.data.tasks

    if running_task.data.error == true
        $scope.running = null
        $scope.startButton = true
        redrawCounter(0)
    else
        $scope.running = running_task.data.task

        date = new Date(running_task.data.task.created_at)
        currentDate = new Date()
        milisecondsDiff = currentDate-date
        timerSeconds = milisecondsDiff/1000

        if( $scope.running.state == 'running' )
            $scope.pauseButton = true
            $scope.stopButton = true

            timerSeconds = timerSeconds-$scope.running.paused_duration_sec

            startTimer()
        else # paused
            $scope.startButton = true
            $scope.stopButton = true

            date_paused = new Date(running_task.data.task.updated_at)
            milisecondsDiff = currentDate-date_paused
            pausedSeconds = milisecondsDiff/1000
            timerSeconds = timerSeconds-pausedSeconds-$scope.running.paused_duration_sec

            redrawCounter(timerSeconds)

    $scope.csv_download_link = UserService.get_csv_download_link()
])
