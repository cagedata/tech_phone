defmodule TechPhone.VoicemailView do
  use TechPhone.Web, :view

  def cdn_url(file) do
    Application.get_env(:tech_phone, :audio_cdn) <> file
  end
end
