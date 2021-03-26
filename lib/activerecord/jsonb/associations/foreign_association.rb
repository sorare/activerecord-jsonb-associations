module ActiveRecord
  module JSONB
    module Associations
      module ForeignAssociation #:nodoc:
        def set_owner_attributes(record)
          return super unless options.key?(:foreign_store)

          key = owner._read_attribute(reflection.foreign_store)
          record._write_attribute(reflection.foreign_store, key)
        end
      end
    end
  end
end
