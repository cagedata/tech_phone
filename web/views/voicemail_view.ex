defmodule TechPhone.VoicemailView do
  use TechPhone.Web, :view

  def cdn_url(file) do
    Application.get_env(:tech_phone, :audio_cdn) <> file
  end

  def message(step) do
    cond do
      Map.has_key? step, "play" ->
        "<Play>" <> cdn_url(step["play"]) <> "</Play>"
      Map.has_key? step, "say" ->
        "<Say>" <> step["say"] <> "</Say>"
    end
  end

  def action(step, next) do
    case step["action"] do
      "hangup" ->
        "<Hangup />"
      "record" ->
        "<Record action='#{next}' method='GET' transcribe='true' maxLength='60' />"
      "gather" ->
        "<Gather action='#{next}' method='GET' />"
      _ ->
        "<Redirect action='#{next}' />"
    end
  end
end
