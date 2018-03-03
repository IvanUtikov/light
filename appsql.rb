require 'sqlite3'
db = SQLite3::Database.new 'test.sqlite'

db.execute "INSERT INTO Cars (Name, Price) VALUES ('Jaguar', 15000)"

db.close