require 'net/https'
require 'uri'
require 'time'
require "cgi"
require "base64"
require "openssl"
require "digest/sha1"
require "rubygems"
require "mail"
require "xmlsimple"

$:.unshift(File.dirname(__FILE__))
require 'amazon_ses/base'
require 'amazon_ses/verify'
require 'amazon_ses/stats'
require 'amazon_ses/amz_mail'