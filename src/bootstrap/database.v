module bootstrap

// TODO!: connect to postgresql
pub struct Database {}

pub fn new_db() &Database {
	db := Database{}
	return &db
}

pub fn (db &Database) connect() {
	println('Connecting database...')
}

pub fn (db &Database) disconnect() {
	println('Gracefully shuttingdown database connection...')
}
