module AmazonProductAdvertisingApi
  
  module Operations
    
    class ItemLookup
      
      REQUEST_PARAMETERS = [ :condition, :id_type, :item_id, :merchant_id, :offer_page, :related_items_page, :relationship_type, :review_page,
                             :review_sort, :search_index, :tag_page, :tags_per_page, :tag_sort, :variation_page, :response_group ]
      
      REQUEST_PARAMETERS.each do |param_name|
        eval("attr_accessor :#{param_name}")
      end
      
      attr_accessor :request
      
      def initialize(item_id = nil, region = :uk)
        self.request           = AmazonProductAdvertisingApi::Request.new
        self.request.operation = "ItemLookup"
        self.request.region    = region
      end
      
      def run
        self.request.run(self.request_parameters)
      end
      
      private
        def request_parameters
          REQUEST_PARAMETERS.inject({}) do |parameters, parameter|
            parameters[parameter] = eval("self.#{parameter}") unless eval("self.#{parameter}.nil?")
            parameters
          end
        end
      
    end
    
  end
  
end
