defmodule EventsWeb.HappeningController do
  use EventsWeb, :controller

  alias Events.Happenings
  alias Events.Happenings.Happening

  action_fallback EventsWeb.FallbackController

  def index(conn, _params) do
    happenings = Happenings.list_happenings()
    render(conn, "index.json", happenings: happenings)
  end

  def create(conn, %{"happening" => happening_params}) do
    with {:ok, %Happening{} = happening} <- Happenings.create_happening(happening_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.happening_path(conn, :show, happening))
      |> render("show.json", happening: happening)
    end
  end

  def show(conn, %{"id" => id}) do
    happening = Happenings.get_happening!(id)
    render(conn, "show.json", happening: happening)
  end

  def update(conn, %{"id" => id, "happening" => happening_params}) do
    happening = Happenings.get_happening!(id)

    with {:ok, %Happening{} = happening} <- Happenings.update_happening(happening, happening_params) do
      render(conn, "show.json", happening: happening)
    end
  end

  def delete(conn, %{"id" => id}) do
    happening = Happenings.get_happening!(id)

    with {:ok, %Happening{}} <- Happenings.delete_happening(happening) do
      send_resp(conn, :no_content, "")
    end
  end
end
