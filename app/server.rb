require 'sinatra/base'
require 'data_mapper'

require './app/models/peep' 
require './app/models/user'


env = ENV['RACK_ENV'] || 'development'

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

DataMapper.finalize

DataMapper.auto_upgrade!

class Chitter < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'

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
    erb :"users/new"
  end

  post '/users' do
    @user = User.create(:name => params[:name],
                        :user_name => params[:user_name],
                        :email => params[:email],
                        :password => params[:password])
    session[:user_id] = @user.id
    redirect to('/')
  end

  helpers do
    def current_user
      @current_user ||=User.get(session[:user_id]) if session[:user_id]
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
