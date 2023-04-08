module v1

import vweb
import os
import db.pg

pub struct Router {
	vweb.Controller
	vweb.Context
pub mut:
	db pg.DB [vweb_global]
}

pub fn new_router() &Router {
	mut router := Router{}
	router.mount_static_folder_at(os.resource_abs_path('.'), '/')
	return &router
}

['/']
pub fn (mut router Router) index() vweb.Result {
	return router.text('hello, world')
}

pub fn (mut router Router) setup_routes(db pg.DB) {
	controllers := [
		vweb.controller('/docs', &DocsController{}),
	]
	router.db = db
	router.controllers = controllers
}

struct DocsController {
	vweb.Context
}

['/']
pub fn (mut docs DocsController) index() vweb.Result {
	return docs.text('documentation for vserver')
}
