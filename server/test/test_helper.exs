{:ok, _} = Application.ensure_all_started(:ex_machina)
Absinthe.Test.prime(UrbanWeb.Schema)
ExUnit.start(exclude: [norun: true])
Ecto.Adapters.SQL.Sandbox.mode(Urban.Repo, :manual)
