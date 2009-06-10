module AmazonProductAdvertisingApi
  module Operations
    module Base
      
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
          self.response = Response.new
        end
    
        def query_amazon(params)
          url = ([SERVICE_URLS[self.region], "AWSAccessKeyId=#{AmazonProductAdvertisingApi::Base.api_key}", "Operation=#{self.operation}"] + params.collect { |var, val| "#{var.to_s.camelize}=#{val.to_s}" }).join("&")
          url = URI.parse(URI.escape(url))
      
          result = Net::HTTP::get_response(url)
          raise("Error connecting to Amazon") if !result.kind_of?(Net::HTTPSuccess)
      
          # Store away the raw data for debugging or if more direct access is required
          self.raw_data     = result.body
          self.hpricot_data = Hpricot.XML(self.raw_data)
      
          # Now parse the xml and build out the reponse elements
          self.parse
        end
        
        def parse
          raise "This should be being overridden by it's subclass to provide custom parsing for the particular operation concerned."
        end
        
        def run
          self.query_amazon(params)
        end
        
      end
      
      class Response

        attr_accessor :items, :browse_nodes

        def initialize
          @items        = []
          @browse_nodes = []
        end

      end

      class Element

        def add_element(name, value = nil)
          name = name.underscore

          self.instance_eval %{
            def self.#{name}
              @#{name}
            end
            def self.#{name}=(value)
              @#{name} ||= value
            end
          }

          if !value.nil?
            value = value.to_s if value.is_a?(Symbol)
            self.send("#{name}=", value)
          end

          # Return the element
          self.instance_eval("self.#{name}")
        end

      end
    
    end
  end
end
