defmodule KanbanWeb.CamelJSONEncoder do
  use ProperCase.JSONEncoder, transform: &ProperCase.to_camel_case/1
end