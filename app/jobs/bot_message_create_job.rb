class BotMessageCreateJob < ApplicationJob
  queue_as :default

  def perform(content, author)
    bot = User.find_by_email('bot@bot.com')
    bot.messages.create(content: content, author: author, project: Project.last)
  end
end
