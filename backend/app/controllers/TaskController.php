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
        $tasks = $user->getCompletedTasks();

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

        $validator = $this->_getValidator(Input::all());
        if( $validator->fails() )
            return Response::json(array(
                'error' => true,
                'msg' => $validator->messages()),
                400
            );

        if( $user->hasRunningTask() )
        {
            return Response::json(array(
                'error' => true,
                'task' => array('msg' => 'You already have a running task')),
                422
            );
        }   

        $title = Input::get('title');

        $task = new Task;
        $task->user_id = $user->id;
        $task->title = $title;
     
        $task->save();
     
        return Response::json(array(
            'error' => false,
            'task' => $task->toArray()),
            201
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
                'msg' => $e->getMessage()),
                400
            );
        }
        catch( Illuminate\Database\Eloquent\ModelNotFoundException $e )
        {

            return Response::json(array(
                'error' => true,
                'msg' => 'Task not found'),
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

        $validator = $this->_getValidator(Input::all());
        if( $validator->fails() )
            return Response::json(array(
                'error' => true,
                'msg' => $validator->messages()),
                400
            );

        $state = Input::get('state');
        $title = Input::get('title');

        try {
            $task = Task::findOrFailPermissions($id, $user->id);

            switch($state)
            {
                case 'continue':
                    $task->continueTask($title);
                    break;

                case 'pause':
                    $task->pauseTask($title);
                    break;

                case 'stop':
                    $task->stopTask($title);
                    break;

                default:
                    return Response::json(array(
                        'error' => true,
                        'msg' => 'Unknown state'),
                        400
                    );
                    break;
            }

        }
        catch( UserPermissionException $e )
        {
            return Response::json(array(
                'error' => true,
                'msg' => $e->getMessage()),
                400
            );
        }
        catch( TaskStateException $e )
        {
            return Response::json(array(
                'error' => true,
                'msg' => $e->getMessage()),
                400
            );
        }
        catch( Illuminate\Database\Eloquent\ModelNotFoundException $e )
        {
            return Response::json(array(
                'error' => true,
                'msg' => 'Task not found'),
                404
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
        App::abort(405);
	}

	/**
	 * Show currently running task
	 *
	 * @return Response
	 */
	public function current()
	{
        $user = Auth::user();
        $task = $user->getRunningTask();

        if( $task )
        {
            return Response::json(array(
                'error' => false,
                'task' => $task->toArray()),
                200
            );
        } else {
            return Response::json(array(
                'error' => true,
                'msg' => 'Task not found'),
                200
            );
        }

	}

	/**
	 * Get input validator for a view
	 *
	 * @param  array   $input
	 * @return Illuminate\Validation\Validator
	 */
    public function _getValidator($input)
    {
        // Get the function name, of function that called this function
        $trace=debug_backtrace(); 
        $view = $trace[1]["function"];

        switch($view)
        {
            case 'store':
                $validator = Validator::make($input,
                    array(
                        'title' => 'max:255',
                    )
                ); 
                break;

            case 'update':
                $validator = Validator::make($input,
                    array(
                        'state' => 'required|in:pause,stop,continue',
                        'name' => 'max:255',
                    )
                ); 
                break;

            default:
                $validator = null;
        }
        return $validator;
    }

}
