<?php

use Carbon\Carbon;
 
class Task extends Eloquent {
 
    protected $table = 'tasks';

    /**
     * Extend Eloquent findOrFail() method to incorporate user permissions
     *
     * @return Task
     */
    public static function findOrFailPermissions($id, $user_id)
    {
        $task = Task::findOrFail($id);
        if( !$task->isUserOwner($user_id) )
        {
            throw new UserPermissionException("User does not have permissions for this action");
        }
        return $task;
    }
 
    /**
     * Check if user is owner of particular task
     *
     * @return bool
     */
    public function isUserOwner($user_id)
    {
        if( $user_id == $this->user_id )
            return true;
        return false;
    }

    /**
     * Stop the running task, and save it
     *
     * @return Task
     */
    public function stopTask($title=null)
    {
        if( $title == null )
        {
            if( $this->title == null )
                throw new TaskStateException("You need to provide comment to save the task");

        } else {
            $this->title = $title;
        }

        if( $this->state == 'completed' )
            throw new TaskStateException("This task has been already stopped");

        $this->state = 'completed';
        $this->completed_at = Carbon::now();
        $this->duration = $this->_calculateDuration();
        $this->save();
        return $this;
    }

    /**
     * Pause the running task, and save it
     *
     * @return Task
     */
    public function pauseTask($title=null)
    {
        if( $title != null)
            $this->title = $title;

        if( $this->state == 'completed' )
            throw new TaskStateException("This task has been already stopped");

        $this->state = 'paused';
        $this->save();
        return $this;
    }
    
    /**
     * Calculate task duration, returns in minutes
     * Remember to set completed_at first!!!
     *
     * @return integer
     */
    protected function _calculateDuration()
    {
        if( $this->completed_at == null )
            throw new \Exception("Cannot calcuate time difference because completed_at is not set");

        $diff = $this->created_at->diffInMinutes($this->completed_at);
        return $diff;
    }
}
