class AccessControlHeader
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)
    [status, headers.merge({'Access-Control-Allow-Origin' => '*.whbab.com'}), response]
  end
end