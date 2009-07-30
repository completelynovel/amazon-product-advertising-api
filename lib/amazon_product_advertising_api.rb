require 'net/http'
require 'cgi'
require 'hpricot'
require 'time'
require 'hmac'
require 'hmac-sha2'
require 'base64'

require 'amazon_product_advertising_api/support'

Class.send(:include, AmazonProductAdvertisingApi::CoreExtensions::Class)
String.send(:include, AmazonProductAdvertisingApi::CoreExtensions::String)

require 'amazon_product_advertising_api/base'
require 'amazon_product_advertising_api/response_elements'
require 'amazon_product_advertising_api/operations/base'
require 'amazon_product_advertising_api/operations/browse_node'
require 'amazon_product_advertising_api/operations/item'
