defmodule TechPhone.RoomController do
  use TechPhone.Web, :controller

  def index(conn, params) do
    digits = params["Digits"]
    if is_nil(digits) do
      render conn, "index.xml"
    else
      render conn, "show.xml", room_code: digits
    end
  end
end
