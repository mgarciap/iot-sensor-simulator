require 'slim'
require 'dotenv'
require './helpers/logs_helpers'

Cuba.use Rack::Static, urls: %w[/js /css], root: "public"
Cuba.plugin LogsHelpers
Cuba.plugin Cuba::Render
Cuba.settings[:render][:template_engine] = "slim"

Dotenv.load
CLIENT = Mosca::Client.new
