module controller

import vweb

struct UserController {
	vweb.Context
}

pub fn new_user_controller() &UserController {
	user_controller := UserController{}
	return &user_controller
}

['/']
pub fn (mut user_controller UserController) get_users() vweb.Result {
	return user_controller.text('user controller')
}
