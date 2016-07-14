### About

TimeTracker allows you to track your work time

* You can pause any time,
* You can continue any time,
* Job title can be entered during start or finish task,
* User accounts,
* CSV last week export,
* List of your last week tasks,

### Installation
Unzip archive

##### Backend
TimeTracker requires [Laravel 4.2] to run.
Also, DB driver.

For sqlite (default DB) on Debian-ish system

```sh
$ sudo apt-get install -y php5-sqlite
```

```sh
$ cd backend
$ php composer.phar update
$ php artisan migrate
```

For some dummy data (user: demo1, password: qwerty)
```sh
php artisan db:seed
```

Run server (port :8000)
```sh
php artisan serve
```

##### Frontend
AngularJS requires only HTTP server (by default, listens to port :8000), example
```sh
$ cd frontend
$ php5 -S localhost:8001
```

### Development

* Very poor error handling on frontend side,
* Cannot fetch data from different dates than current week
* Unittests!!!
* ... and a lot more
