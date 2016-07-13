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
        $user_id = Auth::user()->id;

        try {
            $task = Task::findOrFailPermissions($id, $user_id);
        }
        catch( UserPermissionException $e )
        {

            return Response::json(array(
                'error' => true,
                'task' => array('msg' => $e->getMessage())),
                400
            );
        }
        catch( Illuminate\Database\Eloquent\ModelNotFoundException $e )
        {

            return Response::json(array(
                'error' => true,
                'task' => array('msg' => 'Task not found')),
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
        $user = Auth::user();
        $state = Request::get('state');
        $title = Request::get('title');

        try {
            $task = Task::findOrFailPermissions($id, $user->id);

            switch($state)
            {
                case 'pause':
                    $task->pauseTask($title);
                    break;

                case 'stop':
                    $task->stopTask($title);
                    break;

                default:
                    return Response::json(array(
                        'error' => true,
                        'task' => array('msg' => 'Unknown state')),
                        400
                    );
                    break;
            }

        }
        catch( UserPermissionException $e )
        {
            return Response::json(array(
                'error' => true,
                'task' => array('msg' => $e->getMessage())),
                400
            );
        }
        catch( TaskStateException $e )
        {
            return Response::json(array(
                'error' => true,
                'task' => array('msg' => $e->getMessage())),
                400
            );
        }
        catch( Illuminate\Database\Eloquent\ModelNotFoundException $e )
        {
            return Response::json(array(
                'error' => true,
                'task' => array('msg' => 'Task not found')),
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
	 * Remove the specified resource from storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function destroy($id)
	{
        return Response::json(array(),
            405
        );
	}

}
