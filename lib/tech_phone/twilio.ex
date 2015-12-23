defmodule TechPhone.Twilio do
  alias TechPhone.Repo
  alias TechPhone.Voicemail

  def get_transcription(recording_sid) do
    # Get data from Twilio API
    url = "https://api.twilio.com/2010-04-01/Accounts/#{Application.get_env(:tech_phone, :twilio)[:account]}/Recordings/#{recording_sid}/Transcriptions.json"
    response = HTTPotion.get url, [basic_auth: { Application.get_env(:tech_phone, :twilio)[:key], Application.get_env(:tech_phone, :twilio)[:secret] }]

    # Decode and test the status code
    if response.status_code == 200 do
      data = Poison.decode! response.body
      transcription = List.first data["transcriptions"]
      case transcription["status"] do
        "in-progress" -> { :retry, nil }
        "failed" -> { :failed, nil }
        "completed" -> { :ok, transcription["transcription_text"] }
      end
    else
      unless is_nil response.body do
        data = Poison.decode! response.body
        { :failed, data["message"] }
      else
        { :failed, nil }
      end
    end
  end
end
