defmodule Support.SessionController do
  use Support.Web, :controller

  import Comeonin.Bcrypt, only: [checkpw: 2]

  alias Support.User

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn,%{"session" => %{"email" => email ,"password" => password}}) do
    IO.inspect email
    IO.inspect password
    user = Repo.get_by(User, email: email)
    IO.inspect(user.encrypted_password)
    if user && checkpw(password, user.encrypted_password) do
      conn
        |> put_session(:current_user, user.id)
        |> put_flash(:info, "logged in!")
        |> redirect(to: "/")
    else
      conn
        |> put_flash(:error, "Invalid credentials")
    end
  end

  def delete(conn,_params) do
    conn
      |> configure_session(drop: true)
      |> put_flash(:info, "logged out!")
      |> redirect(to: "/")
  end

end