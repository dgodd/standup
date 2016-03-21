ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Standup.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Standup.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Standup.Repo)

