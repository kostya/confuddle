module Graft
  module Json
    class Attribute

      attr_reader :name, :source

      def initialize(name, source = nil)
        @name   = name
        @source = source.nil? ? @name.to_s : source
      end

      def value_from(data)
        data/source
      end

    end
  end
end