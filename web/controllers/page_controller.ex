defmodule Standup.PageController do
  use Standup.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
