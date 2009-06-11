module AmazonProductAdvertisingApi
  
  class Base
    
    cattr_accessor :access_key_id
    
    cattr_accessor :associate_ids
    @@associate_ids = Struct.new(:ca, :de, :fr, :jp, :uk, :us).new
    
  end
  
end
