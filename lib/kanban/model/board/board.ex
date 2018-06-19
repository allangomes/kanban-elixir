defmodule Kanban.Model.Board do
  use Ecto.Schema
  import Ecto.Changeset
  import Kanban.Model.Board.Query
  alias Kanban.Repo
  alias Kanban.Model
  alias Kanban.Traits.Position

  @derive {Poison.Encoder, except: [:__meta__]}
  @required_fields [:title]
  @optional_fields [:description, :color, :position]

  schema "board" do
    field :title, :string, unique: true
    field :description, :string
    field :position, :integer
    field :color, :string
    has_many :lists, Model.List
    has_many :cards, Model.Card

    timestamps()
  end

  def updatable_fields do
    @required_fields ++ @optional_fields
  end

  def add_default_lists board_id do
    Model.List.create(%{
      "board_id" => board_id,
      "title" => "TODO",
      "color" => "orange"
    })
    Model.List.create(%{
      "board_id" => board_id,
      "title" => "DOING",
      "color" => "yellow"
    })
    Model.List.create(%{
      "board_id" => board_id,
      "title" => "DONE",
      "color" => "green"
    })
  end

  def create attrs do
    command_result = %__MODULE__{}
    |> cast(attrs, updatable_fields())
    |> validate_required(@required_fields)
    |> change_position(%{ "position" => nil })
    |> Repo.insert
    case command_result do
      { :ok, board } ->
        add_default_lists board.id
    end
    command_result
  end

  def update id, attrs do
    Repo.get(__MODULE__, id)
    |> cast(attrs, updatable_fields())
    |> validate_required(@required_fields)
    |> change_position(attrs)
    |> Repo.update
  end

  def delete id do
    Repo.get(__MODULE__, id)
    |> Repo.delete
  end

  def change_position model, attrs do
    query_context = all()
    Position.set model, query_context, attrs
  end

  def fetch_all do
    all() |> Repo.all
  end

end