defmodule KanbanWeb.ListView do
  use KanbanWeb, :view
  alias Kanban.Model.List

  def render("index.json", %{lists: lists}) do
    %{ data: render_many(lists, __MODULE__, "list.json") }
  end

  def render("show.json", %{list: list}) do
    render_one(list, __MODULE__, "list.json")
  end

  def render("list.json", %{list: list}) do
    list
    |> Map.from_struct
    |> Map.take(List.updatable_fields ++ [:id])
  end

  def render("error.json", %{changeset: changeset}) do
    %{errors: translate_errors(changeset)}
  end

  defp translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end
end