class ParamsFixer
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    if request.params['action']
      request.update_param('beer_db_action', request.params['action'])
    end
    status, headers, resp = @app.call(env)
    [status, headers, resp]
  end
end
