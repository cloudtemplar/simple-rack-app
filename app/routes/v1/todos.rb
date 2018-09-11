module Routes
  module V1
    class Todos < Grape::API
      resources 'todos' do
        desc 'Get a list of Todos'
        get do
          Todo.all
        end

        route_param :todo_id do
          desc 'Returns todo'
          get do
            Todo.find(params[:todo_id])
          end
        end
      end
    end
  end
end
