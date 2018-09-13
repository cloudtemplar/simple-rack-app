module TodoList
  class App
    def initialize ; end

    def self.instance
      @instance ||= Rack::Builder.new do
        use Rack::Auth::Basic do |username, password|
          username == 'username' && password == 'password'
        end

        run TodoList::App.new
      end.to_app
    end

    def call(env)
      # api
      Routes::V1::API.call(env)
    end
  end
end
