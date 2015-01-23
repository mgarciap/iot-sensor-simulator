require 'dotenv'

Dotenv.load

Cuba.plugin Cuba::Render
Cuba.settings[:render][:template_engine] = "html"

def client_mqtt
  Mosca::Client.new
end

Cuba.define do
  on get do
    on root do
      res.write partial("index")
    end
  end

  on post do
    on "publish/:topic/:payload" do |topic, payload|
      client_mqtt.publish payload, topic_out: topic
      res.status = 200
    end
  end
end
