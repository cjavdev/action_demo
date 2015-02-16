## Problem: You've got an endpoint that's accepting post requests that
contain the key `action` or `controller` and need access to the post
values.

I thought about this for a bit and googled around with out quick
solution. In the end I decided to solve this problem by creating a
simple middleware.

```rb
# lib/params_fixer.rb

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
```

```rb
# config/application.rb
  config.autoload_paths += Dir["#{config.root}/lib/**/"]

  config.middleware.use "ParamsFixer"
```
