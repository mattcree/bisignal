defmodule BisignalWeb.ParticipantControllerTest do
  use BisignalWeb.ConnCase

  alias Bisignal.Ride

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:participant) do
    {:ok, participant} = Ride.create_participant(@create_attrs)
    participant
  end

  describe "index" do
    test "lists all participants", %{conn: conn} do
      conn = get conn, participant_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Participants"
    end
  end

  describe "new participant" do
    test "renders form", %{conn: conn} do
      conn = get conn, participant_path(conn, :new)
      assert html_response(conn, 200) =~ "New Participant"
    end
  end

  describe "create participant" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, participant_path(conn, :create), participant: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == participant_path(conn, :show, id)

      conn = get conn, participant_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Participant"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, participant_path(conn, :create), participant: @invalid_attrs
      assert html_response(conn, 200) =~ "New Participant"
    end
  end

  describe "edit participant" do
    setup [:create_participant]

    test "renders form for editing chosen participant", %{conn: conn, participant: participant} do
      conn = get conn, participant_path(conn, :edit, participant)
      assert html_response(conn, 200) =~ "Edit Participant"
    end
  end

  describe "update participant" do
    setup [:create_participant]

    test "redirects when data is valid", %{conn: conn, participant: participant} do
      conn = put conn, participant_path(conn, :update, participant), participant: @update_attrs
      assert redirected_to(conn) == participant_path(conn, :show, participant)

      conn = get conn, participant_path(conn, :show, participant)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, participant: participant} do
      conn = put conn, participant_path(conn, :update, participant), participant: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Participant"
    end
  end

  describe "delete participant" do
    setup [:create_participant]

    test "deletes chosen participant", %{conn: conn, participant: participant} do
      conn = delete conn, participant_path(conn, :delete, participant)
      assert redirected_to(conn) == participant_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, participant_path(conn, :show, participant)
      end
    end
  end

  defp create_participant(_) do
    participant = fixture(:participant)
    {:ok, participant: participant}
  end
end
