class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  # Update: {"update_id":131823382,"message":{"message_id":14,"from":{"id":,"is_bot":false,"first_name":"Quintin","username":"QuintinAdam","language_code":"en"},"chat":{"id":,"first_name":"Quintin","username":"QuintinAdam","type":"private"},"date":1643003990,"text":"/help","entities":[{"offset":0,"length":5,"type":"bot_command"}]}}
  def start!(*)
    respond_with :message, text: t('.content')
  end

  def help!(*)
    respond_with :message, text: t('.content')
  end

  def message!(*args)
    if args.any?
      BotMessageCreateJob.perform_later(args.join(' '), from['username'])
      respond_with :message, text: "Echo: #{args.join(' ')}"
    else
      respond_with :message, text: t('.prompt')
      # save_context :message!
    end
  end

  def task!(*args)
    if args.any?
      BotTaskCreateJob.perform_later(args.join(' '), from['username'])
      respond_with :message, text: "Created: #{args.join(' ')}"
    else
      respond_with :message, text: t('.prompt')
      # save_context :message!
    end
  end

end
