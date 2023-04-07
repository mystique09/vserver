module main

import bootstrap

fn main() {
	env := bootstrap.new_env()
	app := bootstrap.new_app(env)
	defer {
		app.stop()
	}

	app.start()
	println('Hello, world!')
}
