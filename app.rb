require './config/application'

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
