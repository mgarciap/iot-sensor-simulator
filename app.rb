require 'dotenv'

Dotenv.load

Cuba.plugin Cuba::Render
Cuba.settings[:render][:template_engine] = "html"


CLIENT = Mosca::Client.new

Cuba.define do
  on get do
    on root do
      res.write partial("index")
    end
  end

  on post do
    on "publish/:topic/:payload" do |topic, payload|
      response = []
      begin
        unless CLIENT.connected?
          CLIENT.refresh_connection
          response << "Established connection to broker '#{CLIENT.broker}' and port '#{CLIENT.port}'"
        end
        CLIENT.publish! payload, topic_out: topic
        response << "Published the value '#{payload}' in channel '#{topic}'"
        res.write response
      rescue Timeout::Error
        response << "Connection timed out. Couldn't publish on broker"
        res.write response
      rescue Exception => e
        response << "ERROR: #{e.message}"
        res.write response
      end
    end
  end
end
