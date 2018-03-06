require "sqlite3"
	@barbers_name = Array.new
	base = SQLite3::Database.open 'barbershop.db'
	base.execute("SELECT name FROM barbers") do |name|
		@barbers_name << name
	end

	puts @barbers_name.inspect
	@barbers_name.flatten!
	puts @barbers_name.inspect