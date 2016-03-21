defmodule Standup.StandupController do
  use Standup.Web, :controller

  alias Standup.Standup

  plug :scrub_params, "standup" when action in [:create, :update]

  def index(conn, _params) do
    standups = Repo.all(Standup)
    render(conn, "index.html", standups: standups)
  end

  def new(conn, _params) do
    changeset = Standup.changeset(%Standup{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"standup" => standup_params}) do
    changeset = Standup.changeset(%Standup{}, standup_params)

    case Repo.insert(changeset) do
      {:ok, _standup} ->
        conn
        |> put_flash(:info, "Standup created successfully.")
        |> redirect(to: standup_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    standup = Repo.get!(Standup, id)
    render(conn, "show.html", standup: standup)
  end

  def edit(conn, %{"id" => id}) do
    standup = Repo.get!(Standup, id)
    changeset = Standup.changeset(standup)
    render(conn, "edit.html", standup: standup, changeset: changeset)
  end

  def update(conn, %{"id" => id, "standup" => standup_params}) do
    standup = Repo.get!(Standup, id)
    changeset = Standup.changeset(standup, standup_params)

    case Repo.update(changeset) do
      {:ok, standup} ->
        conn
        |> put_flash(:info, "Standup updated successfully.")
        |> redirect(to: standup_path(conn, :show, standup))
      {:error, changeset} ->
        render(conn, "edit.html", standup: standup, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    standup = Repo.get!(Standup, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(standup)

    conn
    |> put_flash(:info, "Standup deleted successfully.")
    |> redirect(to: standup_path(conn, :index))
  end
end
