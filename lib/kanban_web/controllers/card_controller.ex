defmodule KanbanWeb.CardController do
  use KanbanWeb, :controller

  alias Kanban.Model.Card
  alias Kanban.Repo

  def index(conn, %{"board_id" => board_id}) do
    Process.sleep(1500) # used for test loading in front
    cards = Card.fetch_by_board(board_id)
    conn |> render("index.json", cards: cards)
  end

  def create(conn, params) do
    case Card.create params do
      { :ok, card } -> conn
        |> put_status(201)
        |> render("show.json", card: card)
      { :error, changeset } -> conn
        |> put_status(422)
        |> render("error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    card = Repo.get!(Card, id)
    conn |> render("show.json", board: card)
  end

  def update(conn, %{"id" => id} = body) do
    case Card.update(id, body) do
      { :ok, card } -> render conn, "show.json", card: card
      { :error, changeset } -> conn
        |> put_status(422)
        |> render("error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    case Card.delete id do
      { :ok, _ } -> send_resp conn, :no_content, ""
      { :error, changeset } -> conn
        |> put_status(422)
        |> render("error.json", changeset: changeset)
    end
  end

end
