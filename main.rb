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

  get '/todos/:title' do |params|
    title = params.fetch('title')
    todo = DB.find_todo_by_title(title).fetch(0)
    "You have to do #{todo.fetch('title')} today"
  end

  get '/todos' do
    DB.all_todos
  end
end
