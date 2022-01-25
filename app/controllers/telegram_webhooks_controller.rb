class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  # Update: {"update_id":131823382,"message":{"message_id":14,"from":{"id":603097533,"is_bot":false,"first_name":"Quintin","username":"QuintinAdam","language_code":"en"},"chat":{"id":603097533,"first_name":"Quintin","username":"QuintinAdam","type":"private"},"date":1643003990,"text":"/help","entities":[{"offset":0,"length":5,"type":"bot_command"}]}}
  def start!(*)
    respond_with :message, text: t('.content')
  end

  def help!(*)
    respond_with :message, text: t('.content')
  end

  def message!(message, *args)
    if args.any?
      BotMessageCreateJob.perform_later(message['text'], from['username'])
      # respond_with :message, text: t('.notice')
      respond_with :message, text: "Echo: #{message['text']}"
    else
      respond_with :message, text: t('.prompt')
      # save_context :memo!
    end
  end

    def task(*args)
    if args.any?
      # session[:memo] = args.join(' ')
      respond_with :message, text: t('.notice')
    else
      respond_with :message, text: t('.prompt')
      # save_context :memo!
    end
  end

end
