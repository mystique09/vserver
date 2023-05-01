module main

import bootstrap

fn main() {
	mut app := bootstrap.new_app()
	defer {
		app.stop()
	}

	app.start()
}
