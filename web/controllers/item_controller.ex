defmodule Standup.ItemController do
  use Standup.Web, :controller
  import Ecto.Query

  alias Standup.Item

  plug :scrub_params, "item" when action in [:create, :update]
  plug :load_standup when action in [:index]

  def index(conn,  _) do
    standup = conn.assigns[:standup]
    render(conn, "index.html", items: standup.items, standup: standup)
  end
  
  def new(conn,  %{"standup_id" => standup_id}) do
    changeset = Item.changeset(%Item{})
    standup = Repo.get!(Standup.Standup, standup_id)
    render(conn, "new.html", changeset: changeset, standup: standup)
  end

  def create(conn, %{"standup_id" => standup_id, "item" => item_params}) do
    changeset = Item.changeset(%Item{}, item_params)
    standup = Repo.get!(Standup.Standup, standup_id)

    case Repo.insert(changeset) do
      {:ok, _item} ->
        conn
        |> put_flash(:info, "Item created successfully.")
        |> redirect(to: standup_item_path(conn, :index, standup))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, standup: standup)
    end
  end

  def show(conn, %{"id" => id}) do
    item = Repo.get!(Item, id)
    render(conn, "show.html", item: item)
  end

  def edit(conn, %{"standup_id" => standup_id, "id" => id}) do
    item = Repo.get!(Item, id)
    standup = Repo.get!(Standup.Standup, standup_id)
    changeset = Item.changeset(item)
    render(conn, "edit.html", item: item, changeset: changeset, standup: standup)
  end

  def update(conn, %{"standup_id" => standup_id, "id" => id, "item" => item_params}) do
    item = Repo.get!(Item, id)
    changeset = Item.changeset(item, item_params)
    standup = Repo.get!(Standup.Standup, standup_id)

    case Repo.update(changeset) do
      {:ok, item} ->
        conn
        |> put_flash(:info, "Item updated successfully.")
        |> redirect(to: standup_item_path(conn, :show, standup, item))
      {:error, changeset} ->
        render(conn, "edit.html", item: item, changeset: changeset)
    end
  end

  def delete(conn, %{"standup_id" => standup_id, "id" => id}) do
    item = Repo.get!(Item, id)
    standup = Repo.get!(Standup.Standup, standup_id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(item)

    conn
    |> put_flash(:info, "Item deleted successfully.")
    |> redirect(to: standup_item_path(conn, :index, standup: standup))
  end
  
  defp load_standup(conn, _) do
    standup = Repo.get!(Standup.Standup, conn.params["standup_id"]) |> Repo.preload(:items)    
    assign(conn, :standup, standup)
  end
end
