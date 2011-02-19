require 'helper'

class TestAmazonSes < Test::Unit::TestCase
  context "Has valid credentials" do 
    setup do 
      YAML.load_file("./test/credentials.yml").each { |key,value| instance_variable_set("@#{key}", value) }
    end
    #should "Be able to verify address" do
    #  resp = AmazonSES::Verify.address("admin@flickaday.com",@aws_secret,@aws_key)
    #end
    #should "Get some stats" do
    #  resp = AmazonSES::Stats.send_quota(@aws_secret,@aws_key)
    #  puts resp.body
    #end
    #should "Send an email" do
    #  resp = AmazonSES::AmzMail.send_html("admin@flickaday.com","admin@flickaday.com","hey how are you doing","<h1>Just wanted</h1><p> to send you a quick message.</p>",@aws_secret,@aws_key)
    #  puts resp.body
    #end
    #should ""
    should "not be at quota" do
      statobj = AmazonSES::StatObject.new(@aws_secret,@aws_key)
      assert !statobj.reached_quota?
    end
  end
end
