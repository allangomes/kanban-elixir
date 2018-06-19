defmodule Kanban.Model.Board.Query do
  alias Kanban.Model.Board
  import Ecto.Query

  def all do
    from b in Board, order_by: :position
  end

end