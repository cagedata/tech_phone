defmodule TechPhone.VoicemailTest do
  use TechPhone.ModelCase

  alias TechPhone.Voicemail

  @valid_attrs %{called_at: "2010-04-17 14:00:00", caller_id: "some content", call_sid: "some content", message_url: "some content", name_company_url: "some content", phone_number: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Voicemail.changeset(%Voicemail{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Voicemail.changeset(%Voicemail{}, @invalid_attrs)
    refute changeset.valid?
  end
end
