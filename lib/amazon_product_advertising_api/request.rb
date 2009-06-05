module AmazonProductAdvertisingApi
  
  class Request
    
    attr_accessor :aws_access_key_id
    
    attr_accessor :region
    
    attr_accessor :operation
    
    attr_accessor :raw_data
    
    attr_accessor :hpricot_data
    
    SERVICE_URLS = {
        :us => 'http://ecs.amazonaws.com/onca/xml?Service=AWSECommerceService',
        :uk => 'http://ecs.amazonaws.co.uk/onca/xml?Service=AWSECommerceService',
        :ca => 'http://ecs.amazonaws.ca/onca/xml?Service=AWSECommerceService',
        :de => 'http://ecs.amazonaws.de/onca/xml?Service=AWSECommerceService',
        :jp => 'http://ecs.amazonaws.jp/onca/xml?Service=AWSECommerceService',
        :fr => 'http://ecs.amazonaws.fr/onca/xml?Service=AWSECommerceService'
    }
    
    def run(params)
      url = ([SERVICE_URLS[self.region], "AWSAccessKeyId=#{AmazonProductAdvertisingApi::Base.api_key}", "Operation=#{self.operation}"] + params.collect { |var, val| "#{var.to_s.camelize}=#{val.to_s}" }).join("&")
      url = URI.parse(url)

      result = Net::HTTP::get_response(url)
      raise("Error connecting to Amazon") if !result.kind_of?(Net::HTTPSuccess)
      
      self.raw_data     = result.body
      self.hpricot_data = Hpricot.XML(self.raw_data)
    end
    
  end
  
end
