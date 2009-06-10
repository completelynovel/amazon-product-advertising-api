module AmazonProductAdvertisingApi
  module Operations
    module BrowseNode
      
      class BrowseNodeLookup < AmazonProductAdvertisingApi::Operations::Base::Request
        
        REQUEST_PARAMETERS = :browse_node_id, :response_group
      
        REQUEST_PARAMETERS.each do |param|
          self.send(:attr_accessor, param)
        end

        def initialize(browse_node_id, region = :uk)
          super()

          self.browse_node_id = browse_node_id
          self.operation      = "BrowseNodeLookup"
          self.region         = region
        end
        
        def parse
          (self.hpricot_data/'BrowseNodes > BrowseNode').each do |element|
            browse_node = AmazonProductAdvertisingApi::Operations::Base::Element.new
        
            queue = []
            queue << [browse_node, element.containers]
        
            queue.each do |pair|
              current_browse_node = pair[0]
              current_containers  = pair[1]
          
              current_containers.each do |container|
                if container.containers.size == 0
                  current_browse_node.add_element(container.name, container.inner_html)
                else
                  new_browse_node = current_browse_node.add_element(container.name, AmazonProductAdvertisingApi::Operations::Base::Element.new)
                  queue << [new_browse_node, container.containers]
                end
              end
            end
            self.response.browse_nodes << browse_node
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
