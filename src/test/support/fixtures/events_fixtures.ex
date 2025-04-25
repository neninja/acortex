defmodule Acorte.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Acorte.Events` context.
  """

  @doc """
  Generate a event.
  """
  def event_fixture(attrs \\ %{}) do
    {:ok, event} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title"
      })
      |> Acorte.Events.create_event()

    event
  end
end
