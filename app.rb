require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def create_users_table
	base = SQLite3::Database.open 'barbershop.db'
	base.execute('CREATE TABLE IF NOT EXISTS 
		"Users" 
		(
			"Id" INTEGER PRIMARY KEY AUTOINCREMENT, 
			"Name" VARCHAR, 
			"Phone" VARCHAR, 
			"DateStamp" VARCHAR, 
			"Barber" VARCHAR, 
			"Color" VARCHAR
		)')
end

def get_users_table
	@arr = Array.new
	base = SQLite3::Database.open 'barbershop.db'
	base.execute('SELECT * FROM "Users"') do |row|
		@arr << row
	end
	return @arr
end

def drop_users_table
	base = SQLite3::Database.open 'barbershop.db'
	base.execute('DROP TABLE "Users"')
	base = create_users_table
	@arr = Array.new
	return @arr
end

def create_barbers_table
	base = SQLite3::Database.open 'barbershop.db'
	base.execute('CREATE TABLE IF NOT EXISTS 
		"barbers"
		(
			"id" INTEGER PRIMARY KEY AUTOINCREMENT,
			"name" VARCHAR
		)')

	arr_check = []
	arr_barbers = ['Walter White', 'Jessie Pinkman', 'Gus Fring']
		
	base.execute('SELECT "name" FROM "barbers"') do |barber|
		arr_check << barber
	end

	if arr_check.empty?
		arr_barbers.each do |barber|
		base.execute('INSERT INTO barbers ("name") values (?)', [barber])
		end
	end
	return base 	
end

def get_barbers_name
	barbers_name = Array.new
	base = SQLite3::Database.open 'barbershop.db'
	base.execute('SELECT name FROM "barbers"') do |name|
		barbers_name << name
	end
	barbers_name.flatten!
end

def record_user_to_table(name, phone, datetime, master, color)
	base = SQLite3::Database.open 'barbershop.db'
	base.execute 'INSERT INTO
				"Users"
				(
					"Name",
					"Phone",
					"DateStamp",
					"Barber",
					"color"
				) 
				  VALUES (?, ?, ?, ?, ?)', [name, phone, datetime, master, color]	

end

configure do
	users_table = create_users_table
	barbers_table = create_barbers_table	
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>!!!"			
end

get '/aboutus' do
	erb :about
end

get '/visit' do
	@barbers_name = get_barbers_name
	erb :visit
end

get '/contact' do
	erb :contact
end

get '/admin' do
	erb :admin
end

post '/admin' do
	login = params[:login]
	password = params[:password]
	
	if login == 'admin' && password == 'secret' 
		@arr = get_users_table
		return erb :admin_page
	elsif params[:clean]
		@arr = drop_users_table
		erb :admin_page
	else
		@msg = "ACCESS DENIED"
		return erb :admin
	end
end

post '/visit' do
	@name = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@master = params[:master]
	@color = params[:color]
	@selected = params[:selected]
	er = String.new
	hh = {
		  :username => 'Enter name',
	 	  :phone => 'Enter phone',
	      :datetime => 'Enter date and time'
	     }

	@barbers_name = get_barbers_name

	er = hh.select{|k| params[k]==''}.values.join(', ')     

	unless er.empty?
		@error = er
		return erb :visit
	end

	record_user_to_table(@name, @phone, @datetime, @master, @color)
	erb 'Спасибо, вы записались'
 
end