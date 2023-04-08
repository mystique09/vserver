module bootstrap

import api.router.v1
import vweb

pub struct Application {
pub:
	env Env
	db  Database
}

pub fn new_app() &Application {
	env := new_env()
	db := new_db(env)
	app := Application{
		env: env
		db: db
	}
	return &app
}

pub fn (app &Application) start(route v1.Router) {
	println('Starting application...')
	vweb.run_at(route, vweb.RunParams{
		host: app.env.host
		port: app.env.port.int()
		family: .ip
	}) or { panic(err) }
}

pub fn (app &Application) stop() {
	println('Gracefully shutting down...')
	app.db.disconnect()
}
