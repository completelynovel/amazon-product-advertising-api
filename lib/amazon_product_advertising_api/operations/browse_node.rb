module AmazonProductAdvertisingApi #:nodoc:
  module Operations #:nodoc:
    module BrowseNode #:nodoc:
      
      # A class to represent the BrowseNodeLookup Operation. See AmazonProductAdvertisingApi::Operations::Base::Request for info relating to all Requests.
      class BrowseNodeLookup < AmazonProductAdvertisingApi::Operations::Base::Request
        
        REQUEST_PARAMETERS = :browse_node_id, :response_group
      
        REQUEST_PARAMETERS.each do |param|
          self.send(:attr_accessor, param)
        end
        
        # BrowseNodeLookup only requires a browse_node_id to be specified.
        def initialize(browse_node_id, region = :uk)
          super()

          self.browse_node_id = browse_node_id
          self.operation      = "BrowseNodeLookup"
          self.region         = region
        end
        
        # BrowseNode methods return xml consisting of a BrowseNodes tag with several BrowseNode tags inside.
        def parse
          self.response.add_element("BrowseNodes", AmazonProductAdvertisingApi::Operations::Base::Element.new)

          (self.hpricot_data/'BrowseNodes > BrowseNode').each do |element|
            new_element = AmazonProductAdvertisingApi::Operations::Base::Element.new
            self.response.browse_nodes << new_element

            queue = []
            queue << [new_element, element.containers]
            
            queue.each do |pair|
              current_element  = pair[0]
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
