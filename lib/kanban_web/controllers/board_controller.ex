defmodule KanbanWeb.BoardController do
  use KanbanWeb, :controller

  alias Process
  alias Kanban.Model.Board
  alias Kanban.Repo

  def index(conn, _params) do
    boards = Board.fetch_all
    render conn, "index.json", boards: boards
  end

  def create(conn, body) do
    case Board.create(body) do
      { :ok, board } -> conn
        |> put_status(201)
        |> render("show.json", board: board)
      { :error, changeset } -> conn
        |> put_status(422)
        |> render("error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    Process.sleep(500) # used for test loading in front
    board = Repo.get!(Board, id)
    render conn, "show.json", board: board
  end

  def update(conn, %{"id" => id} = body) do
    case Board.update(id, body) do
      { :ok, board } -> render conn, "show.json", board: board
      { :error, reason } -> json conn, %{ error: reason }
    end
  end

  def delete(conn, %{"id" => id}) do
    case Board.delete id do
      { :ok, _ } -> send_resp conn, :no_content, ""
      { :error, reason } -> json conn, %{ error: reason }
    end
  end

end
