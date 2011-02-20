module AmazonSES
  class Base
       
    def self.rfc2616(time)
      time.utc.strftime("%a, %d %b %Y %H:%M:%S")+" +0000"
    end
    def self.sign_https_request(request,date,secret,key) 
      return "AWS3-HTTPS AWSAccessKeyId=#{key}, Algorithm=HmacSHA256, Signature=#{Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest::Digest.new("sha256"), secret, date)).strip}"
    end
    def self.make_request(form_hash,secret,key)
      date = AmazonSES::Base.rfc2616(Time.now)
      uri = URI.parse("https://email.us-east-1.amazonaws.com/")
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data(form_hash)
      request['Content-Type'] = 'application/x-www-form-urlencoded; charset=utf-8'
      request.add_field("Date",date)
      request.add_field("X-Amzn-Authorization",AmazonSES::Base.sign_https_request(request,date,secret,key))
      response = http.request(request)
      case response
        when Net::HTTPSuccess then return response
        when Net::HTTPClientError then raise response.body
        when Net::HTTPServerError then raise response.body
        else raise response.body
      end
      #return response
    end
    
  end
end