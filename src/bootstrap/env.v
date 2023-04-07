module bootstrap

import os
import zztkm.vdotenv

pub struct Env {
pub:
	auth_secret          string
	db_url               string
	host                 string
	port                 string
	access_token_secret  string
	refresh_token_secret string
	client_url           string
}

/*
* This doesn't work for now, it can't read the environment variavles from .env file.
* TODO!: make a fcking parser or find a dotenv lib
*/
pub fn new_env() &Env {
	vdotenv.load()

	auth_secret := os.getenv_opt('AUTH_SECRET') or { 'thisismyauthsecret' }
	db_url := os.getenv_opt('DATABASE_URL') or {
		println('no db url')
		'postgresql://root:secret@localhost:5432/cnfs-v?sslmode=disable'
	}
	host := os.getenv_opt('HOST') or { '0.0.0.0' }
	port := os.getenv_opt('PORT') or { '8000' }
	access_token_secret := os.getenv_opt('ACCESS_TOKEN_SECRET') or { 'thisismyaccesssecret' }
	refresh_token_secret := os.getenv_opt('REFRESH_TOKEN_SECRET') or { 'thisismyrefreshsecret' }
	client_url := os.getenv('CLIENT_URL')

	env := Env{auth_secret, db_url, host, port, access_token_secret, refresh_token_secret, client_url}
	return &env
}
