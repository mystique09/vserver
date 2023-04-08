module bootstrap

import os
import zztkm.vdotenv

pub struct Env {
pub:
	auth_secret          string
	db_username          string
	db_pass              string
	db_host              string
	db_port              string
	db_name              string
	host                 string
	port                 string
	access_token_secret  string
	refresh_token_secret string
	client_url           string
}

pub fn new_env() &Env {
	vdotenv.load()

	auth_secret := os.getenv_opt('AUTH_SECRET') or { 'thisismyauthsecret' }
	db_username := os.getenv_opt('DB_USERNAME') or { 'root' }
	db_pass := os.getenv_opt('DB_PASS') or { 'secret' }
	db_host := os.getenv_opt('DB_HOST') or { 'localhost' }
	db_port := os.getenv_opt('DB_PORT') or { '5432' }
	db_name := os.getenv_opt('DB_NAME') or { 'vserver-db' }

	host := os.getenv_opt('HOST') or { '0.0.0.0' }
	port := os.getenv_opt('PORT') or { '8000' }
	access_token_secret := os.getenv_opt('ACCESS_TOKEN_SECRET') or { 'thisismyaccesssecret' }
	refresh_token_secret := os.getenv_opt('REFRESH_TOKEN_SECRET') or { 'thisismyrefreshsecret' }
	client_url := os.getenv('CLIENT_URL')

	env := Env{auth_secret, db_username, db_pass, db_host, db_port, db_name, host, port, access_token_secret, refresh_token_secret, client_url}
	return &env
}
