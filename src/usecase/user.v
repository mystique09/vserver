module usecase

import repository
import domain
import db.pg

pub struct UserUsecase {
pub:
	repo domain.IUserRepository
}

pub fn new_user_usecase(mut db pg.DB) &domain.IUserUsecase {
	repo := repository.new_user_repo(mut db)
	return UserUsecase{repo}
}

pub fn (usecase &UserUsecase) create_one(payload &domain.CreateUser) !domain.User {
	return usecase.repo.create_one(payload)
}

pub fn (usecase &UserUsecase) get_one(id int) ?domain.User {
	return usecase.repo.get_one(id)
}

pub fn (usecase &UserUsecase) get_many(page int, lim int) ?[]domain.User {
	return usecase.repo.get_many(page, lim)
}
