defmodule Kanban.Model.Card do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  import Kanban.Model.Card.Query
  alias Kanban.Repo
  alias Kanban.Model.Board
  alias Kanban.Model.List
  alias Kanban.Traits.Position

  @derive {Poison.Encoder, except: [:__meta__]}
  @required_fields [:title, :board_id, :list_id]
  @optional_fields [:description, :color, :position, :tag_list]

  schema "card" do
    field :title, :string, unique: true
    field :description, :string
    field :position, :integer
    field :color, :string
    field :tag_list, {:array, :string}

    belongs_to :board, Board, foreign_key: :board_id
    belongs_to :list, List, foreign_key: :list_id

    timestamps()
  end

  def updatable_fields do
    @required_fields ++ @optional_fields
  end

  def create attrs do
    %__MODULE__{}
    |> cast(attrs, updatable_fields())
    |> validate_required(@required_fields)
    |> change_position(%{ "position" => nil })
    |> Repo.insert
  end

  def update id, attrs do
    Repo.get(__MODULE__, id)
    |> cast(attrs, updatable_fields())
    |> change_position(attrs)
    |> validate_required(@required_fields)
    |> Repo.update
  end

  def move_to_list from_list, to_list do
    Repo.update_all(
      from(c in __MODULE__) |> by_list(from_list),
      set: [list_id: to_list]
    )
  end

  def delete id do
    Repo.get(__MODULE__, id)
    |> Repo.delete
  end

  def change_position model, attrs do
    list_id = Map.get(attrs, "list_id") || get_field(model, :list_id, 0)
    query_context = all() |> by_list(list_id)
    Position.set model, query_context, attrs
  end

  def fetch_by_board board_id do
    all()
    |> by_board(board_id)
    |> Repo.all
  end

end