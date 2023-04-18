module controller

import vweb
import db.pg
import usecase
import domain

struct UserController {
	vweb.Context
	user_usecase domain.IUserUsecase [vweb_global]
}

pub fn new_user_controller(mut db pg.DB) &UserController {
	user_usecase := usecase.new_user_usecase(mut db)
	user_controller := UserController{
		user_usecase: user_usecase
	}
	return &user_controller
}

['/register'; post]
pub fn (mut user_controller UserController) register() vweb.Result {
	// TODO!: get request data
	return user_controller.text('register')
}

['/users']
pub fn (mut user_controller UserController) get_users() vweb.Result {
	users := user_controller.user_usecase.get_many(0, 10) or { []domain.User{} }
	return user_controller.json(users)
}
