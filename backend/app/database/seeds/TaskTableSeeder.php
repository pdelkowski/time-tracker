<?php

use Carbon\Carbon;
 
class TaskTableSeeder extends Seeder {
 
    public function run()
    {
        DB::table('tasks')->delete();

        $user_id = DB::table('users')->where('username', '=', 'demo1')->first()->id;
 
        Task::create(array(
            'user_id' => $user_id,
            'title' => 'Test task 1',
            'duration' => 45,
            'state' => 'completed',
            'completed_at' => Carbon::now()
        ));

        Task::create(array(
            'user_id' => $user_id,
            'title' => 'Test task 2',
        ));
 
    }
}

?> 
