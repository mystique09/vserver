module v1

import vweb
import os
import db.pg
import controller

pub struct Router {
	vweb.Controller
	vweb.Context
pub mut:
	db pg.DB [vweb_global]
}

pub fn new_router(db pg.DB) &Router {
	mut router := Router{
		db: db
	}
	return &router
}

['/']
pub fn (mut router Router) index() vweb.Result {
	title := 'vweb app'
	return router.text('hsh')

	// return $vweb.html()
}

pub fn (mut router Router) setup_routes() {
	router.mount_static_folder_at(os.resource_abs_path('src/templates'), '/')
	controllers := [
		vweb.controller('/docs', controller.new_docs_controller()),
		vweb.controller('/api/v1', controller.new_user_controller(mut &router.db)),
	]
	router.controllers = controllers
}
