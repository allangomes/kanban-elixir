defmodule Kanban.Model.List.Query do
  alias Kanban.Model.List
  import Ecto.Query

  def all do
    from l in List, order_by: :position
  end

  def by(query, board_id: board_id) do
    from l in query, where: l.board_id == ^board_id
  end

end