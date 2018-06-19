defmodule Kanban.Model.Card.Query do
  alias Kanban.Model.Card
  import Ecto.Query

  def all do
    from l in Card, order_by: :position
  end

  def by_board(query, board_id) do
    from l in query, where: l.board_id == ^board_id
  end

  def by_list(query, list_id) do
    from l in query, where: l.list_id == ^list_id
  end

end