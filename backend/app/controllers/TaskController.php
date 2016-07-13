<?php

class TaskController extends \BaseController {

	/**
	 * Display a listing of the resource.
	 *
	 * @return Response
	 */
	public function index()
	{
        $user = Auth::user();
        $tasks = $user->getTasks();

        return Response::json(array(
            'error' => false,
            'tasks' => $tasks->toArray()),
            200
        );
	}


	/**
	 * Store a newly created resource in storage.
	 *
	 * @return Response
	 */
	public function store()
	{
        $user = Auth::user();

        if( $user->hasRunningTask() )
        {
            return Response::json(array(
                'error' => true,
                'task' => array('msg' => 'You already have a running task')),
                422
            );
        }   

        $task = new Task;
        $task->user_id = $user->id;
        $task->title = Request::get('title');
     
        // Validation and Filtering is sorely needed!!
        // Seriously, I'm a bad person for leaving that out.
     
        $task->save();
     
        return Response::json(array(
            'error' => false,
            'task' => $task->toArray()),
            200
        );
	}


	/**
	 * Display the specified resource.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function show($id)
	{
        $user = Auth::user()->id;

        try {
            $task = Task::findOrFail($id);
        }
        catch( Illuminate\Database\Eloquent\ModelNotFoundException $e )
        {
            return Response::json(array(
                'error' => true,
                'task' => array('msg' => 'Task not found')),
                400
            );
        }
        
        if( !$task->isUserOwner($user) )
        {
            return Response::json(array(
                'error' => true,
                'task' => $task->toArray()),
                400
            );
        }

        return Response::json(array(
            'error' => false,
            'task' => $task->toArray()),
            200
        );
        
	}


	/**
	 * Update the specified resource in storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function update($id)
	{
		
	}


	/**
	 * Remove the specified resource from storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function destroy($id)
	{
		//
	}


}
