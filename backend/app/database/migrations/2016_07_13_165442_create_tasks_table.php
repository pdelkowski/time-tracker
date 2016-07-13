<?php

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTasksTable extends Migration {

	/**
	 * Run the migrations.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('tasks', function(Blueprint $table)
		{
            $table->increments('id');
            $table->integer('user_id');
            $table->string('title')->nullable();
            $table->bigInteger('duration')->nullable();
            $table->enum('state', array('running', 'completed', 'paused'))->default('running');
            $table->timestamp('completed_at')->nullable();
            $table->timestamps();
		});
	}

	/**
	 * Reverse the migrations.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('tasks', function(Blueprint $table)
		{
			//
		});
	}

}
