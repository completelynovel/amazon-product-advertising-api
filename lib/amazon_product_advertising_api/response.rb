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
      :keywords,
      :manufacturer,
      :message,
      :product_group,
      :role,
      :title,
      :total_pages,
      :total_results
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
      
      unless value.nil?
        value = value.to_s if value.is_a?(Symbol)
        value = "'#{value}'" if value.is_a?(String)
        self.instance_eval("self.#{name} = #{value}")
      end
    end
    
  end
  
end
