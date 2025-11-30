```bash
sqlite3 data/orders.db \
"INSERT INTO users (username, password) VALUES ('admin', '<PASSWORD_HASH_HERE>');"
