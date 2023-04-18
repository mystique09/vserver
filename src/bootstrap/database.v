module bootstrap

import db.pg
import domain

pub struct Database {
pub:
	conn pg.DB
}

pub fn new_db(env &Env) &Database {
	config := pg.Config{
		host: env.db_host
		port: env.db_port.int()
		user: env.db_username
		password: env.db_pass
		dbname: env.db_name
	}
	conn := pg.connect(config) or { panic(err) }
	db := Database{conn}
	return &db
}

pub fn (db &Database) auto_migrate() {
	println('migrating database...')
	sql db.conn {
		create table domain.User
		create table domain.Profile
		create table domain.Message
	} or { println('error migrating: ${err}') }
	println('migrated')
}

pub fn (db &Database) disconnect() {
	println('Gracefully shuttingdown database connection...')
	db.conn.close()
}
