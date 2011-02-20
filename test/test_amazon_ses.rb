require 'helper'

class TestAmazonSes < Test::Unit::TestCase
  context "Has valid credentials" do 
    setup do 
      YAML.load_file("./test/credentials.yml").each { |key,value| instance_variable_set("@#{key}", value) }
    end
    should "list verified addresses" do
      puts AmazonSES::Verify.list(@aws_secret,@aws_key).body
    end
  end
end
