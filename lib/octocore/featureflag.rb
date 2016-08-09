require 'set'

module Octo

  # The FeatureFlag Module
  #
  #   This module flags some functionalities as OFF or DISABLED state.
  module FeatureFlag

    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods

      # Set the featureflag for a module or class to the state. If the
      #   featureflag is set to true, it means that the feature is disabled. If
      #   the featureflag is set to false, it means that the feature is enabled.
      #
      #   It also defined a `is_flagged?` method on the module which returns
      #   the state of featureflag
      #
      # @param [Module] klass The class or module to be feature flagged
      # @param [Boolean] state The boolean state to set for the class
      #
      def featureflag(klass, state)
        if state
          unless flags.include?klass
            flags << klass
            klass.instance_eval do
              def is_flagged?
                true
              end
            end
          end
        else
          if flags.include?klass
            flags.delete(klass)
            klass.instance_eval do
              def is_flagged?
                false
              end
            end
          end
        end
      end

      # Get the list of all flags
      # @return [Set] A set of all flags
      #
      def flags
        @flags ||= Set.new([])
      end

      # Helper method to find if a module is feature flagged or not
      # @param [Module] feature The module to be tested
      # @return [Boolean] Boolean value specifying if the feature is flagged
      #   or not
      #
      def is_flagged?(feature)
        flags.include?feature
      end

      # Returns if the flag is not set
      # @param [Module] feature The module to be tested
      # @return [Boolean] Boolean value specifying the status
      #
      def is_not_flagged?(feature)
        !is_flagged?feature
      end
    end

  end

  #include FeatureFlag
end

Octo.send(:include, Octo::FeatureFlag)

