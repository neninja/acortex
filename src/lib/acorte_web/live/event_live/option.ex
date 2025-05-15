defmodule AcorteWeb.EventLive.Option do
  use Phoenix.LiveComponent

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <button class="css-framework-class" phx-click="click">
      {@text}
    </button>
    """
  end
end
