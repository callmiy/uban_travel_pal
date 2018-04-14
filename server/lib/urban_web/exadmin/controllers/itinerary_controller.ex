defmodule UrbanWeb.ExAdmin.ItineraryController do
  @resource "itineraries"
  use ExAdmin.Web, :resource_controller

  alias Urban.Itinerary
  alias Urban.Repo

  def create(conn, defn, %{itinerary: it_params} = params) do
    model = defn.__struct__
    change = Itinerary.changeset_no_image(%Itinerary{}, it_params)
    resource = conn.assigns.resource

    Repo.transaction(fn ->
      with {:ok, it1} <- Repo.insert(change),
           {:ok, it2} <- Itinerary.changeset(it1, it_params) |> Repo.update() do
        it2
      else
        {:error, changeset} ->
          Repo.rollback(changeset)
          {:error, changeset}
      end
    end)
    |> case do
      {:error, changeset} ->
        changeset = %{
          changeset
          | required: [:title, :description, :image],
            action: :insert
        }

        changeset_errors =
          ExAdmin.ErrorsHelper.create_errors(
            changeset,
            defn.resource_model
          )

        conn =
          put_flash(conn, :inline_error, changeset_errors)
          |> Plug.Conn.assign(:changeset, changeset)
          |> Plug.Conn.assign(:ea_required, changeset.required)

        data =
          changeset
          |> ExAdmin.Changeset.get_data()
          |> Map.put(:id, nil)

        contents =
          do_form_view(
            conn,
            data,
            params
          )

        conn
        |> put_view(ExAdmin.AdminView)
        |> render(
          "admin.html",
          html: contents,
          filters: nil
        )

      {:ok, resource} ->
        {conn, _, resource} =
          handle_after_filter(
            conn,
            :create,
            defn,
            params,
            resource
          )

        put_flash(
          conn,
          :notice,
          gettext(
            "%{model_name} was successfully created.",
            model_name: model |> base_name |> titleize
          )
        )
        |> redirect(to: admin_resource_path(resource, :show))
    end
  end
end
