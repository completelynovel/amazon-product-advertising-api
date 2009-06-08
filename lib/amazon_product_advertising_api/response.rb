module AmazonProductAdvertisingApi
  
  class Response
    
    ELEMENTS = [
      :actor,
      :artist,
      :asin,
      :author,
      :corrected_query,
      :creator,
      :detail_page_url,
      :director,
      :item_attributes,
      :keywords,
      :manufacturer,
      :message,
      :product_group,
      :role,
      :title,
      :total_pages,
      :total_results
    ]
    
    CONTAINERS = [
      :item_attributes
    ]
    
    attr_accessor :items
    
    def initialize
      @items  = []
    end
    
  end

  class Item
    
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
      
      if AmazonProductAdvertisingApi::Response::CONTAINERS.include?(name.to_sym)
        self.instance_eval("self.#{name} = self.class.new")
      elsif !value.nil?
        value = value.to_s if value.is_a?(Symbol)
        value = "\"#{value}\"" if value.is_a?(String)
        self.instance_eval("self.#{name} = #{value}")
      end
      
      # Return the element
      self.instance_eval("self.#{name}")
    end
    
  end
  
end
