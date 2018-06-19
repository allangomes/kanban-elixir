defmodule KanbanWeb.ListController do
  use KanbanWeb, :controller

  alias Process
  alias Kanban.Model.List
  alias Kanban.Repo

  plug :scrub_params, "board_id" when action in [:create]

  def index(conn, %{"board_id" => board_id}) do
    Process.sleep(1000) # used for test loading in front
    lists = List.fetch_by_board board_id
    render conn, "index.json", lists: lists
  end

  def create(conn, params) do
    case List.create(params) do
      { :ok, list } -> render conn, "show.json", list: list
      { :error, changeset } -> conn
        |> put_status(422)
        |> render("error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    list = Repo.get!(List, id)
    render conn, "show.json", list: list
  end

  def update(conn, %{"id" => id} = params) do
    case List.update(id, params) do
      { :ok, list } -> render conn, "show.json", list: list
      { :error, reason } -> json conn, %{ error: reason }
    end
  end

  def delete(conn, %{"id" => id} = params) do
    case List.delete id, params do
      { :ok, _ } -> send_resp conn, :no_content, ""
      { :error, reason } -> json conn, %{ error: reason }
    end
  end

end
