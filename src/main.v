module main

import vweb

struct App {
	vweb.Context
}

fn new_app() &App {
	mut app := &App{}
	return app
}

['/']
pub fn (mut app App) index() vweb.Result {
	return app.text('Hello, World!')
}

fn main() {
	vweb.run_at(new_app(), vweb.RunParams{
		port: 8000
	}) or { panic(err) }
}