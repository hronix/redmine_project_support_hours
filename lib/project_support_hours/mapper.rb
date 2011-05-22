module ProjectSupportHours
  class Mapper
    def self.hours
      configuration = Setting.plugin_redmine_project_support_hours
      if configuration['hours_field']
        return ProjectCustomField.find_by_field_format_and_id('float', configuration['hours_field'].to_i)
      end
    end

    def self.start_date
      configuration = Setting.plugin_redmine_project_support_hours
      if configuration['start_date_field']
        return ProjectCustomField.find_by_field_format_and_id('date', configuration['start_date_field'].to_i)
      end
    end

    def self.end_date
      configuration = Setting.plugin_redmine_project_support_hours
      if configuration['end_date_field']
        return ProjectCustomField.find_by_field_format_and_id('date', configuration['end_date_field'].to_i)
      end
    end
    
    def self.custom_field
      configuration = Setting.plugin_redmine_project_support_hours
      if configuration['custom_field'] 
        return Setting.plugin_redmine_project_support_hours["custom_field"]
      end
    end
    
    def self.project_role
      configuration = Setting.plugin_redmine_project_support_hours
      if configuration['project_role'] 
        return Setting.plugin_redmine_project_support_hours["project_role"]
      end
    end
        
  end
end
