defmodule Kanban.Repo.Migrations.AddCardTable do
  use Kanban, :migration

  def change do
    create table(:card) do
      add :title, :string, unique: true
      add :description, :string
      add :position, :integer
      add :color, :string
      add :board_id, references(:board, on_delete: :delete_all)
      add :list_id, references(:list, on_delete: :delete_all)
      add :tag_list, {:array, :string}

      timestamps(inserted_at: :created_at)
    end
  end
end
