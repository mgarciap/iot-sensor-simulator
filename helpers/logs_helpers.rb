module LogsHelpers

  def set_timestamp_for_logs msg
    @message << Time.now.strftime("%D %H:%M:%S") + " #{msg}"
  end

  def establish_message_for_logs topic, payload
    @message = []
    begin
      unless CLIENT.connected?
        CLIENT.refresh_connection
        set_timestamp_for_logs "Established connection to broker '#{CLIENT.broker}' and port '#{CLIENT.port}'"
      end
      CLIENT.publish! payload, topic_out: topic
      set_timestamp_for_logs "Published the value '#{payload}' in channel '#{topic}'"
    rescue Timeout::Error
      set_timestamp_for_logs "Connection timed out. Couldn't publish on broker"
    rescue Exception => e
      set_timestamp_for_logs "ERROR: #{e.message}"
    end
  end
end
