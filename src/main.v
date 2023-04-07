module main

import bootstrap

fn main() {
	env := bootstrap.new_env()
	app := bootstrap.new_app(env)
	defer {
		app.stop_app()
	}

	app.start_app()
	println('Hello, world!')
}
