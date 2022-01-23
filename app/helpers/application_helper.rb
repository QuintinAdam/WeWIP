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
end
