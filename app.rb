require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

configure do
	@db = SQLite3::Database.new('barbershop.db')
	@db.execute 'CREATE TABLE IF NOT EXISTS 
		"Users" 
		(
			"Id" INTEGER PRIMARY KEY AUTOINCREMENT, 
			"Name" VARCHAR, 
			"Phone" VARCHAR, 
			"DateStamp" VARCHAR, 
			"Barber" VARCHAR, 
			"Color" VARCHAR
		)'
		
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>!!!"			
end

get '/aboutus' do
	erb :about

end

get '/visit' do
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
		file = File.open("./public/users.txt", "r")
		@arr = Array.new
		while (line = file.gets)
			@arr << line.split(';')
		end
		file.close
		return erb :admin_page
	elsif params[:clean]
		file = File.open("./public/users.txt", "wb")
		file.write('')
		file.close
		file = File.open("./public/users.txt", "r")
		@arr = Array.new
		while (line = file.gets)
			@arr << line.split(';')
		end
		file.close
		return erb :admin_page	
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
	hh = {:username => 'Enter name',
	 	  :phone => 'Enter phone',
	      :datetime => 'Enter date and time'}
	

	er = hh.select{|k| params[k]==''}.values.join(', ')     

	unless er.empty?
		@error = er
		return erb :visit
	end

	output = File.open("./public/users.txt", "a")
	output.write("#{@name};#{@phone};#{@datetime};#{@master};#{@color}\n")
	output.close
	erb 'Спасибо, вы записались'
 
end






