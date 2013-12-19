require 'sinatra'
require 'json'
require 'data_mapper'
require 'dm-adjust'

module Tally
    class Application < Sinatra::Base

      configure do
        set :static, true
        set :root, File.expand_path(File.join(File.dirname(__FILE__), ".."))
        set :public_folder, 'public'
        set :show_exceptions, false
      end

      helpers do
        def cycle
          %w{even odd}[@_cycle = ((@_cycle || -1) + 1) % 2]
        end

        CYCLE = %w{even odd}
        def cycle_fully_sick
          CYCLE[@_cycle = ((@_cycle || -1) + 1) % 2]
        end
      end

      class User
        include DataMapper::Resource

        property :id, Serial
        property :user, String, :key => true, :unique => true
        property :login, String, :key => true, :unique => true
        property :count, Integer
      end

      DataMapper.finalize
      DataMapper.setup(:default, ENV['DATABASE_URL'])
      DataMapper.auto_upgrade!

      def update_count(user, login)
        @users = User.first_or_create(:user => user, :login => login).adjust!(:count => +1)
      end

      get '/' do
        @users = User.all(:order => [ :count.desc ])
        erb :index
      end

      get '/user/:id' do |id|
        @tally = User.first(:id => params[:id])
        erb :user
      end

      post '/tally/?' do
        session = JSON.parse(request.body.read)
        user = session['user']
        person = user['displayName']
        username = user['name']
        update_count(person, username)
      end

    end
end
