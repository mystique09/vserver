module domain

import time

[table: 'users']
pub struct User {
	id         string    [nonull; primary; unique]
	username   string    [nonull; unique]
	password   string    [nonull]
	email      string    [nonull; unique]
	profile    Profile   [fkey: 'id']
	messages   []Message [fkey: 'user_id']
	created_at time.Time
	updated_at time.Time [sql_type: 'DATETIME']
}

pub struct Profile {
	id   string [primary]
	hash string
}

pub struct CreateUser {
	username string
	password string
	email    string
}

pub interface IUserRepository {
	create_one(payload CreateUser) !User
	get_one(id string) ?User
	get_many(limit int) ?[]User
	delete_one(id string) !User
}
