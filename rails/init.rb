require 'redmine'

Dir[File.join(directory,'vendor','plugins','*')].each do |dir|
  path = File.join(dir, 'lib')
  $LOAD_PATH << path
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end

require 'project_support_hours/hooks/project_hooks'
require 'project_support_hours/hooks/external_signups_hooks'

Redmine::Plugin.register :redmine_project_support_hours do
  name 'Project Support Hours'
  author 'Eric Davis/Stas Belov'
  url 'http://github.com/hronix/redmine_project_support_hours'
  author_url 'http://github.com/hronix'
  description 'Project Support Hours is a plugin to implement per-project buckets of hours that are used for support.'
  version '0.1.4'

  requires_redmine :version_or_higher => '0.8.0'

  settings({
             :partial => 'settings/project_support_hours',
             :default => {
               'hours_field' => nil,
               'start_date_field' => nil,
               'end_date_field' => nil,
               'excluded_activities' => []
             }})
  permission :see_project_timesheets, { }, :require => :member
  menu :top_menu, :project_support_hours, { :controller => "project_support_hours", :action => "index"}, :caption => :project_support_hours_title, :if => Proc.new {User.current.admin?}
end
