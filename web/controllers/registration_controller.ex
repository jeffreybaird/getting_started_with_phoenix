defmodule Support.RegistrationController do
  use Support.Web, :controller

  alias Support.User

  plug :scrub_params, "user" when action in [:create]

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
          |> put_flash(:info, "registered successfully!")
          |> put_session(:current_user, user.id)
          |> redirect(to: "/")
      {:error, changeset} ->
        conn
          |> render("new.html",changeset: changeset)
    end
  end

end
