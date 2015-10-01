defmodule Support.Repo.Migrations.CreateIssue do
  use Ecto.Migration

  def change do
    create table(:issues) do
      add :title, :string
      add :description, :text
      add :closed, :boolean, default: false

      timestamps
    end

  end
end
