defmodule FrancisRender do
  use Francis

  get("/", fn _ -> "<html>world</html>" end)
  get("/:name", fn %{params: %{"name" => name}} -> "hello #{name}" end)

  unmatched(fn _ -> "not found" end)
end
