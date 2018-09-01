require_relative 'framework'
require_relative 'database'
require_relative 'queries'
require 'pry'

DB = Database.connect('postgres://localhost/framework_dev',
                      QUERIES)

APP = App.new do
  get '/' do
    'This is the root!'
  end

  get '/todos/:description' do |params|
    description = params.fetch('description')
    todo = DB.find_todo_by_description(description).fetch(0)
    "You have to do #{todo.fetch('description')} today"
  end

  get '/todos' do
    DB.all_todos
  end
end
