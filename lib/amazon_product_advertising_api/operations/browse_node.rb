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
          self.response.add_element("BrowseNodes", AmazonProductAdvertisingApi::Operations::Base::Element.new)

          (self.hpricot_data/'BrowseNodes > BrowseNode').each do |element|
            new_element = AmazonProductAdvertisingApi::Operations::Base::Element.new
            self.response.browse_nodes << new_element

            queue = []
            queue << [new_element, element.containers]
            
            queue.each do |pair|
              current_element    = pair[0]
              current_containers = pair[1]
          
              current_containers.each do |container|
                if container.containers.size == 0
                  current_element.add_element(container.name, container.inner_html)
                else
                  if container.parent.name == container.name + "s" || container.parent.search("> #{container.name}").size > 1
                     new_element = AmazonProductAdvertisingApi::Operations::Base::Element.new
                    current_element << new_element
                    queue           << [new_element, container.containers]
                  else
                    new_element = current_element.add_element(container.name, AmazonProductAdvertisingApi::Operations::Base::Element.new)
                    queue << [new_element, container.containers]
                  end
                end
              end
            end
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
