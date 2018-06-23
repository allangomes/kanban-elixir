defmodule Kanban.Model.Card do
  use Kanban, :model
  import EctoRanked
  import Ecto.Changeset
  import Ecto.Query
  import Kanban.Model.Card.Query
  alias Kanban.Repo
  alias Kanban.Model.Board
  alias Kanban.Model.List

  @derive {Poison.Encoder, except: [:__meta__]}
  @required_fields [:title, :board_id, :list_id]
  @optional_fields [:description, :color, :position]

  schema "card" do
    field :title, :string, unique: true
    field :description, :string
    field :position, :integer
    field :color, :string


    belongs_to :board, Board, foreign_key: :board_id
    belongs_to :list, List, foreign_key: :list_id

    timestamps()
  end

  def update_position(model, params) do
    model
    |> cast(params, [:position, :list_id])
    |> set_rank(rank: :position, scope: :list_id)
  end

  def updatable_fields do
    @required_fields ++ @optional_fields
  end

  def create(attrs) do
    %__MODULE__{}
    |> cast(attrs, updatable_fields())
    |> update_position(attrs)
    |> validate_required(@required_fields)
    |> Repo.insert
  end

  def update(id, attrs) do
    Repo.get(__MODULE__, id)
    |> cast(attrs, updatable_fields())
    |> update_position(attrs)
    |> validate_required(@required_fields)
    |> Repo.update
  end

  def delete id do
    Repo.get(__MODULE__, id)
    |> Repo.delete
  end

  def fetch_by_board board_id do
    all()
    |> by_board(board_id)
    |> Repo.all
  end

end