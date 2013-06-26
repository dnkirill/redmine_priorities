module Patches
  module IssuePatch

    def self.included(base)
      base.class_eval do
        unloadable
        safe_attributes :field1, :field2, :field3

        validates_numericality_of :field1, :field2, :field3, greater_than_or_equal_to: 1, less_than_or_equal_to: 9, if: :priority_enabled?
        validates_presence_of :field1, :field2, :field3, if: :priority_enabled?

        before_save :update_priority, if: :priority_enabled?

        include InstanceMethods
      end
    end

    module InstanceMethods

      def can_use_priority?
        !closed? && field1.present?
      end

      private

      def update_priority
        if field1_changed? || field2_changed? || field3_changed?
          self.priority = self.project.priority.calculate_issue_priority(self)
        end
      end

      def priority_enabled?
        self.project.priority && self.project.priority.enabled? && !self.closed?
      end

    end

  end
end