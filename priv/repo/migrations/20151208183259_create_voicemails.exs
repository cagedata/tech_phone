defmodule TechPhone.Repo.Migrations.CreateVoicemails do
  use Ecto.Migration

  def change do
    create table(:voicemails) do
      add :call_sid, :string
      add :caller_id, :string
      add :called_at, :datetime
      add :phone_number, :string
      add :name_company_url, :string
      add :message_url, :string

      timestamps
    end

  end
end
