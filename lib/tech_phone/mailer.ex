defmodule TechPhone.Mailer do
  # This is broken unless you hardcode settings.
  @config [
    domain: "https://api.mailgun.net/v3/" <> Application.get_env(:tech_phone, :mailgun)[:domain],
    key: Application.get_env(:tech_phone, :mailgun)[:key]
  ]

  use Mailgun.Client, @config

  def send_voicemail(voicemail_id) do
    get_transcriptions(voicemail_id)
    voicemail = TechPhone.Repo.get(TechPhone.Voicemail, voicemail_id)

    body = """
      A voicemail was left for support.

      Person called from: #{voicemail.caller_id}

      Name recording: #{voicemail.name_company_url}

        #{voicemail.name_company}

      Call back number: #{voicemail.phone_number}

      Message recording: #{voicemail.message_url}

        #{voicemail.message}
    """
    Mailgun.Client.send_email config, to: "support@cagedata.com",
     from: Application.get_env(:tech_phone, :mail_from),
     subject: "New voicemail from #{voicemail.caller_id}!",
     text: body
  end

  def config do
    mailgun = Application.get_env :tech_phone, :mailgun
    [
      domain: "https://api.mailgun.net/v3/" <> mailgun[:domain],
      key: mailgun[:key]
    ]
  end

  defp get_transcriptions(voicemail_id) do
    voicemail = TechPhone.Repo.get(TechPhone.Voicemail, voicemail_id)
    name_company = Task.async fn ->
      TechPhone.Voicemail.get_transcription(voicemail, :name_company_sid)
    end
    message = Task.async fn ->
      TechPhone.Voicemail.get_transcription(voicemail, :message_sid)
    end
    Enum.map [name_company, message], fn(task) -> Task.await(task, 300_000) end
  end
end
