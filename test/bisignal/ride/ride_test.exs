defmodule Bisignal.RideTest do
  use Bisignal.DataCase

  alias Bisignal.Ride

  describe "route_details" do
    alias Bisignal.Ride.RouteDetail

    @valid_attrs %{datetime: "2010-04-17 14:00:00.000000Z", description: "some description", end: "some end", name: "some name", start: "some start"}
    @update_attrs %{datetime: "2011-05-18 15:01:01.000000Z", description: "some updated description", end: "some updated end", name: "some updated name", start: "some updated start"}
    @invalid_attrs %{datetime: nil, description: nil, end: nil, name: nil, start: nil}

    def route_detail_fixture(attrs \\ %{}) do
      {:ok, route_detail} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ride.create_route_detail()

      route_detail
    end

    test "list_route_details/0 returns all route_details" do
      route_detail = route_detail_fixture()
      assert Ride.list_route_details() == [route_detail]
    end

    test "get_route_detail!/1 returns the route_detail with given id" do
      route_detail = route_detail_fixture()
      assert Ride.get_route_detail!(route_detail.id) == route_detail
    end

    test "create_route_detail/1 with valid data creates a route_detail" do
      assert {:ok, %RouteDetail{} = route_detail} = Ride.create_route_detail(@valid_attrs)
      assert route_detail.datetime == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert route_detail.description == "some description"
      assert route_detail.end == "some end"
      assert route_detail.name == "some name"
      assert route_detail.start == "some start"
    end

    test "create_route_detail/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ride.create_route_detail(@invalid_attrs)
    end

    test "update_route_detail/2 with valid data updates the route_detail" do
      route_detail = route_detail_fixture()
      assert {:ok, route_detail} = Ride.update_route_detail(route_detail, @update_attrs)
      assert %RouteDetail{} = route_detail
      assert route_detail.datetime == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert route_detail.description == "some updated description"
      assert route_detail.end == "some updated end"
      assert route_detail.name == "some updated name"
      assert route_detail.start == "some updated start"
    end

    test "update_route_detail/2 with invalid data returns error changeset" do
      route_detail = route_detail_fixture()
      assert {:error, %Ecto.Changeset{}} = Ride.update_route_detail(route_detail, @invalid_attrs)
      assert route_detail == Ride.get_route_detail!(route_detail.id)
    end

    test "delete_route_detail/1 deletes the route_detail" do
      route_detail = route_detail_fixture()
      assert {:ok, %RouteDetail{}} = Ride.delete_route_detail(route_detail)
      assert_raise Ecto.NoResultsError, fn -> Ride.get_route_detail!(route_detail.id) end
    end

    test "change_route_detail/1 returns a route_detail changeset" do
      route_detail = route_detail_fixture()
      assert %Ecto.Changeset{} = Ride.change_route_detail(route_detail)
    end
  end

  describe "waypoints" do
    alias Bisignal.Ride.Waypoint

    @valid_attrs %{waypoint: "some waypoint", waypoint_number: 42}
    @update_attrs %{waypoint: "some updated waypoint", waypoint_number: 43}
    @invalid_attrs %{waypoint: nil, waypoint_number: nil}

    def waypoint_fixture(attrs \\ %{}) do
      {:ok, waypoint} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ride.create_waypoint()

      waypoint
    end

    test "list_waypoints/0 returns all waypoints" do
      waypoint = waypoint_fixture()
      assert Ride.list_waypoints() == [waypoint]
    end

    test "get_waypoint!/1 returns the waypoint with given id" do
      waypoint = waypoint_fixture()
      assert Ride.get_waypoint!(waypoint.id) == waypoint
    end

    test "create_waypoint/1 with valid data creates a waypoint" do
      assert {:ok, %Waypoint{} = waypoint} = Ride.create_waypoint(@valid_attrs)
      assert waypoint.waypoint == "some waypoint"
      assert waypoint.waypoint_number == 42
    end

    test "create_waypoint/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ride.create_waypoint(@invalid_attrs)
    end

    test "update_waypoint/2 with valid data updates the waypoint" do
      waypoint = waypoint_fixture()
      assert {:ok, waypoint} = Ride.update_waypoint(waypoint, @update_attrs)
      assert %Waypoint{} = waypoint
      assert waypoint.waypoint == "some updated waypoint"
      assert waypoint.waypoint_number == 43
    end

    test "update_waypoint/2 with invalid data returns error changeset" do
      waypoint = waypoint_fixture()
      assert {:error, %Ecto.Changeset{}} = Ride.update_waypoint(waypoint, @invalid_attrs)
      assert waypoint == Ride.get_waypoint!(waypoint.id)
    end

    test "delete_waypoint/1 deletes the waypoint" do
      waypoint = waypoint_fixture()
      assert {:ok, %Waypoint{}} = Ride.delete_waypoint(waypoint)
      assert_raise Ecto.NoResultsError, fn -> Ride.get_waypoint!(waypoint.id) end
    end

    test "change_waypoint/1 returns a waypoint changeset" do
      waypoint = waypoint_fixture()
      assert %Ecto.Changeset{} = Ride.change_waypoint(waypoint)
    end
  end

  describe "participants" do
    alias Bisignal.Ride.Participant

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def participant_fixture(attrs \\ %{}) do
      {:ok, participant} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Ride.create_participant()

      participant
    end

    test "list_participants/0 returns all participants" do
      participant = participant_fixture()
      assert Ride.list_participants() == [participant]
    end

    test "get_participant!/1 returns the participant with given id" do
      participant = participant_fixture()
      assert Ride.get_participant!(participant.id) == participant
    end

    test "create_participant/1 with valid data creates a participant" do
      assert {:ok, %Participant{} = participant} = Ride.create_participant(@valid_attrs)
    end

    test "create_participant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Ride.create_participant(@invalid_attrs)
    end

    test "update_participant/2 with valid data updates the participant" do
      participant = participant_fixture()
      assert {:ok, participant} = Ride.update_participant(participant, @update_attrs)
      assert %Participant{} = participant
    end

    test "update_participant/2 with invalid data returns error changeset" do
      participant = participant_fixture()
      assert {:error, %Ecto.Changeset{}} = Ride.update_participant(participant, @invalid_attrs)
      assert participant == Ride.get_participant!(participant.id)
    end

    test "delete_participant/1 deletes the participant" do
      participant = participant_fixture()
      assert {:ok, %Participant{}} = Ride.delete_participant(participant)
      assert_raise Ecto.NoResultsError, fn -> Ride.get_participant!(participant.id) end
    end

    test "change_participant/1 returns a participant changeset" do
      participant = participant_fixture()
      assert %Ecto.Changeset{} = Ride.change_participant(participant)
    end
  end
end
