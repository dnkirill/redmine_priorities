unless ProjectsHelper.included_modules.include?(SettingsProjectsHelperPatch)
  ProjectsHelper.send(:include, SettingsProjectsHelperPatch)
end

Project.send(:include, Patches::ProjectPatch)
Issue.send(:include, Patches::IssuePatch)

Redmine::Plugin.register :priority do
  name 'Priority plugin'
  author 'Progress-engine'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://progress-engine.ru/'
  author_url 'http://progress-engine.ru/'
  requires_redmine version_or_higher: '2.0.3'

  permission :priorities, { priorities: [:update] }, public: true
end

