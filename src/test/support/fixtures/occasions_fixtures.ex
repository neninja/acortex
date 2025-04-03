defmodule Acorte.OccasionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Acorte.Occasions` context.
  """

  @doc """
  Generate a occasion.
  """
  def occasion_fixture(attrs \\ %{}) do
    {:ok, occasion} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title"
      })
      |> Acorte.Occasions.create_occasion()

    occasion
  end
end
