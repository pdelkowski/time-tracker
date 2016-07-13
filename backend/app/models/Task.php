<?php
 
class Task extends Eloquent {
 
    protected $table = 'tasks';
 
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
}
