module Graft
  module Xml
    class Attribute

      # TODO: Refactor the location / attribute logic into a Source class

      attr_reader :name, :sources

      def initialize(name, type = :string, sources = nil)
        @name = name.to_sym
        @type = type

        @sources = Array(sources)
        @sources << @name.to_s if @sources.empty?
      end

      def type_class
        "Graft::Xml::Type::#{@type.to_s.camelize}".constantize
      end

      def split(source)
        location, attribute = source.split('@')
        location = self.name.to_s if location.blank?

        [location, attribute]
      end

      def node_for(document, source)
        document.at(location(source)) || document.search("//[@#{attribute(source)}]").first
      end

      def attribute(source)
        location, attribute = source.split('@')
        attribute || location
      end

      def location(source)
        split(source).first
      end

      def value_from(document)
        values = sources.map do |source|
          node = node_for(document, source)
          if !node.nil?
            possible_values = [node.attributes[attribute(source)], node.inner_text]
            possible_values.detect {|value| !value.blank? }
          end
        end

        type_class.new(values.compact.first).value
      end

    end
  end
end