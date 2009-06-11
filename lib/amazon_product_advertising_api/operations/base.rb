module AmazonProductAdvertisingApi
  module Operations
    module Base
      
      class Request
    
        attr_accessor :aws_access_key_id
    
        attr_accessor :region
    
        attr_accessor :operation
        
        attr_accessor :request_uri
    
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
          self.response = AmazonProductAdvertisingApi::Operations::Base::Element.new
        end
    
        def query_amazon(params)
          request_params = {}
          request_params["AWSAccessKeyId"] = AmazonProductAdvertisingApi::Base.api_key
          request_params["Operation"]      = self.operation
          request_params["AssociateTag"]   = AmazonProductAdvertisingApi::Base.associate_ids.send(self.region) unless AmazonProductAdvertisingApi::Base.associate_ids.send(self.region).nil?
          request_params.merge!(params)
          
          self.request_uri = "#{SERVICE_URLS[self.region]}&#{request_params.collect { |var, val| var.to_s.camelize + "=" + val.to_s }.join("&")}"
          self.request_uri = URI.parse(URI.escape(self.request_uri))
      
          result = Net::HTTP::get_response(self.request_uri)
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
        
        private
          # When passed an hpricot element it returns true or false based on whether this item is thought to be inside a Container Element.
          # It does this in the rather crude way of seeing if the parent's name is the pluralized form of it's own, or it is one of
          # several with the same name. This isn't 100% fool proof so I think at some point using a definitive list of the container elements
          # would be a better way to go.
          #
          # The pluralisation could also do with something a bit more sophisticated.
          def parent_a_container?(hpricot_element)
            hpricot_element.parent.name == hpricot_element.name + "s" || hpricot_element.parent.search("> #{hpricot_element.name}").size > 1
          end
        
      end
      
      class Element
        
        include Enumerable
        
        def initialize
          @contained_elements = []
        end
        
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
        
        def << element
          @contained_elements << element
        end
        
        def each(&block)
          @contained_elements.each do |element|
            yield element
          end
        end
        
        def [] position
          @contained_elements[position]
        end
        
        def first
          @contained_elements.first
        end
        
        def size
          @contained_elements.size
        end
        
      end
    
    end
  end
end
