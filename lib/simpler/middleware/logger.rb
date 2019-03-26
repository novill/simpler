require 'logger'

class AppLogger
  def initialize(app, **options)
    @logger = Logger.new(options[:logdev] || STDOUT)
    @app = app
  end

  def call(env)
    @logger.info("Request: #{env['REQUEST_METHOD']} #{env['REQUEST_URI']}")

    status, headers, body = @app.call(env)

    @logger.info("Controler: #{env['simpler.controller']}")
    @logger.info("Action: #{env['simpler.action']}")

    params = Rack::Utils.parse_nested_query(env['QUERY_STRING']).merge(env['route.params'])

    @logger.info("Params: #{params}")

    @logger.info("Response: #{status} #{headers.values} #{body.body}")
    [status, headers, body]
  end

  def info(message)
    @logger.info(message)
  end
end
