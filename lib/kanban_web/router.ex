defmodule KanbanWeb.Router do
  use KanbanWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", KanbanWeb do
    pipe_through :api

    resources "/boards", BoardController
    resources "/boards/:board_id/lists", ListController
    resources "/boards/:board_id/cards", CardController
  end
end
