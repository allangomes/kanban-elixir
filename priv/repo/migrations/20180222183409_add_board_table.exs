defmodule Kanban.Repo.Migrations.AddBoardTable do
  use Kanban, :migration

  def change do
    create table(:board) do
      add :title, :string, unique: true
      add :description, :string
      add :position, :integer
      add :color, :string

      timestamps(inserted_at: :created_at)
    end
  end
end
