<?php

class AuthController extends \BaseController {

	/**
	 * Display a listing of the resource.
	 *
	 * @return Response
	 */
	public function index()
	{
        App::abort(405);
	}


	/**
	 * Store a newly created resource in storage.
	 *
	 * @return Response
	 */
	public function store()
	{
        $validator = Validator::make(Input::all(),
            array(
                'username' => 'required|max:255',
                'password' => 'required|max:255',
            )
        ); 

        if($validator->fails())
        {
            return Response::json(array(
                'error' => true,
                'msg' => $validator->messages()),
                400
            );
        }

        $credentials = Input::only('username', 'password');

       if (!Auth::validate($credentials))
        {
            return Response::json(array(
                'error' => true,
                'msg' => "Wrong credentials"),
                400
            );
        } 

        return Response::json(array(
            'error' => false,
            'user' => $credentials['username']),
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
        App::abort(405);
	}


	/**
	 * Update the specified resource in storage.
	 *
	 * @param  int  $id
	 * @return Response
	 */
	public function update($id)
	{
        App::abort(405);
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


}
