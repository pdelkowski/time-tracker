// Generated by CoffeeScript 1.9.3
(function() {
  'use strict';
  app.controller('homeCtrl', [
    '$log', '$window', '$scope', '$location', '$interval', 'UserService', 'tasks', 'running_task', function($log, $window, $scope, $location, $interval, UserService, tasks, running_task) {
      var currentDate, date, date_paused, diff, formatInteger, pauseTimer, pausedSeconds, redrawCounter, resetTimer, startTimer, timer, timerSeconds, updateCounter;
      formatInteger = function(i) {
        var formatted, num;
        num = parseInt(i);
        formatted = ("000" + num).slice(-2);
        return formatted;
      };
      redrawCounter = function(seconds) {
        var hours, minutes;
        if (seconds === 0) {
          return $scope.counter = '00:00:00';
        } else {
          minutes = parseInt(seconds / 60);
          seconds = formatInteger(seconds % 60);
          hours = formatInteger(minutes / 60);
          minutes = formatInteger(minutes % 60);
          return $scope.counter = hours + ':' + minutes + ':' + seconds;
        }
      };
      updateCounter = function(seconds) {
        seconds += 1;
        return redrawCounter(seconds);
      };
      timer = void 0;
      timerSeconds = 0;
      startTimer = function() {
        if (angular.isDefined(timer)) {
          return;
        }
        return timer = $interval((function() {
          timerSeconds += 1;
          redrawCounter(timerSeconds);
        }), 1000);
      };
      pauseTimer = function() {
        if (angular.isDefined(timer)) {
          $interval.cancel(timer);
          timer = void 0;
          $scope.pauseButton = false;
          return $scope.startButton = true;
        }
      };
      resetTimer = function() {
        if (angular.isDefined(timer)) {
          $interval.cancel(timer);
          timer = void 0;
          $scope.pauseButton = false;
          $scope.stopButton = false;
          return $scope.startButton = true;
        }
      };
      $scope.pauseCounter = function() {
        console.log("Pausing counter");
        UserService.pause_task($scope.running.id);
        return pauseTimer();
      };
      $scope.stopCounter = function() {
        console.log("Stopping counter");
        $scope.alerts = [];
        if (!$scope.running.title) {
          return $scope.alerts = ["You need to provide comment to complete this task"];
        } else {
          return UserService.stop_task($scope.running.id, $scope.running.title).then((function(response) {
            $scope.tasks.push(response.data.task);
            resetTimer();
            redrawCounter(0);
            timerSeconds = 0;
            $scope.pauseButton = false;
            $scope.stopButton = false;
            $scope.startButton = true;
            $scope.running = null;
          }), function(response) {
            $scope.alerts = ["There has been an error during stopping task"];
          });
        }
      };
      $scope.startCounter = function() {
        var title;
        console.log("Starting counter");
        $scope.alerts = [];
        if ($scope.running && $scope.running.id) {
          UserService.continue_task($scope.running.id);
        } else {
          title = null;
          if ($scope.running && $scope.running.title) {
            title = $scope.running.title;
          }
          UserService.create(title).then((function(response) {
            $scope.running = response.data.task;
          }), function(response) {
            $scope.alerts = ["There has been an error"];
          });
        }
        startTimer();
        $scope.pauseButton = true;
        $scope.stopButton = true;
        return $scope.startButton = false;
      };
      if (tasks.data.error === true) {
        console.log("there is error");
        $scope.tasks = null;
      } else {
        $scope.tasks = tasks.data.tasks;
      }
      if (running_task.data.error === true) {
        $scope.running = null;
        $scope.startButton = true;
        redrawCounter(0);
      } else {
        $scope.running = running_task.data.task;
        currentDate = moment();
        date = running_task.data.task.created_at;
        diff = moment.duration(currentDate.diff(moment(date)));
        timerSeconds = diff.asSeconds();
        if ($scope.running.state === 'running') {
          $scope.pauseButton = true;
          $scope.stopButton = true;
          console.log('aa: ' + timerSeconds);
          timerSeconds = timerSeconds - $scope.running.paused_duration_sec;
          startTimer();
        } else {
          $scope.startButton = true;
          $scope.stopButton = true;
          date_paused = moment(running_task.data.task.updated_at);
          diff = moment.duration(currentDate.diff(moment(date_paused)));
          pausedSeconds = diff.asSeconds();
          timerSeconds = timerSeconds - pausedSeconds - $scope.running.paused_duration_sec;
          redrawCounter(timerSeconds);
        }
      }
      return $scope.csv_download_link = UserService.get_csv_download_link();
    }
  ]);

}).call(this);
