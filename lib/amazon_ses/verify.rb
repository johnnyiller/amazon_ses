module AmazonSES

  class Verify
    # returns the response object
    def self.address(emailaddress,secret,key)
      AmazonSES::Base.make_request({"Action"=>"VerifyEmailAddress","EmailAddress"=>emailaddress},secret,key)
    end
    
  end

end