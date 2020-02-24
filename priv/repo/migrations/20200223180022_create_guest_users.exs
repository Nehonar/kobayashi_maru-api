defmodule KobayashiMaru.Repo.Migrations.CreateGuestUsers do
  use Ecto.Migration

  def change do
    create table(:guest_users, primary_key: false) do
      add :token, :string

      timestamps()
    end

    create unique_index(:guest_users, [:token])
  end
end
