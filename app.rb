require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

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
	@login = params['login']
	@password = params['password']
	if @login == "admin" && @password == 'secret'
		@file = File.open("./public/users.txt", "r")
		erb :admin_page
	else
		erb 'Access denide'
		erb :admin
	end
end

post '/visit' do
	@name = params['username']
	@phone = params['phone']
	@datetime = params['datetime']
	@master = params['master']

	output = File.open("./public/users.txt", "a")
	output.write("#{@name} #{@phone} #{@datetime} #{@master}\n")
	output.close
	erb 'Спасибо, вы записались'
	 
end