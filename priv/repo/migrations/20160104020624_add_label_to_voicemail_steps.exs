defmodule TechPhone.Repo.Migrations.AddLabelToVoicemailSteps do
  use Ecto.Migration

  def change do
    alter table(:voicemail_steps) do
      add :label, :string
    end
  end
end
