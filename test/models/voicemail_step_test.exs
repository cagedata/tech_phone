defmodule TechPhone.VoicemailStepTest do
  use TechPhone.ModelCase

  alias TechPhone.VoicemailStep

  @valid_attrs %{order: 42, step: %{}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = VoicemailStep.changeset(%VoicemailStep{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = VoicemailStep.changeset(%VoicemailStep{}, @invalid_attrs)
    refute changeset.valid?
  end
end
