module AmazonProductAdvertisingApi
  module Operations
    module ItemLookup
      
      class Request < AmazonProductAdvertisingApi::Operations::Base::Request
      
        REQUEST_PARAMETERS = :condition, :id_type, :item_id, :merchant_id, :offer_page, :related_items_page, :relationship_type, :review_page,
                             :review_sort, :search_index, :tag_page, :tags_per_page, :tag_sort, :variation_page, :response_group
      
        REQUEST_PARAMETERS.each do |param|
          self.send(:attr_accessor, param)
        end
        
        def initialize(item_id, region = :uk)
          super()
          
          self.item_id   = item_id
          self.operation = "ItemLookup"
          self.region    = region
        end
      
        def parse
          self.hpricot_data.at(:Items).search(:Item).each do |element|
            item = AmazonProductAdvertisingApi::Operations::Base::Element.new
        
            queue = []
            queue << [item, element.containers]
        
            queue.each do |pair|
              current_item       = pair[0]
              current_containers = pair[1]
          
              current_containers.each do |container|
                if container.containers.size == 0
                  current_item.add_element(container.name, container.inner_html)
                else
                  new_item = current_item.add_element(container.name, AmazonProductAdvertisingApi::Operations::Base::Element.new)
                  queue << [new_item, container.containers]
                end
              end
            end
            self.response.items << item
          end
        end
      
        private
          def params
            REQUEST_PARAMETERS.inject({}) do |parameters, parameter|
              parameters[parameter] = eval("self.#{parameter}") unless eval("self.#{parameter}.nil?")
              parameters
            end
          end
        end
      
    end
  end
end
