module AmazonProductAdvertisingApi #:nodoc:
  
  # Some extensions to the Class class.
  class Class
    
    # Pleasant syntax for Class attribute readers.
    def cattr_reader(sym)
      class_eval(<<-EOS, __FILE__, __LINE__)
        unless defined? @@#{sym}  # unless defined? @@hair_colors
          @@#{sym} = nil          #   @@hair_colors = nil
        end                       # end
                                  #
        def self.#{sym}           # def self.hair_colors
          @@#{sym}                #   @@hair_colors
        end                       # end
                                  #
        def #{sym}                # def hair_colors
          @@#{sym}                #   @@hair_colors
        end                       # end
      EOS
    end

    # Pleasant syntax for Class attribute writers.
    def cattr_writer(sym)
      class_eval(<<-EOS, __FILE__, __LINE__)
        unless defined? @@#{sym}                       # unless defined? @@hair_colors
          @@#{sym} = nil                               #   @@hair_colors = nil
        end                                            # end
                                                       #
        def self.#{sym}=(obj)                          # def self.hair_colors=(obj)
          @@#{sym} = obj                               #   @@hair_colors = obj
        end                                            # end
      EOS
    end

    # Pleasant syntax for Class attribute accessors.
    def cattr_accessor(sym)
      cattr_reader(sym)
      cattr_writer(sym)
    end

  end

  # Some extensions to the String class.
  class String

    # Converts strings from under_score format to CamelCase
    def camelize(first_letter_in_uppercase = true)
      if first_letter_in_uppercase
        self.to_s.gsub(/\/(.?)/) { "::" + $1.upcase }.gsub(/(^|_)(.)/) { $2.upcase }
      else
        self.first + camelize(self)[1..-1]
      end
    end

    # Converts strings from CamelCase format to under_score.
    def underscore
      self.to_s.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
    end

  end
    
end