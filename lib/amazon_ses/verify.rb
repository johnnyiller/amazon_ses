module AmazonSES

  class Verify
    # returns the response object
    def self.address(emailaddress,secret,key)
      begin
        AmazonSES::Base.make_request({"Action"=>"VerifyEmailAddress","EmailAddress"=>emailaddress},secret,key)
      rescue Exception=>e
        raise e.to_s
      end
    end
    def self.list(secret,key)
      begin
        AmazonSES::Base.make_request({"Action"=>"ListVerifiedEmailAddresses"},secret,key)
      rescue Exception =>e 
        raise e.to_s
      end
    end
    def self.address_remove(email,secret,key)
      begin
        AmazonSES::Base.make_request({"Action"=>"DeleteVerifiedEmailAddress","Emailaddress"=>email},secret,key)
      rescue Exception=>e
        raise e.to_s
      end
    end
    
  end

end