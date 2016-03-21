defmodule Standup.StandupControllerTest do
  use Standup.ConnCase

  alias Standup.Standup
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, standup_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing standups"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, standup_path(conn, :new)
    assert html_response(conn, 200) =~ "New standup"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, standup_path(conn, :create), standup: @valid_attrs
    assert redirected_to(conn) == standup_path(conn, :index)
    assert Repo.get_by(Standup, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, standup_path(conn, :create), standup: @invalid_attrs
    assert html_response(conn, 200) =~ "New standup"
  end

  test "shows chosen resource", %{conn: conn} do
    standup = Repo.insert! %Standup{}
    conn = get conn, standup_path(conn, :show, standup)
    assert html_response(conn, 200) =~ "Show standup"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, standup_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    standup = Repo.insert! %Standup{}
    conn = get conn, standup_path(conn, :edit, standup)
    assert html_response(conn, 200) =~ "Edit standup"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    standup = Repo.insert! %Standup{}
    conn = put conn, standup_path(conn, :update, standup), standup: @valid_attrs
    assert redirected_to(conn) == standup_path(conn, :show, standup)
    assert Repo.get_by(Standup, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    standup = Repo.insert! %Standup{}
    conn = put conn, standup_path(conn, :update, standup), standup: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit standup"
  end

  test "deletes chosen resource", %{conn: conn} do
    standup = Repo.insert! %Standup{}
    conn = delete conn, standup_path(conn, :delete, standup)
    assert redirected_to(conn) == standup_path(conn, :index)
    refute Repo.get(Standup, standup.id)
  end
end
