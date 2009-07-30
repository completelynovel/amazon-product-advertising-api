module AmazonProductAdvertisingApi #:nodoc:
  
  # This is the main base class where you define your config data. Setup like so:
  #   AmazonProductAdvertisingApi.base.access_key_id     = <your Amazon AccessKeyId>
  #   AmazonProductAdvertisingApi.base.secret_access_key = <your Amazon SecretAccessKey>
  #
  # You also setup your Associates codes for different regions here (the right one is supplied)
  # based on what region you are requesting for.
  #   AmazonProductAdvertisingApi.base.associate_ids.ca = <your associates CA Affiliate key>
  #   AmazonProductAdvertisingApi.base.associate_ids.uk = <your associates UK Affiliate key>
  class Base
    
    cattr_accessor :access_key_id

    cattr_accessor :secret_access_key
    
    cattr_accessor :associate_ids
    @@associate_ids = Struct.new(:ca, :de, :fr, :jp, :uk, :us).new
    
  end
  
end
