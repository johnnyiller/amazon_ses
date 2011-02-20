module AmazonSES

  class Stats
      def self.send_quota(secret,key)
        begin 
          AmazonSES::Base.make_request({"Action"=>"GetSendQuota"},secret,key)
        rescue Exception=>e
          raise e.to_s
        end
      end
      def self.send_stats(secret,key)
        begin
          AmazonSES::Base.make_request({"Action"=>"GetSendStatistics"},secret,key)
        rescue Exception=>e
          raise e.to_s
        end
      end
  end
  class StatObject
    attr_accessor :sent_last_24_hours, :max_send_rate, :max_24_hour_send
    
    def initialize(secret,key)
      resp = Stats.send_quota(secret,key)
      hash = XmlSimple.xml_in(resp.body)
      @sent_last_24_hours = hash["GetSendQuotaResult"][0]["SentLast24Hours"][0].to_i
      @max_send_rate = hash["GetSendQuotaResult"][0]["MaxSendRate"][0].to_i
      @max_24_hour_send = hash["GetSendQuotaResult"][0]["Max24HourSend"][0].to_i
    end
    def reached_quota?
      @sent_last_24_hours >= @max_24_hour_send
    end
  end

end