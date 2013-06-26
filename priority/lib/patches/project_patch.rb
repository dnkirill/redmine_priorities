module Patches
  module ProjectPatch

    def self.included(base)
      base.class_eval do
        unloadable
        has_one :priority
      end
    end

  end
end