$stdout.sync = true
require 'erb'

app = Proc.new do |env|
  body = [ERB.new(File.read('index.html.erb')).result]

  [200, {}, body]
end

use Rack::Deflater
use Rack::CommonLogger
run app

