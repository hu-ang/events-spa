defmodule EventsWeb.HappeningView do
  use EventsWeb, :view
  alias EventsWeb.HappeningView

  def render("index.json", %{happenings: happenings}) do
    %{data: render_many(happenings, HappeningView, "happening.json")}
  end

  def render("show.json", %{happening: happening}) do
    %{data: render_one(happening, HappeningView, "happening.json")}
  end

  def render("happening.json", %{happening: happening}) do
    %{id: happening.id,
      name: happening.name,
      date: happening.date,
      description: happening.description}
  end
end
