defmodule TechPhone.Router do
  use TechPhone.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["xml"]
  end

  scope "/", TechPhone do
    pipe_through :browser # Use the default browser stack
  end

  # Other scopes may use custom stacks.
  scope "/api", TechPhone do
    pipe_through :api

    get "/room", RoomController, :index

    scope "/voicemail" do
      get "/", VoicemailController, :phone_number
      get "/name-company", VoicemailController, :name_company
      get "/message", VoicemailController, :message
      get "/finalize", VoicemailController, :finalize
    end
  end
end
