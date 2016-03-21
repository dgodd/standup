defmodule Standup.StandupTest do
  use Standup.ModelCase

  alias Standup.Standup

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Standup.changeset(%Standup{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Standup.changeset(%Standup{}, @invalid_attrs)
    refute changeset.valid?
  end
end
