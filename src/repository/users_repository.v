module repository

import domain
import pg
import rand
import crypto

struct UserRepository {
	db &pg.DB
}

pub fn new_user_repo(db &pg.DB) &domain.IUserRepository {
	r := UserRepository{db: db}
	return &r
}

fn (repo &UserRepository) create_one(payload &domain.CreateUser) !domain.User {
	user_id := rand.uuid_v4()
	hashed_pass := crypto.bcrypt.generate_from_password(payload.password, crypto.bcrypt.default_cost) or {
		return error('error hashing passord')
	}
	new_user := domain.User{
		id: user_id
		username: payload.username
		password: hashed_pass
		email: payload.email
		profile: domain.Profile {
			id: user_id
			hash: rand.uuid_v4()
		}
	}

	sql repo.db {
		insert new_user into domain.User
	} or {
		return error('error creating user: ${err}')
	}

	return new_user
}

fn (repo &UserRepository) get_one(id string) ?domain.User {
	user := sql repo.db {
		select from domain.User where id == id
	} or {
		return none
	}

	return user
}

fn (repo &UserRepository) get_many(page int, lim int) ?[]domain.User {
	result := sql repo.db {
		select from domain.User
		limit lim
		offset page * 10
	} or {
		return none
	}
	return result
}

fn (repo &UserRepository) delete_one(user_id string) !domain.User {
	result := sql repo.db {
		delete from domain.User where id == user_id
	} or { return error('unable to delete user: ${user_id} err: ${err}')}
	return result
}