defmodule Kanban.Repo.Migrations.AddListTable do
  use Kanban, :migration

  def change do
    create table(:list) do
      add :title, :string, unique: true
      add :description, :string
      add :position, :integer
      add :color, :string
      add :board_id, references(:board, on_delete: :delete_all)

      timestamps(inserted_at: :created_at)
    end
  end
end
