defmodule Kanban.Model.List do
  use Kanban, :model
  import Ecto.Changeset
  import Kanban.Model.List.Query
  alias Kanban.Model
  alias Kanban.Repo
  alias Kanban.Traits.Position

  @derive {Poison.Encoder, except: [:__meta__]}
  @required_fields [:title, :board_id]
  @optional_fields [:description, :color, :position]

  schema "list" do
    field :title, :string, unique: true
    field :description, :string
    field :position, :integer
    field :color, :string

    belongs_to :board, Model.Board, foreign_key: :board_id
    has_many :cards, Model.Card

    timestamps()
  end

  def updatable_fields do
    @required_fields ++ @optional_fields
  end

  def create(attrs) do
    %__MODULE__{}
    |> cast(attrs, updatable_fields())
    |> validate_required(@required_fields)
    |> change_position(%{ "position" => nil })
    |> Repo.insert
  end

 def update(id, attrs) do
    Repo.get(__MODULE__, id)
    |> cast(attrs, updatable_fields())
    |> validate_required(@required_fields)
    |> change_position(attrs)
    |> Repo.update
  end

  def change_position(model, attrs) do
    board_id = Map.get(attrs, "board_id") || get_field(model, :board_id, 0)
    query_context = all() |> by(board_id: board_id)
    Position.set model, query_context, attrs
  end

  def delete(id, attrs \\ %{}) do
    move_to = Map.get attrs, "move_to"
    IO.puts move_to
    if move_to != nil, do: Model.Card.move_to_list(id, move_to)
    Repo.get(__MODULE__, id)
    |> Repo.delete
  end

  def fetch_by_board(board_id) do
    all()
    |> by(board_id: board_id) 
    |> Repo.all
  end

end