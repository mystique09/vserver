module domain

import time

[table: 'users']
pub struct User {
	id         int       [nonull; primary; unique]
	username   string    [nonull; unique]
	password   string    [nonull]
	email      string    [nonull; unique]
	profile    Profile   [fkey: 'id']
	messages   []Message [fkey: 'user_id']
	created_at time.Time
	updated_at time.Time
}

[table: 'profiles']
pub struct Profile {
	id   int    [nonnull; primary]
	hash string
}

pub struct CreateUser {
pub:
	username string
	password string
	email    string
}

pub interface IUserRepository {
	create_one(payload &CreateUser) !User
	get_one(id int) ?User
	get_many(page int, limit int) ?[]User
}

pub interface IUserUsecase {
	create_one(payload &CreateUser) !User
	get_one(id int) ?User
	get_many(page int, limit int) ?[]User
}
