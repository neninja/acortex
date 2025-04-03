defmodule AcorteWeb.OccasionHTML do
  use AcorteWeb, :html

  embed_templates "occasion_html/*"

  @doc """
  Renders a occasion form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def occasion_form(assigns)
end
