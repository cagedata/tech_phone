defmodule TechPhone.VoicemailStep do
  use TechPhone.Web, :model

  schema "voicemail_steps" do
    field :order, :integer
    field :label, :string
    field :step, :map

    timestamps
  end

  @required_fields ~w(order label step)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
