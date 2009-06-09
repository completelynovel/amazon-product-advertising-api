module AmazonProductAdvertisingApi
  
  class Request
    
    attr_accessor :aws_access_key_id
    
    attr_accessor :region
    
    attr_accessor :operation
    
    attr_accessor :raw_data
    
    attr_accessor :hpricot_data
    
    attr_accessor :response
    
    SERVICE_URLS = {
        :us => 'http://ecs.amazonaws.com/onca/xml?Service=AWSECommerceService',
        :uk => 'http://ecs.amazonaws.co.uk/onca/xml?Service=AWSECommerceService',
        :ca => 'http://ecs.amazonaws.ca/onca/xml?Service=AWSECommerceService',
        :de => 'http://ecs.amazonaws.de/onca/xml?Service=AWSECommerceService',
        :jp => 'http://ecs.amazonaws.jp/onca/xml?Service=AWSECommerceService',
        :fr => 'http://ecs.amazonaws.fr/onca/xml?Service=AWSECommerceService'
    }
    
    def initialize
      self.response = AmazonProductAdvertisingApi::Response.new
    end
    
    def run(params)
      url = ([SERVICE_URLS[self.region], "AWSAccessKeyId=#{AmazonProductAdvertisingApi::Base.api_key}", "Operation=#{self.operation}"] + params.collect { |var, val| "#{var.to_s.camelize}=#{val.to_s}" }).join("&")
      url = URI.parse(URI.escape(url))
      
      result = Net::HTTP::get_response(url)
      raise("Error connecting to Amazon") if !result.kind_of?(Net::HTTPSuccess)
      
      # Store away the raw data for debugging or if more direct access is required
      self.raw_data     = result.body
      self.hpricot_data = Hpricot.XML(self.raw_data)
      
      # Now parse the xml and build out the reponse elements
      self.hpricot_data.at(:Items).search(:Item).each do |element|
        item = AmazonProductAdvertisingApi::Element.new
        
        queue = []
        queue << [item, element.containers]
        
        queue.each do |pair|
          current_item       = pair[0]
          current_containers = pair[1]
          
          current_containers.each do |container|
            if container.containers.size == 0
              current_item.add_element(container.name, container.inner_html)
            else
              new_item = current_item.add_element(container.name, AmazonProductAdvertisingApi::Element.new)
              queue << [new_item, container.containers]
            end
          end
        end
        self.response.items << item
      end
    end
    
  end
  
end
