defmodule UrbanWeb.ValidationView do
  use UrbanWeb, :view
  alias UrbanWeb.ValidationView

  def render("index.json", %{validation: validation}) do
    %{data: render_many(validation, ValidationView, "validation.json")}
  end

  def render("show.json", %{validation: validation}) do
    %{data: render_one(validation, ValidationView, "validation.json")}
  end

  def render("validation.json", %{validation: validation}) do
    %{id: validation.id, name: validation.name}
  end

  def render("validate.json", %{response: response}) do
    response
  end

  def render("itineraries", data) do
    data
  end
end
