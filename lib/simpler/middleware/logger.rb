require 'logger'

class AppLogger
  def initialize(app, **options)
    @logger = Logger.new(options[:logdev] || STDOUT)
    @app = app
  end

  def call(env)
    @logger.info("Request: #{env['REQUEST_METHOD']} #{env['REQUEST_URI']}") #вот это распарсить'
    env[:logger] = self
    status, headers, body = @app.call(env)

    @logger.info("Response: #{status} #{headers.values} #{body.body}")
    [status, headers, body]
  end

  def info(message)
    @logger.info(message)
  end
end
