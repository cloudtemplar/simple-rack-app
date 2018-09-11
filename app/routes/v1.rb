module Routes
  module V1
    class API < Grape::API
      version 'v1'
      format :json

      mount Todos
    end
  end
end
