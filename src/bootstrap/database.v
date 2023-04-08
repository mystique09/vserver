module bootstrap

import db.pg

// TODO!: connect to postgresql
pub struct Database {
	conn pg.DB
}

pub fn new_db(env &Env) &Database {
	config := db.Config{
		host: env.db_host
		port: env.db_port
		user: env.db_username
		password: env.db_pass
		dbname: env.db_name
	}
	conn := pg.connect(config)
	db := Database{conn}
	return &db
}

pub fn (db &Database) connect() {
	println('Connecting database...')
}

pub fn (db &Database) disconnect() {
	println('Gracefully shuttingdown database connection...')
	db.conn.close()
}
