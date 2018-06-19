defmodule Kanban.Repo.Migrations.AddBoardTable do
  use Ecto.Migration

  def change do
    create table(:board) do
      add :title, :string, unique: true
      add :description, :string
      add :position, :integer
      add :color, :string

      timestamps()
    end
  end
end
