json.extract! project, :id, :name, :slug, :created_at, :updated_at
json.url project_url(project, format: :json)
json.messages_url project_messages_url(project, format: :json)
json.tasks_url project_messages_url(project, format: :json)
