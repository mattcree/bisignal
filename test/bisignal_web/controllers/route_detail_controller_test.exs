defmodule BisignalWeb.RouteDetailControllerTest do
  use BisignalWeb.ConnCase

  alias Bisignal.Ride

  @create_attrs %{datetime: "2010-04-17 14:00:00.000000Z", description: "some description", end: "some end", name: "some name", start: "some start"}
  @update_attrs %{datetime: "2011-05-18 15:01:01.000000Z", description: "some updated description", end: "some updated end", name: "some updated name", start: "some updated start"}
  @invalid_attrs %{datetime: nil, description: nil, end: nil, name: nil, start: nil}

  def fixture(:route_detail) do
    {:ok, route_detail} = Ride.create_route_detail(@create_attrs)
    route_detail
  end

  describe "index" do
    test "lists all route_details", %{conn: conn} do
      conn = get conn, route_detail_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Route details"
    end
  end

  describe "new route_detail" do
    test "renders form", %{conn: conn} do
      conn = get conn, route_detail_path(conn, :new)
      assert html_response(conn, 200) =~ "New Route detail"
    end
  end

  describe "create route_detail" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, route_detail_path(conn, :create), route_detail: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == route_detail_path(conn, :show, id)

      conn = get conn, route_detail_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Route detail"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, route_detail_path(conn, :create), route_detail: @invalid_attrs
      assert html_response(conn, 200) =~ "New Route detail"
    end
  end

  describe "edit route_detail" do
    setup [:create_route_detail]

    test "renders form for editing chosen route_detail", %{conn: conn, route_detail: route_detail} do
      conn = get conn, route_detail_path(conn, :edit, route_detail)
      assert html_response(conn, 200) =~ "Edit Route detail"
    end
  end

  describe "update route_detail" do
    setup [:create_route_detail]

    test "redirects when data is valid", %{conn: conn, route_detail: route_detail} do
      conn = put conn, route_detail_path(conn, :update, route_detail), route_detail: @update_attrs
      assert redirected_to(conn) == route_detail_path(conn, :show, route_detail)

      conn = get conn, route_detail_path(conn, :show, route_detail)
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, route_detail: route_detail} do
      conn = put conn, route_detail_path(conn, :update, route_detail), route_detail: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Route detail"
    end
  end

  describe "delete route_detail" do
    setup [:create_route_detail]

    test "deletes chosen route_detail", %{conn: conn, route_detail: route_detail} do
      conn = delete conn, route_detail_path(conn, :delete, route_detail)
      assert redirected_to(conn) == route_detail_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, route_detail_path(conn, :show, route_detail)
      end
    end
  end

  defp create_route_detail(_) do
    route_detail = fixture(:route_detail)
    {:ok, route_detail: route_detail}
  end
end
