module ActiveRecord
  module JSONB
    module Associations
      module Preloader
        module Association # :nodoc:
          def loader_query
            ::ActiveRecord::Associations::Preloader::Association::LoaderQuery.new(scope, association_key_name,
                                                                                  reflection)
          end

          module LoaderQuery # :nodoc:
            attr_reader :reflection

            def initialize(scope, association_key_name, reflection)
              super(scope, association_key_name)
              @reflection = reflection
            end

            def load_records_for_keys(keys, &block)
              return super unless reflection.options.key?(:foreign_store)

              scope.where(
                Arel::Nodes::JSONBHashArrow.new(
                  scope.table,
                  scope.table[reflection.options[:foreign_store]],
                  association_key_name
                ).intersects_with(keys)
              ).load(&block)
            end
          end
        end
      end
    end
  end
end
