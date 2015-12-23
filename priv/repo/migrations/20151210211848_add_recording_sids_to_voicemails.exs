defmodule TechPhone.Repo.Migrations.AddRecordingSidsToVoicemails do
  use Ecto.Migration

  def change do
    alter table(:voicemails) do
      add :name_company_sid, :string
      add :name_company, :string
      add :message_sid, :string
      add :message, :string
    end
  end
end
