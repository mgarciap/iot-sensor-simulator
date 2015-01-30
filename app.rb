require 'dotenv'

Dotenv.load

Cuba.use Rack::Static, urls: %w[/js /css], root: "public"
Cuba.plugin Cuba::Render
Cuba.settings[:render][:template_engine] = "slim"


CLIENT = Mosca::Client.new

def set_log_message msg
  @message << Time.now.strftime("%D %H:%M:%S") + " #{msg}"
end

Cuba.define do
  on get do
    on root do
      render("index")
    end
  end

  on post do
    on "publish/:topic/:payload" do |topic, payload|
      @message = []
      begin
        unless CLIENT.connected?
          CLIENT.refresh_connection
          set_log_message "Established connection to broker '#{CLIENT.broker}' and port '#{CLIENT.port}'"
        end
        CLIENT.publish! payload, topic_out: topic
        set_log_message "Published the value '#{payload}' in channel '#{topic}'"
      rescue Timeout::Error
        set_log_message "Connection timed out. Couldn't publish on broker"
      rescue Exception => e
        set_log_message "ERROR: #{e.message}"
      end
      res.write @message
    end
  end
end
