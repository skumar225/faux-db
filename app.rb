require 'pry'
require 'sinatra'
# require 'sinatra/reloader'
require "better_errors"

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

# this will store your users
users = []

# this will store an id to user for your users
# you'll need to increment it every time you add
# a new user, but don't decrement it
id = 1

# routes to implement:
#
# GET / - show all users
get '/' do
  @users = users
  erb :index
end

# GET /users/new - display a form for making a new user
#
get '/users/new' do
  erb :new
end
# POST /users - create a user based on params from form
post '/users' do
  p params
  @users = users
  users.push({first: params[:first], last: params[:last], id: id})
  id+= 1
  redirect '/'
end
# GET /users/:id - show a user's info by their id, this should display the info in a form

get '/users/:id' do
  #loop through array, find where id params equals id and 
  @user = users[params[:id].to_i - 1]
  erb :show
end
# PUT /users/:id - update a user's info based on the form from GET /users/:id

put '/users/:id' do 
  users[:first] = users[params[:id].to_i - 1]  #identifies which name and converts ID to index position

  users[:first] = params[:first] #updates info
  users[:last] = params[:last]
end 

# DELETE /users/:id - delete a user by their id

users.each do |user| 
     if user[:id] == params[:id].to_i
      delete.user
       # now we found the right user
     end
   end
