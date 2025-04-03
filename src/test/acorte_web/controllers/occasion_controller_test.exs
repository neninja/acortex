defmodule AcorteWeb.OccasionControllerTest do
  use AcorteWeb.ConnCase

  import Acorte.OccasionsFixtures

  @create_attrs %{description: "some description", title: "some title"}
  @update_attrs %{description: "some updated description", title: "some updated title"}
  @invalid_attrs %{description: nil, title: nil}

  describe "index" do
    test "lists all occasions", %{conn: conn} do
      conn = get(conn, ~p"/occasions")
      assert html_response(conn, 200) =~ "Listing Occasions"
    end
  end

  describe "new occasion" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/occasions/new")
      assert html_response(conn, 200) =~ "New Occasion"
    end
  end

  describe "create occasion" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/occasions", occasion: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/occasions/#{id}"

      conn = get(conn, ~p"/occasions/#{id}")
      assert html_response(conn, 200) =~ "Occasion #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/occasions", occasion: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Occasion"
    end
  end

  describe "edit occasion" do
    setup [:create_occasion]

    test "renders form for editing chosen occasion", %{conn: conn, occasion: occasion} do
      conn = get(conn, ~p"/occasions/#{occasion}/edit")
      assert html_response(conn, 200) =~ "Edit Occasion"
    end
  end

  describe "update occasion" do
    setup [:create_occasion]

    test "redirects when data is valid", %{conn: conn, occasion: occasion} do
      conn = put(conn, ~p"/occasions/#{occasion}", occasion: @update_attrs)
      assert redirected_to(conn) == ~p"/occasions/#{occasion}"

      conn = get(conn, ~p"/occasions/#{occasion}")
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, occasion: occasion} do
      conn = put(conn, ~p"/occasions/#{occasion}", occasion: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Occasion"
    end
  end

  describe "delete occasion" do
    setup [:create_occasion]

    test "deletes chosen occasion", %{conn: conn, occasion: occasion} do
      conn = delete(conn, ~p"/occasions/#{occasion}")
      assert redirected_to(conn) == ~p"/occasions"

      assert_error_sent 404, fn ->
        get(conn, ~p"/occasions/#{occasion}")
      end
    end
  end

  defp create_occasion(_) do
    occasion = occasion_fixture()
    %{occasion: occasion}
  end
end
