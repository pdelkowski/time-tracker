<?php
 
class UserTableSeeder extends Seeder {
 
    public function run()
    {
        DB::table('users')->delete();
 
        User::create(array(
            'username' => 'demo1',
            'password' => Hash::make('qwerty')
        ));
 
        User::create(array(
            'username' => 'demo2',
            'password' => Hash::make('wiosna')
        ));
    }
}

?>
