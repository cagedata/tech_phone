defmodule TechPhone.VoicemailController do
  use TechPhone.Web, :controller
  alias TechPhone.Voicemail
  alias TechPhone.Mailer

  # TODO: Add error handling throughout:
  #   * When voicemail can't be found
  #   * When voicemail can't be saved

  def phone_number(conn, params) do
    voicemail_params = %{ call_sid: params["CallSid"], caller_id: params["From"], called_at: DateTime.now_utc}
    changeset = Voicemail.changeset(%Voicemail{}, voicemail_params)
    Repo.insert!(changeset)
    render conn, "phone_number.xml"
  end

  def name_company(conn, params) do
    voicemail = Repo.get_by! Voicemail, call_sid: params["CallSid"]
    voicemail_params = %{ phone_number: params["Digits"] }
    changeset = Voicemail.changeset(voicemail, voicemail_params)
    Repo.update!(changeset)
    render conn, "name_company.xml"
  end

  def message(conn, params) do
    voicemail = Repo.get_by! Voicemail, call_sid: params["CallSid"]
    voicemail_params = %{
      name_company_url: params["RecordingUrl"],
      name_company_sid: params["RecordingSid"]
    }
    changeset = Voicemail.changeset(voicemail, voicemail_params)
    Repo.update!(changeset)
    render conn, "message.xml"
  end

  def finalize(conn, params) do
    voicemail = Repo.get_by! Voicemail, call_sid: params["CallSid"]
    voicemail_params = %{
      message_url: params["RecordingUrl"],
      message_sid: params["RecordingSid"]
    }
    changeset = Voicemail.changeset(voicemail, voicemail_params)
    voicemail = Repo.update!(changeset)
    Task.async fn -> Mailer.send_voicemail(voicemail.id) end
    render conn, "finalize.xml"
  end
end
