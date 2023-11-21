defmodule FrancisRender do
  use Francis, bandit_opts: [ip: {0, 0, 0, 0}]

  get("/", fn _ -> "<html>world</html>" end)
  get("/db_password", fn _ -> Application.fetch_env!(:francis_render, :db_password) end)
  get("/:name", fn %{params: %{"name" => name}} -> "hello #{name}" end)

  unmatched(fn _ -> "not found" end)
end
