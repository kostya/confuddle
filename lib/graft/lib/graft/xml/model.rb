module Graft
  module Xml
    module Model

      module ClassMethods

        def attribute(name, options = {})
          source = options[:from]
          type   = options[:type] || :string

          self.attributes << Graft::Xml::Attribute.new(name, type, source)
          class_eval "attr_accessor :#{name}"
        end

        def data_from(xml_or_document)
          xml_or_document.is_a?(String) ? Hpricot.XML(xml_or_document) : xml_or_document
        end

      end

      module InstanceMethods

        def to_hash
          self.class.attributes.inject({}) {|h,a| h.merge(a.name.to_s => send(a.name)) }
        end

        def to_xml(tag_name)
          xml = Builder::XmlMarkup.new
          xml.instruct!
          xml.tag! tag_name do
            to_hash.each do |attribute, value|
              xml.tag! attribute, value
            end
          end
          xml.target!
        end

      end

      def self.included(other)
        other.send(:extend, Graft::Model::ClassMethods)
        other.send(:extend, Graft::Xml::Model::ClassMethods)
        other.send(:include, Graft::Model::InstanceMethods)
        other.send(:include, Graft::Xml::Model::InstanceMethods)
      end

    end
  end
end