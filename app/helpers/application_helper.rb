module ApplicationHelper
  def posted_at(created_at)
    # TODO: should make it work with the users timezone
    if created_at.today?
      # "Today #{created_at.strftime('%B %e')}"
      "Today - #{ timeago(created_at)}".html_safe
    elsif created_at.yesterday?
      "Yesterday - #{ timeago(created_at)}".html_safe
    else
      "#{created_at.strftime('%B %e')}"
    end
  end

  def find_projects
    # normally would be scoped per team
    last_modified = Project.order(:updated_at).last
    if last_modified
      last_modified_str = last_modified.updated_at.utc.to_s(:number)
      @project_list ||= Rails.cache.fetch("all_projects/#{last_modified_str}", expires_in: 12.hours) do
        Project.all.pluck(:id, :name, :slug)
      end
    end
  end

  def timeago(date, format: :long)
    return if date.blank?

    content = I18n.l(date, format: format)

    tag.time(content, title: content, data: { controller: 'timeago', timeago_datetime_value: date.iso8601, timeago_add_suffix_value: true })
  end
end
