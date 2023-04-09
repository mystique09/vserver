module domain

import time

[table: 'messages']
pub struct Message {
	id         string    [nonull; primary; unique]
	user_id    string
	content    string
	seen       bool
	created_at time.Time
	updated_at time.Time [sql_type: 'DATETIME']
}

pub struct CreateMessage {
	user_id string
	content string
}

pub interface IMessageRepository {
	create_one(payload CreateMessage) !Message
	get_one(id string) ?Message
	get_many(limit int) ?[]Message
	delete_one(id string) !Message
}
