defmodule TechPhone.Repo.Migrations.CreateVoicemailStep do
  use Ecto.Migration

  def change do
    create table(:voicemail_steps) do
      add :order, :integer
      add :step, :map

      timestamps
    end

  end
end
