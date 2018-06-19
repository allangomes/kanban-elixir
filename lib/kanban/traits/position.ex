defmodule Kanban.Traits.Position do
  alias Kanban.Repo
  require Logger
  import Ecto.Query
  import Ecto.Changeset

  def set(model, query, attrs) do
    module = model.data.__struct__
    if Map.has_key?(attrs, "position") do
      %{ "position" => position } = attrs

      id = Ecto.Changeset.get_field(model, :id, 0)
      new_position = if (position == nil) do
        last = Repo.one(query |> last(:position)) || %{ position: 0 }
        last.position + 1
      else
        old = Repo.get(module, id)
        old_pos = old.position
        min_pos = min old_pos, position
        max_pos = max old_pos, position


        from(b in query, where: b.position >= ^min_pos and b.position <= ^max_pos and b.id != ^id)
        |> Repo.all
        |> Enum.each(fn current ->
          op = if old_pos > position, do: 1, else: -1
          current
            |> change(%{ position: current.position + op })
            |> Repo.update
        end)
        position
      end
      change(model, %{ position: new_position })
    else
      model
    end
  end

end