module AmazonSES

  class AmzMail
  
    def self.send(source,to_addresses,subject,body,secret,key)
      AmazonSES::Base.make_request({"Action"=>"SendEmail",
                                    "Source"=>source,
                                    "Destination.ToAddresses.member.1"=>to_addresses,
                                    "Message.Subject.Data"=>subject,
                                    "Message.Body.Text.Data"=>body},secret,key)
    end
    def self.send_html(source,to_addresses,subject_txt,body_txt,secret,key)
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
       puts encoded
       AmazonSES::Base.make_request({"Action"=>"SendRawEmail", "RawMessage.Data"=>encoded},secret,key)
    end
  end

end