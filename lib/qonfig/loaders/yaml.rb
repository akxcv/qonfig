# frozen_string_literal: true

module Qonfig
  module Loaders
    # @api private
    # @since 0.2.0
    module YAML
      # @since 0.5.0
      extend Qonfig::Loaders::Basic

      class << self
        # @param data [String]
        # @return [Object]
        #
        # @api private
        # @since 0.2.0
        def load(data)
          ::YAML.load(ERB.new(data).result)
        end

        # @return [Object]
        #
        # @api private
        # @since 0.5.0
        def load_empty_data
          load('{}')
        end
      end
    end
  end
end
