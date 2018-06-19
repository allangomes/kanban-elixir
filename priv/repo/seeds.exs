# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
Kanban.Repo.insert!(%Kanban.Model.Board{
  title: "Blue Board",
  description: "Blue Board",
  color: "blue"
})

best = Kanban.Repo.insert!(%Kanban.Model.Board{
  title: "The Bests",
  description: "Go Brazil!!!",
  color: "green"
})

todo = Kanban.Repo.insert!(%Kanban.Model.List{
  title: "TODO",
  color: "orange",
  board_id: best.id
})

doing = Kanban.Repo.insert!(%Kanban.Model.List{
  title: "DOING",
  color: "green",
  board_id: best.id
})

done = Kanban.Repo.insert!(%Kanban.Model.List{
  title: "DONE",
  color: "blue",
  board_id: best.id
})

Kanban.Repo.insert!(%Kanban.Model.Card{
  title: "Pink Floyd",
  description: "Dogs, Shine On, Echoes...",
  position: 1,
  color: "red",
  board_id: best.id,
  list_id: todo.id
})

Kanban.Repo.insert!(%Kanban.Model.Card{
  title: "Angra",
  description: "Running Alone, Rebith, Unholy Wars...",
  position: 2,
  color: "red",
  board_id: best.id,
  list_id: todo.id
})

Kanban.Repo.insert!(%Kanban.Model.Card{
  title: "Rhapsody Of Fire",
  description: "Smerald Shord, Unholy Warcry, Dawn of Victory...",
  position: 3,
  color: "red",
  board_id: best.id,
  list_id: todo.id
})

Kanban.Repo.insert!(%Kanban.Model.Card{
  title: "Interestellar",
  description: "The best movie in the universe.",
  position: 1,
  color: "blue",
  board_id: best.id,
  list_id: doing.id
})

Kanban.Repo.insert!(%Kanban.Model.Card{
  title: "Star Wars",
  description: "A long time ago in a galaxy far, far away...",
  position: 2,
  color: "blue",
  board_id: best.id,
  list_id: doing.id
})


#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
