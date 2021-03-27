defmodule EventsWeb.HappeningControllerTest do
  use EventsWeb.ConnCase

  alias Events.Happenings
  alias Events.Happenings.Happening

  @create_attrs %{
    date: ~N[2010-04-17 14:00:00],
    description: "some description",
    name: "some name"
  }
  @update_attrs %{
    date: ~N[2011-05-18 15:01:01],
    description: "some updated description",
    name: "some updated name"
  }
  @invalid_attrs %{date: nil, description: nil, name: nil}

  def fixture(:happening) do
    {:ok, happening} = Happenings.create_happening(@create_attrs)
    happening
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all happenings", %{conn: conn} do
      conn = get(conn, Routes.happening_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create happening" do
    test "renders happening when data is valid", %{conn: conn} do
      conn = post(conn, Routes.happening_path(conn, :create), happening: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.happening_path(conn, :show, id))

      assert %{
               "id" => id,
               "date" => "2010-04-17T14:00:00",
               "description" => "some description",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.happening_path(conn, :create), happening: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update happening" do
    setup [:create_happening]

    test "renders happening when data is valid", %{conn: conn, happening: %Happening{id: id} = happening} do
      conn = put(conn, Routes.happening_path(conn, :update, happening), happening: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.happening_path(conn, :show, id))

      assert %{
               "id" => id,
               "date" => "2011-05-18T15:01:01",
               "description" => "some updated description",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, happening: happening} do
      conn = put(conn, Routes.happening_path(conn, :update, happening), happening: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete happening" do
    setup [:create_happening]

    test "deletes chosen happening", %{conn: conn, happening: happening} do
      conn = delete(conn, Routes.happening_path(conn, :delete, happening))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.happening_path(conn, :show, happening))
      end
    end
  end

  defp create_happening(_) do
    happening = fixture(:happening)
    %{happening: happening}
  end
end
