defmodule KanbanWeb.CardView do
  use KanbanWeb, :view
  alias Kanban.Model.Card

  def render("index.json", %{cards: cards}) do
    %{ data: render_many(cards, __MODULE__, "card.json") }
  end

  def render("show.json", %{card: card}) do
    render_one(card, __MODULE__, "card.json")
  end

  def render("card.json", %{card: card}) do
    card
    |> Map.from_struct
    |> Map.take(Card.updatable_fields ++ [:id])
  end

  def render("error.json", %{changeset: changeset}) do
    %{errors: translate_errors(changeset)}
  end

  defp translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end
end