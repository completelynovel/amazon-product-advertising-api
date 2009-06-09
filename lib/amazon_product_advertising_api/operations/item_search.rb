module AmazonProductAdvertisingApi
  
  module Operations
    
    class ItemSearch
      
      REQUEST_PARAMETERS = [ :actor, :artist, :audience_rating, :author, :availability, :brand, :browse_node, :city,
                             :composer, :condition, :conductor, :director, :item_page, :keywords, :manufacturer, :maximum_price,
                             :merchant_id, :minimum_price, :neighborhood, :orchestra, :postal_code, :power, :publisher, :related_items_page,
                             :relationship_type, :review_sort, :search_index, :sort, :tag_page, :tags_per_page, :tag_sort, :text_stream, :title,
                             :variation_page, :response_group ]
      
      REQUEST_PARAMETERS.each do |param_name|
        eval("attr_accessor :#{param_name}")
      end
      
      attr_accessor :request
      
      def initialize(keywords, search_index = "Books", region = :uk)
        self.keywords          = keywords
        self.search_index      = search_index

        self.request           = AmazonProductAdvertisingApi::Request.new
        self.request.operation = "ItemSearch"
        self.request.region    = region
      end
      
      def run
        self.request.run(request_parameters)
      end
      
      def response
        self.request.response
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
