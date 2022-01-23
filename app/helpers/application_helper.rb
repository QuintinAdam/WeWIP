module ApplicationHelper
  def posted_at(created_at)
    # TODO: should make it work with the users timezone
    if created_at.today?
      "Today #{created_at.strftime('%B %e')}"
    elsif created_at.yesterday?
      "Yesterday #{created_at.strftime('%B %e')}"
    else
      "#{created_at.strftime('%B %e')}"
    end
  end

  def find_projects
    # normally would be scoped per team
    last_modified = Project.order(:updated_at).last
    last_modified_str = last_modified.updated_at.utc.to_s(:number)
    @project_list ||= Rails.cache.fetch("all_projects/#{last_modified_str}", expires_in: 12.hours) do
      Project.all.pluck(:id, :name, :slug)
    end
  end


end
