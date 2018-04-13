defmodule Urban.Factory do
  use ExMachina.Ecto, repo: Urban.Repo

  alias Urban.TravelPref
  alias Urban.BotInteraction
  alias Urban.BotUser
  alias Urban.Itinerary

  @now Timex.now()

  @metadata %{
    "firstTimeUser" => true,
    "browserName" => "Chrome Mobile",
    "browserVersion" => "65.0.3325.181",
    "operatingSystem" => "Android",
    "operatingSystemVersion" => "5.0",
    "deviceProduct" => "Galaxy S5",
    "mobile" => true
  }

  def travel_pref_factory do
    %TravelPref{
      activities: [sequence("activity")],
      budget: sequence("budget"),
      city: sequence("city"),
      meet_locals: true,
      plan_type: sequence("plan_type"),
      purpose: [sequence("travel purpose")],
      tourist_attraction: true,
      bot_interaction: build(:bot_int)
    }
  end

  def bot_int_factory do
    %BotInteraction{
      bot_connection_id: sequence("bot_connection_id"),
      bot_id: sequence("bot_id"),
      bot_name: sequence("bot_name"),
      bot_platform: sequence("bot_platform"),
      channel_id: sequence("channel_id"),
      datetime: @now,
      message: sequence("message"),
      message_type: sequence("message_type"),
      metadata: @metadata,
      response_path: sequence("response_path"),
      bot_user: build(:bot_user)
    }
  end

  def bot_user_factory do
    %BotUser{
      email: sequence("me@bot_user.com"),
      bot_user_id: sequence("some bot_user_id"),
      user_response_name: sequence("some user_response_name")
    }
  end

  def itinerary_factory do
    seq = sequence("")
    path = "../server/test/uploads/beans.png"

    %Itinerary{
      title: "Itinerary title #{seq}",
      description: "Itinerary description #{seq}",
      image: path
    }
  end
end
