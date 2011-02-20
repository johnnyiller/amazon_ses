module AmazonSES

  class AmzMail
  
    def self.send(source,to_addresses,subject,body,secret,key)
      if AmazonSES::StatObject.new(secret,key).reached_quota?
        raise "Sorry you have reached your quota."
      else
        begin
          AmazonSES::Base.make_request({"Action"=>"SendEmail",
                                    "Source"=>source,
                                    "Destination.ToAddresses.member.1"=>to_addresses,
                                    "Message.Subject.Data"=>subject,
                                    "Message.Body.Text.Data"=>body},secret,key)
        rescue Exception=>e
          #puts "Error in AmazonSES::AmzMail.send"+e.to_s
          raise e.to_s
        end
      end
    end
    # This will construct and send a raw email message will send unless 
    # quota is reached.  If quota is reached it will raise an exception. 
    # It takes two api calls to send an email....
    def self.send_html(source,to_addresses,subject_txt,body_txt,secret,key)
      if AmazonSES::StatObject.new(secret,key).reached_quota?
        raise "Sorry you have reached your quota."
      else
        begin
          mail = Mail.new do
            to to_addresses
            from source
            subject subject_txt
            html_part do
              content_type 'text/html; charset=UTF-8'
              body body_txt
            end
          end
          str=mail.to_s.gsub("multipart/alternative","multipart/mixed")
          encoded = Base64.encode64(str)
          AmazonSES::Base.make_request({"Action"=>"SendRawEmail", "RawMessage.Data"=>encoded},secret,key)
        rescue Exception=>e
          #puts "Errror in AmazonSES:AmzMail.send_html "+e.to_s
          raise e.to_s
        end
      end
    end
    # will take a raw mail string encode it an send it.
    def self.send_raw(mail_string,secret,key)
      begin
        encoded = Base64.encode64(mail_string)
        AmazonSES::Base.make_request({"Action"=>"SendRawEmail", "RawMessage.Data"=>encoded},secret,key)
      rescue Exception=>e
        raise e.to_s
      end
    end
  end

end