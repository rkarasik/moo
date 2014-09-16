require 'sinatra/activerecord'
require 'sinatra'
require './models'

set :database, "sqlite3:development.sqlite3"

configure(:developemt){set :database, "sqlite:blog.sqlite3"}

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

# def password
# 	if session[:]

get '/' do 
	erb :home
end

# get "/users/:id" do
# 	params[:id]
# 	#localhost:4567/users/2
# 	# @user = User.find(params[:id])
# end

post '/sign-in' do
	@user = User.where(email: params[:email]).first
	if @user && @user.password == params[:password]
		session[:user_id] = @user.id
		flash[:notice] = "YOU GOT IT"
		redirect "/"
	else
		flash[:notice] = "WRONG PASSWORD SILLY"
		redirect "/"
end 
end 


get '/signup' do
	params.inspect
	erb :signup 
end 

post '/signup' do
	puts params.inspect
	@user = User.new(params[:user])
	if @user.save
		flash[:notice] = "blah"
	end	
end 

get '/createPost' do
	erb :createPost
end

post '/createPost' do
	@user = User.find(session[:user_id])
	@user_post = Post.new(params[:post])

	@user_post.user_id = @user_post.id
	if @user_post.save
		flash[:notice] = "YES"
	end	
	redirect '/display'
end 

get '/display' do
	@posts = Post.where(user_id: current_user.id)
	erb :display
end	
