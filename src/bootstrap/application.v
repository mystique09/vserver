module bootstrap

struct Application {
pub:
	env Env
	db  Database
}

pub fn new_app(env &Env) &Application {
	db := new_db()
	app := Application{
		env: env
		db: db
	}
	return &app
}

pub fn (app &Application) start() {
	app.db.connect()
	println('Starting application...')
}

pub fn (app &Application) stop() {
	app.db.disconnect()
	println('Gracefully shutting down...')
}
