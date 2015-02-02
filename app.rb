require 'slim'
require 'dotenv'
require './helpers/logs_helpers'

Cuba.use Rack::Static, urls: %w[/js /css], root: "public"
Cuba.plugin LogsHelpers
Cuba.plugin Cuba::Render
Cuba.settings[:render][:template_engine] = "slim"

Dotenv.load
CLIENT = Mosca::Client.new

Cuba.define do
  on get do
    on root do
      render "index"
    end
  end

  on post do
    on "publish/:topic/:payload" do |topic, payload|
      res.write establish_message_for_logs(topic, payload)
    end
  end
end
