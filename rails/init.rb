require File.join(File.dirname(__FILE__), *%w[.. lib amazon_ses])
module ActionMailer
  class Base
      def self.method_missing(method_symbol, *parameters) #:nodoc:
        
        if match = matches_dynamic_method?(method_symbol)
          if match[1]=='create'
            new(match[2], *parameters).mail
          elsif match[1]=='deliver'
            @mymsg = new(match[2], *parameters).mail
            AmazonSES::AmzMail.send_html(@mymsg.from,@mymsg.to.first,@mymsg.subject,@mymsg.body,AppConfig.ses_amz_secret,AppConfig.ses_amz_key)
          elsif match[1]=='new'
            nil
          else
            super
          end
        else
          super
        end
      end
   end
end