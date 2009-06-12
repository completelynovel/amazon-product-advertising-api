module AmazonProductAdvertisingApi #:nodoc:
  module Operations #:nodoc:
    module Item #:nodoc:
      
      # Gets mixed into each of the classes in AmazonProductAdvertisingApi::Operations::Item for common behaviours.
      module Common
        
        # Item methods return xml consisting of an Items tag with several Item tags inside.
        def parse
          self.response.add_element("Items", AmazonProductAdvertisingApi::Operations::Base::Element.new)

          (self.hpricot_data/'Items > Item').each do |element|
            new_element = AmazonProductAdvertisingApi::Operations::Base::Element.new
            self.response.items << new_element

            queue = []
            queue << [new_element, element.containers]
            
            queue.each do |pair|
              current_element    = pair[0]
              current_children = pair[1]
          
              current_children.each do |child|
                if child.containers.size == 0
                  current_element.add_element(child.name, child.inner_html)
                else
                  if parent_a_container?(child)
                     new_element = AmazonProductAdvertisingApi::Operations::Base::Element.new
                    current_element << new_element
                    queue           << [new_element, child.containers]
                  else
                    new_element = current_element.add_element(child.name, AmazonProductAdvertisingApi::Operations::Base::Element.new)
                    queue << [new_element, child.containers]
                  end
                end
              end
            end
          end
        end
        
      end
      
      # A class to represent the ItemSearch Operation. See AmazonProductAdvertisingApi::Operations::Base::Request for info relating to all Requests.
      #
      # It mixes in AmazonProductAdvertisingApi::Operations::Item::Common for it's parse method.
      class ItemSearch < AmazonProductAdvertisingApi::Operations::Base::Request
        
        include Common
        
        REQUEST_PARAMETERS = :actor, :artist, :audience_rating, :author, :availability, :brand, :browse_node, :city,
                             :composer, :condition, :conductor, :director, :item_page, :keywords, :manufacturer, :maximum_price,
                             :merchant_id, :minimum_price, :neighborhood, :orchestra, :postal_code, :power, :publisher, :related_items_page,
                             :relationship_type, :review_sort, :search_index, :sort, :tag_page, :tags_per_page, :tag_sort, :text_stream, :title,
                             :variation_page, :response_group
      
        REQUEST_PARAMETERS.each do |param|
          self.send(:attr_accessor, param)
        end
        
        # ItemSearch requires keywords and a search index to be specified.
        def initialize(keywords, search_index = "Books", region = :uk)
          super()

          self.keywords     = keywords
          self.search_index = search_index
          self.operation    = "ItemSearch"
          self.region       = region
        end
      
        private
          # This simply looks at the defined parameters and creates a hash of the ones that have values assigned.
          # Need to work out a way of doing this so I don't need to keep defining exactly the same method in each class.
          def params
            REQUEST_PARAMETERS.inject({}) do |parameters, parameter|
              parameters[parameter] = eval("self.#{parameter}") unless eval("self.#{parameter}.nil?")
              parameters
            end
          end
      
      end
      
      # A class to represent the ItemLookup Operation. See AmazonProductAdvertisingApi::Operations::Base::Request for info relating to all Requests.
      #
      # It mixes in AmazonProductAdvertisingApi::Operations::Item::Common for it's parse method.
      class ItemLookup < AmazonProductAdvertisingApi::Operations::Base::Request
        
        include Common
        
        REQUEST_PARAMETERS = :condition, :id_type, :item_id, :merchant_id, :offer_page, :related_items_page, :relationship_type, :review_page,
                             :review_sort, :search_index, :tag_page, :tags_per_page, :tag_sort, :variation_page, :response_group
      
        REQUEST_PARAMETERS.each do |param|
          self.send(:attr_accessor, param)
        end
        
        # ItemLookup only requires an item id (ASIN) to be specified.
        def initialize(item_id, region = :uk)
          super()
          
          self.item_id   = item_id
          self.operation = "ItemLookup"
          self.region    = region
        end
      
        private
          # This simply looks at the defined parameters and creates a hash of the ones that have values assigned.
          # Need to work out a way of doing this so I don't need to keep defining exactly the same method in each class.
          def params
            REQUEST_PARAMETERS.inject({}) do |parameters, parameter|
              parameters[parameter] = eval("self.#{parameter}") unless eval("self.#{parameter}.nil?")
              parameters
            end
          end
          
      end
      
      # A class to represent the SimilarityLookup Operation. See AmazonProductAdvertisingApi::Operations::Base::Request for info relating to all Requests.
      #
      # Despite not following the same naming convention of other classes in this module, it returns data structured the same way so has been put here.
      #
      # It mixes in AmazonProductAdvertisingApi::Operations::Item::Common for it's parse method.
      class SimilarityLookup < AmazonProductAdvertisingApi::Operations::Base::Request
        
        include Common
        
        REQUEST_PARAMETERS = :condition, :item_id, :merchant_id, :similarity_type, :response_group
      
        REQUEST_PARAMETERS.each do |param|
          self.send(:attr_accessor, param)
        end
        
        # SimilarityLookup only requires an item id (ASIN) to be specified.
        def initialize(item_id, region = :uk)
          super()
          
          self.item_id   = item_id
          self.operation = "SimilarityLookup"
          self.region    = region
        end
      
        private
          # This simply looks at the defined parameters and creates a hash of the ones that have values assigned.
          # Need to work out a way of doing this so I don't need to keep defining exactly the same method in each class.
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
