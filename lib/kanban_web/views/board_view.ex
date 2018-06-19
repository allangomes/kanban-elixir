defmodule KanbanWeb.BoardView do
  use KanbanWeb, :view
  alias Kanban.Model.Board

  def render("index.json", %{boards: boards}) do
    %{ data: render_many(boards, __MODULE__, "board.json") }
  end

  def render("show.json", %{board: board}) do
    render_one(board, __MODULE__, "board.json")
  end

  def render("board.json", %{board: board}) do
    board
    |> Map.from_struct
    |> Map.take(Board.updatable_fields ++ [:id])
  end

  def render("error.json", %{changeset: changeset}) do
    %{ errors: translate_errors(changeset) }
  end

  defp translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end
end