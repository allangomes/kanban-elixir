defmodule KanbanWeb.Router do
  use KanbanWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", KanbanWeb do
    pipe_through :api

    resources "/board", BoardController
    resources "/board/:board_id/list", ListController
    resources "/board/:board_id/card", CardController
  end
end
