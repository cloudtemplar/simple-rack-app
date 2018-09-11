require 'pry'

module Routes
  module V1
    class Todos < Grape::API
      helpers do
        params :todo_params do
          optional :title
          optional :description
        end
      end

      resources 'todos' do
        desc 'Get a list of Todos'
        get do
          Todo.all
        end

        desc 'Creates todo list item'
        params do
          use :todo_params
        end
        post do
          ::TodoServices::Create.new(params).call
        end

        route_param :todo_id do
          desc 'Returns specific todo'
          get do
            Todo.find(params[:todo_id])
          end

          desc 'Updates specific todo'
          params do
            use :todo_params
          end
          put do
            todo = Todo.find(params[:todo_id])
            todo_params = declared(params, include_missing: false)
            ::TodoServices::Update.new(todo, todo_params).call
          end

          desc 'Deletes a todo'
          delete do
            todo = Todo.find(params[:todo_id])
            ::TodoServices::Destroy.new(todo).call
          end
        end
      end
    end
  end
end
