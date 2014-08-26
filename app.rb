require 'sinatra/activerecord'
require 'sinatra'
require './models'

set :database, "sqlite3:development.sqlite3"

require 'bundler/setup'
require 'rack-flash'
enable :sessions
use Rack::Flash, :sweep => true

set :sessions, true
# session[:user_id] = @user.id

def current_user
	if session[:user_id]
		@current_user = User.find(session[:user_id])	 
	end
end 

get '/' do 
	erb :home
end

post '/sign-in' do
	@user = User.where(email: params[:email]).first
	if @user.password == params[:password]
		redirect "/"
	else
		flash[:notice] = "WRONG PASSWORD SILLY"
end 
end 
