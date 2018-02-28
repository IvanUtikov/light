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

post '/visit' do
	@name = params['username']
	@phone = params['phone']
	@datetime = params['datetime']
	output = File.open("./public/users1.txt", "a")
	output.write("#{@name} #{@phone} #{@datetime}\n")
	output.close
	erb :visit
end