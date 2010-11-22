# config.ru
require "rubygems"
require 'rack/contrib'
require 'rack-rewrite'

use Rack::Rewrite do
  if ENV['RACK_ENV'] == 'production'
    domain = 'sass-border-radius.heroku.com'
    r301 %r{.*}, "http://#{domain}$&", :if => Proc.new {|rack_env|
      rack_env['SERVER_NAME'] != domain
    }
  end
  
  rewrite '/', '/index.html'
end

use Rack::Static, :urls => ["/"], :root => Dir.pwd + '/'

# Empty app, should never be reached:
class Homepage
  def call(env)
    [200, {"Content-Type" => "text/html"}, ["There's a problem with my website/"] ]
  end
end
run Homepage.new