module AmazonProductAdvertisingApi
  
  module ContainsElements

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
  
  class Response
    
    attr_accessor :items
    
    def initialize
      @items  = []
    end
    
  end

  class Item
    
    include AmazonProductAdvertisingApi::ContainsElements
    
  end
  
  class Container
    
    include AmazonProductAdvertisingApi::ContainsElements
    
  end
  
end
