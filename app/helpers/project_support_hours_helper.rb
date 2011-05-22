module ProjectSupportHoursHelper
  
  include Redmine::I18n
  
  def self.total_support_hours(project)
    ProjectSupportHours::Calculator.total_support_hours_for(project).to_f.round_with_precision(2)
  end
  
  def self.total_hours_used(project)
    ProjectSupportHours::Calculator.total_hours_used_for(project).to_f.round_with_precision(2)
  end
  
  def self.total_hours_remaining(project)
    ProjectSupportHours::Calculator.total_hours_remaining_for(project).to_f.round_with_precision(2)
  end
  
  def self.start_date(project)
    ProjectSupportHours::Calculator.start_date_for(project)
  end
  
  def self.end_date(project)
    ProjectSupportHours::Calculator.end_date_for(project)
  end
  
  def self.custom_field(project)
    ProjectSupportHours::Calculator.custom_field_for(project)
  end

  def self.custom_field_name
    ProjectSupportHours::Calculator.custom_field_name_for
  end
  
  def self.project_role(project)
    ProjectSupportHours::Calculator.project_role_for(project)
  end
  
  def self.project_role_name
    ProjectSupportHours::Calculator.project_role_name_for
  end
  
  def self.projects_to_csv(projects)
      ic = Iconv.new(l(:general_csv_encoding), 'UTF-8')    
      decimal_separator = l(:general_csv_decimal_separator)
      export = FCSV.generate(:col_sep => l(:general_csv_separator)) do |csv|  
          # csv header fields
          headers = [l(:label_project),
                     l(:project_support_hours_total_hours_field_label),
                     l(:label_spent_time),
                     l(:project_support_hours_remaining_hours_field_label),
                     l(:project_support_hours_start_date_field_label),
                     l(:project_support_hours_end_date_field_label),
                     custom_field_name,
                     project_role_name,
                     ]
          
          csv << headers.collect {|c| begin; ic.iconv(c.to_s); rescue; c.to_s; end }
          # csv lines
          projects.each do |project|
              fields = [project.name,
                        total_support_hours(project),
                        total_hours_used(project),
                        total_hours_remaining(project),
                        start_date(project),
                        end_date(project),
                        custom_field(project),
                        project_role(project),
                        ]
                      
            csv << fields.collect {|c| begin; ic.iconv(c.to_s); rescue; c.to_s; end }
          end
      end
      export
  end
  
end
