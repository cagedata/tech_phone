defmodule TechPhone.VoicemailController do
  require IEx

  use TechPhone.Web, :controller
  alias TechPhone.{Voicemail, VoicemailStep, Mailer}
  import Ecto.Query, only: [from: 2]

  def step(conn, params) do
    # Determine which step we're on
    steps = TechPhone.Repo.all query(params["step"])
    next_url = voicemail_url conn, :step, List.last(steps).order
    render conn, "step.xml", current: List.first(steps).step, next: next_url
  end

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

  defp query(step) do
    unless is_nil step do
      from step in VoicemailStep, where: step.order >= ^step, order_by: :order, limit: 2
    else
      from step in VoicemailStep, order_by: :order, limit: 2
    end
  end
end
