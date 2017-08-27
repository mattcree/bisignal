defmodule BisignalWeb.WaypointControllerTest do
  use BisignalWeb.ConnCase

  alias Bisignal.Ride

  @create_attrs %{waypoint: "some waypoint", waypoint_number: 42}
  @update_attrs %{waypoint: "some updated waypoint", waypoint_number: 43}
  @invalid_attrs %{waypoint: nil, waypoint_number: nil}

  def fixture(:waypoint) do
    {:ok, waypoint} = Ride.create_waypoint(@create_attrs)
    waypoint
  end

  describe "index" do
    test "lists all waypoints", %{conn: conn} do
      conn = get conn, waypoint_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Waypoints"
    end
  end

  describe "new waypoint" do
    test "renders form", %{conn: conn} do
      conn = get conn, waypoint_path(conn, :new)
      assert html_response(conn, 200) =~ "New Waypoint"
    end
  end

  describe "create waypoint" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, waypoint_path(conn, :create), waypoint: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == waypoint_path(conn, :show, id)

      conn = get conn, waypoint_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Waypoint"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, waypoint_path(conn, :create), waypoint: @invalid_attrs
      assert html_response(conn, 200) =~ "New Waypoint"
    end
  end

  describe "edit waypoint" do
    setup [:create_waypoint]

    test "renders form for editing chosen waypoint", %{conn: conn, waypoint: waypoint} do
      conn = get conn, waypoint_path(conn, :edit, waypoint)
      assert html_response(conn, 200) =~ "Edit Waypoint"
    end
  end

  describe "update waypoint" do
    setup [:create_waypoint]

    test "redirects when data is valid", %{conn: conn, waypoint: waypoint} do
      conn = put conn, waypoint_path(conn, :update, waypoint), waypoint: @update_attrs
      assert redirected_to(conn) == waypoint_path(conn, :show, waypoint)

      conn = get conn, waypoint_path(conn, :show, waypoint)
      assert html_response(conn, 200) =~ "some updated waypoint"
    end

    test "renders errors when data is invalid", %{conn: conn, waypoint: waypoint} do
      conn = put conn, waypoint_path(conn, :update, waypoint), waypoint: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Waypoint"
    end
  end

  describe "delete waypoint" do
    setup [:create_waypoint]

    test "deletes chosen waypoint", %{conn: conn, waypoint: waypoint} do
      conn = delete conn, waypoint_path(conn, :delete, waypoint)
      assert redirected_to(conn) == waypoint_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, waypoint_path(conn, :show, waypoint)
      end
    end
  end

  defp create_waypoint(_) do
    waypoint = fixture(:waypoint)
    {:ok, waypoint: waypoint}
  end
end
