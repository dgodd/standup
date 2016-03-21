defmodule Standup.ItemControllerTest do
  use Standup.ConnCase

  alias Standup.Item
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists the entries for the standup on index", %{conn: conn} do
    standup = Repo.insert! %Standup.Standup{}

    Repo.insert! %Standup.Item{name: "Not for this standup"}
    Repo.insert! %Standup.Item{name: "My item", standup: standup}
  
    conn = get conn, standup_item_path(conn, :index, standup)
    assert html_response(conn, 200) =~ "Listing items"
    assert html_response(conn, 200) =~ "My item"
    refute html_response(conn, 200) =~ "Not for this standup"
  end

end
