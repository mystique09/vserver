module main

import bootstrap

fn main() {
	app := bootstrap.new_app()
	defer {
		app.stop()
	}

	app.start()
}
