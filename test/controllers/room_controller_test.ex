defmodule TechPhone.RoomControllerTest do
  use TechPhone.ConnCase

  test "GET /room" do
    # Introduce the conference platform
    conn = get conn(), "/api/room"
    assert response_content_type(conn, :xml)
    assert response(conn, 200) =~ "Welcome to Cage Data's Conference Room"
  end

  test "GET /room with digits" do
    # With Digits param, a conference room is opened
    conn = get conn(), "/api/room", %{"Digits": "1234"}
    assert response(conn, 200) =~ "1234"
  end
end
