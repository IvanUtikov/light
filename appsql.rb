require 'sqlite3'
db = SQLite3::Database.new 'test.sqlite'


#add item to db
#db.execute "INSERT INTO Cars (Name, Price) VALUES ('Jaguar', 15000)"

db.execute "SELECT * FROM Cars" do |car|

	puts car
	puts '====='
end


db.close