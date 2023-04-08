module main

import bootstrap
import api.router.v1

fn main() {
	app := bootstrap.new_app()
	defer {
		app.stop()
	}

	mut route := v1.new_router()
	route.setup_routes(app.db.conn)

	app.start(route)
	println('Hello, world!')
}
