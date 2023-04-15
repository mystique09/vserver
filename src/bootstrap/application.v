module bootstrap

import api.router.v1
import vweb

pub struct Application {
pub:
	env   Env
	db    Database
	route v1.Router
}

pub fn new_app() &Application {
	env := new_env()
	db := new_db(env)
	route := v1.new_router(db.conn)
	app := Application{
		env: env
		db: db
		route: route
	}
	return &app
}

pub fn (app &Application) start() {
	println('Starting application...')
	app.db.auto_migrate()
	vweb.run_at(app.route, vweb.RunParams{
		host: app.env.host
		port: app.env.port.int()
		family: .ip
	}) or { panic(err) }
}

pub fn (app &Application) stop() {
	println('Gracefully shutting down...')
	app.db.disconnect()
}
