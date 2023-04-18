module repository

import domain
import db.pg
import rand
// import crypto.bcrypt

pub struct UserRepository {
pub mut:
	db pg.DB
}

pub fn new_user_repo(mut db pg.DB) &domain.IUserRepository {
	r := UserRepository{
		db: db
	}
	return &r
}

pub fn (repo &UserRepository) create_one(payload &domain.CreateUser) !domain.User {
	user_id := 1

	// TODO: fix
	/*
	hashed_pass := bcrypt.generate_from_password(payload.password, bcrypt.default_cost) or {
		return error('error hashing passord')
	}*/

	new_user := domain.User{
		id: user_id
		username: payload.username
		password: payload.password
		email: payload.email
		profile: domain.Profile{
			id: user_id
			hash: rand.uuid_v4()
		}
	}

	sql repo.db {
		insert new_user into domain.User
	} or { return error('error creating user: ${err}') }

	return new_user
}

pub fn (repo &UserRepository) get_one(id int) ?domain.User {
	user := sql repo.db {
		select from domain.User where id == id
	} or { return none }

	return user[0]
}

pub fn (repo &UserRepository) get_many(page int, lim int) ?[]domain.User {
	result := sql repo.db {
		select from domain.User limit lim offset page
	} or { return none }
	return result
}
