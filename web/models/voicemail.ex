require Logger

defmodule TechPhone.Voicemail do
  use TechPhone.Web, :model

  schema "voicemails" do
    field :call_sid, :string
    field :caller_id, :string
    field :called_at, Ecto.DateTime
    field :phone_number, :string
    field :name_company_url, :string
    field :name_company_sid, :string
    field :name_company, :string
    field :message_url, :string
    field :message_sid, :string
    field :message, :string

    timestamps
  end

  @required_fields ~w(call_sid caller_id called_at)
  @optional_fields ~w(phone_number name_company_url name_company_sid name_company message_url message_sid message)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def get_transcription(voicemail, attribute) do
    recording_sid = Map.get voicemail, attribute
    case TechPhone.Twilio.get_transcription(recording_sid) do
      { :ok, transcription } ->
        # Update Voicemail with transcription
        field = String.replace Atom.to_string(attribute), "_sid", ""
        params = Dict.put %{}, String.to_atom(field), transcription
        changeset = TechPhone.Voicemail.changeset voicemail, params
        TechPhone.Repo.update! changeset
      { :retry, _transcription } ->
        Logger.debug "Retrying transcription in 15 seconds"
        :timer.sleep(15000)
        Voicemail.get_transcription(voicemail, attribute)
      { :failed, reason } ->
        Logger.error reason
    end
  end
end
