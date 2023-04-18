module domain

import time

[table: 'messages']
pub struct Message {
	id         int       [nonull; primary; unique]
	user_id    string
	content    string
	seen       bool
	created_at time.Time
	updated_at time.Time
}

pub struct CreateMessage {
	user_id int
	content string
}

pub interface IMessageRepository {
	create_one(payload &CreateMessage) !Message
	get_one(id int) ?Message
	get_many(limit int) ?[]Message
	delete_one(id int) !Message
}
