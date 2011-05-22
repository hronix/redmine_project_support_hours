module ProjectSupportHours
  class Calculator
    # Gets the start_date for the project if set
    def self.start_date_for(project)
      start_date_field = project.custom_value_for(ProjectSupportHours::Mapper.start_date)
      start_date_field ? start_date_field.value : nil
    end

    # Gets the end_date for the project if set
    def self.end_date_for(project)
      end_date_field = project.custom_value_for(ProjectSupportHours::Mapper.end_date)
      end_date_field ? end_date_field.value : nil
    end
    
    # Gets the total support hours for the project if set
    def self.total_support_hours_for(project)
      hours_field = project.custom_value_for(ProjectSupportHours::Mapper.hours)
      hours_field ? hours_field.value.to_f : nil
    end

    def self.total_hours_used_for(project)
      project.time_entries.sum('hours', :conditions => ["activity_id NOT IN (?)",
                                                        Setting.plugin_redmine_project_support_hours['excluded_activities']])
    end

    def self.total_hours_remaining_for(project)
      total_hours = total_support_hours_for(project)
      if total_hours and total_hours > 0
        total_hours - total_hours_used_for(project)
      else
        nil
      end
    end
    
    def self.custom_field_for(project)
      CustomValue.find(:first, :conditions => ["custom_field_id = ? AND customized_id = ?", ProjectSupportHours::Mapper.custom_field, project.id]).to_s
    end
    
    def self.custom_field_name_for
      custom_field = ProjectSupportHours::Mapper.custom_field.to_i
      if custom_field != 0
        ProjectCustomField.find(ProjectSupportHours::Mapper.custom_field.to_i).name.to_s
      else
        nil
      end
    end
    
    def self.project_role_for(project)
      member = Member.find(:first, :include => ["member_roles"], :conditions => ["member_roles.role_id = ? AND project_id = ?", ProjectSupportHours::Mapper.project_role, project.id])
      first_name = member ? User.find(member.user_id).firstname.to_s : ""
      last_name = member ? User.find(member.user_id).lastname.to_s : ""
      first_name + " " + last_name
    end
    
    def self.project_role_name_for
      project_role = ProjectSupportHours::Mapper.project_role.to_i
      if project_role != 0
        Role.find(ProjectSupportHours::Mapper.project_role.to_i).name.to_s
      else
        nil
      end
    end
  end
end
