module AmazonSES

  class Stats
      def self.send_quota(secret,key)
        AmazonSES::Base.make_request({"Action"=>"GetSendQuota"},secret,key)
      end
      def self.send_stats(secret,key)
        AmazonSES::Base.make_request({"Action"=>"GetSendStatistics"},secret,key)
      end
  end

end