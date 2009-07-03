module AmazonProductAdvertisingApi #:nodoc:
  module Operations #:nodoc:
    module Base #:nodoc:
      
      # This is the parent class of any Operations performed.
      #
      # Each class should have a constant defined called REQUEST_PARAMETERS which contains the available parameters
      # as defined in the API docs.  Each class should also override the parse method with a custom version to suit the
      # particular pattern of XML returned for it.
      #
      # Subclasses should also override initialize to take any parameters the API defines as required, and follow the pattern
      # of the region being the last parameter.
      #
      # Before doing that though it should call super back to this one.
      class Request
        
        # String - Amazon API calls can be sent to any of 6 regions, so this defines which one.
        # It'll also use this data to pick the right Associates key to use.
        attr_accessor :region
        
        # String - The name of the Operation you want to perform, i.e. ItemSearch, ItemLookup, etc.
        attr_accessor :operation
        
        # String - This stores the request that gets sent to Amazon (for investigation if you want to look under the covers).
        attr_accessor :request_uri
        
        # String - This stores the raw data of the request response (again, for investigation if you want to look under the covers).
        attr_accessor :raw_data
        
        # Hpricot - This stores the raw data of the request response should you feel the need / desire to do some parsing yourself.
        attr_accessor :hpricot_data
        
        # Element - This is the root of the structure that the lib assembles from the data when parsed.
        attr_accessor :response
        
        # Boolean - All responses have a field saying whether the request was valid. Note that this refers to the format of the request, etc
        # and not errors with the request parameters, etc. I.e. a lookup for an item that doesn't exsist is still valid.
        attr_accessor :is_valid
        
        # Array of Struct - Any errors will be added to this attribute and each has an attribute of code or message.
        attr_accessor :errors
    
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
          self.errors   = []
        end
        
        # This takes care of building request, performing it, storing the results, checking for errors then parsing the data (if the request was valid).
        def query_amazon(params)
          request_params = {}
          request_params["AWSAccessKeyId"] = AmazonProductAdvertisingApi::Base.access_key_id
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
          self.is_valid = self.hpricot_data.at(:IsValid).inner_html == "True"
          
          self.parse
          
          # is_valid only refers to the request, so we could still have errors - check and parse if present
          if !self.hpricot_data.at(:Errors).nil?
            self.hpricot_data.at(:Errors).search(:Error).each do |error|
              self.errors << Struct.new(:code, :message).new(error.at(:Code).inner_html, error.at(:Message).inner_html)
            end
          end
          
          # Return false if it's not a valid request, otherwise return the response
          self.is_valid ? self.response : false
        end
        
        # The parse method of a request should be overwritted by any subclasses to account for different patterns in the XML.
        def parse
          raise "This should be being overridden by it's subclass to provide custom parsing for the particular operation concerned."
        end
        
        # Launches the request's query to Amazon (via query_amazon).
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
      
      # XML data that is returned by Amazon gets built into a tree of nodes, which are made up of instances of this class.
      # They represent the 'response element' entity within the API docs.
      #
      # As well as various having attributes it can also contain a collection and behave like an array.
      #
      # I think I might have got a bit confused with all this, will come back to this shortly to check.
      class Element
        
        include Enumerable
        
        def initialize
          @contained_elements = []
        end
        
        # Defines a new accessor on the element and if supplied assigns that attribute a value.
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
        
        # Add an item to the element's internal collection.
        def << element
          @contained_elements << element
        end
        
        # Iterate over the element's internal collection.
        def each(&block)
          @contained_elements.each do |element|
            yield element
          end
        end
        
        # Return the value of the internal collection's element at the given position.
        def [] position
          @contained_elements[position]
        end
        
        # Return the first element of the internal collection.
        def first
          @contained_elements.first
        end
        
        # Return the number of elements in the internal collection.
        def size
          @contained_elements.size
        end
        
        def method_missing(method, *args)
          if AmazonProductAdvertisingApi::Operations::Base::RESPONSE_ELEMENTS.include?(method.to_sym)
            if AmazonProductAdvertisingApi::Operations::Base::CONTAINER_RESPONSE_ELEMENTS.include?(method.to_sym)
              self.class.new
            else
              nil
            end
          else
            super
          end
        end
        
      end
    
    end
  end
end
