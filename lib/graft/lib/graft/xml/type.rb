module Graft
  module Xml

    # = Type
    #
    class Type

      class ConversionError < StandardError; end

      def initialize(source)
        @source = source
      end

      def convertible?
        true
      end

      def value
        raise ConversionError unless (@source.blank? || convertible?)
        @source.blank? ? nil : convert
      end

      # = String
      #
      class String < Type

        def convert
          @source
        end

      end

      # = Boolean
      #
      class Boolean < Type
        def true_values
          ['true', '1']
        end

        def false_values
          ['false', '0']
        end

        def convertible?
          (true_values + false_values).include?(@source)
        end

        def convert
          true_values.include?(@source) ? true : false
        end
      end

      # = Integer
      #
      class Integer < Type
        def convertible?
          !@source.match(/\d+/).nil?
        end

        def convert
          @source.to_i
        end
      end

      # = Time
      #
      class Time < Type

        def timestamp?
          !@source.match(/^\d+$/).nil?
        end

        def convert
          timestamp? ? ::Time.at(@source.to_i) : ::Time.parse(@source)
        end

      end

      # = Date
      #
      class Date < Type

        def convert
          ::Date.parse(@source)
        end

      end

    end
  end
end