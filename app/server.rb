require 'sinatra/base'
require 'data_mapper'
require 'rack-flash'

require './app/models/peep' 
require './app/models/user'

require_relative 'data_mapper_setup'
require_relative 'helpers/application'

class Chitter < Sinatra::Base

  include Helpers

  enable :sessions
  set :session_secret, 'super secret'

  use Rack::Flash
  use Rack::MethodOverride

  get '/' do
    @peeps = Peep.all
    erb :index
  end

  post '/peeps' do
    content = params[:content]
    Peep.create(:content => content)
    redirect to('/')
  end

  get '/users/new' do
    @user = User.new
    erb :"users/new"
  end

  post '/users' do
    @user = User.create(:name => params[:name],
                        :user_name => params[:user_name],
                        :email => params[:email],
                        :password => params[:password],
                        :password_confirmation => params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to('/')
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :"users/new"
    end
  end

  get '/sessions/new' do
    erb :"sessions/new"
  end

  post '/sessions' do
    email, password = params[:email], params[:password]
    user = User.authenticate(email, password)
    if user
      session[:user_id] = user.id
      redirect to('/')
    else
      flash[:errors] = ["The email or password is incorrect"]
      erb :"sessions/new"
    end
  end

  delete '/sessions' do
    flash[:notice] = "Good bye!"
    session[:user_id] = nil
    redirect to('/')
  end



  # start the server if ruby file executed directly
  run! if app_file == $0
end
