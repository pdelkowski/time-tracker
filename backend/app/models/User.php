<?php

use Illuminate\Auth\UserTrait;
use Illuminate\Auth\UserInterface;
use Illuminate\Auth\Reminders\RemindableTrait;
use Illuminate\Auth\Reminders\RemindableInterface;

class User extends Eloquent implements UserInterface, RemindableInterface {

	use UserTrait, RemindableTrait;

	/**
	 * The database table used by the model.
	 *
	 * @var string
	 */
	protected $table = 'users';

	/**
	 * The attributes excluded from the model's JSON form.
	 *
	 * @var array
	 */
	protected $hidden = array('password', 'remember_token');

    /**
     * Check if user has already running task
     *
     * @return integer
     */
    public function hasRunningTask()
    {
        $tasks_count = Task::where('user_id', '=', $this->id)->where('state', 'running')->count();
        return $tasks_count;
    }

    /**
     * Return collection of user tasks
     *
     * @return array
     */
    public function getTasks()
    {
        $tasks = Task::where('user_id', '=', $this->id)->get();
        return $tasks;
    }

}
