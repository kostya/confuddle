module Graft
  module Json
    module Model

      module ClassMethods

        def attribute(name, options = {})
          source = options[:from]

          self.attributes << Graft::Json::Attribute.new(name, source)
          class_eval "attr_accessor :#{name}"
        end
        
        def data_from(json_or_hash)
          json_or_hash.is_a?(String) ? JSON.parse(json_or_hash) : json_or_hash
        end

      end

      def self.included(other)
        other.send(:extend, Graft::Model::ClassMethods)
        other.send(:extend, Graft::Json::Model::ClassMethods)
        other.send(:include, Graft::Model::InstanceMethods)
      end

    end
  end
end