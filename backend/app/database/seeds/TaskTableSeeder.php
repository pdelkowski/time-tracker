<?php

use Carbon\Carbon;
 
class TaskTableSeeder extends Seeder {
 
    public function run()
    {
        DB::table('tasks')->delete();

        $user_id = DB::table('users')->where('username', '=', 'demo1')->first()->id;
        $user2_id = DB::table('users')->where('username', '=', 'demo2')->first()->id;
 
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
            'duration' => 20,
            'state' => 'completed',
            'completed_at' => Carbon::now()
        ));

        Task::create(array(
            'user_id' => $user_id,
            'title' => 'Test task 3',
            'duration' => 120,
            'state' => 'completed',
            'completed_at' => Carbon::now()
        ));

        Task::create(array(
            'user_id' => $user2_id,
            'title' => 'Demo2 user task',
        ));
 
    }
}

?> 
