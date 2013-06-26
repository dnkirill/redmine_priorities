require_dependency 'projects_helper'

module SettingsProjectsHelperPatch

  def self.included(base)
    base.extend(ClassMethods)
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable
      alias_method_chain :project_settings_tabs, :hook
    end
  end

  module ClassMethods
  end

  module InstanceMethods

    def project_settings_tabs_with_hook
      tabs = project_settings_tabs_without_hook
      tabs << {name: 'priorities', action: :manage_project_activities, partial: 'priorities/settings', label: 'priority.plugin_name'}
      call_hook(:helper_projects_settings_tabs, {tabs: tabs})
      tabs
    end

  end

end