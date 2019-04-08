defmodule LocalePlug do
  @moduledoc """
  Fetch locale from params or cookies and set it for the specified Gettext backend.

  ## Example

      plug LocalePlug, backend: MyApp.Gettext
  """

  import Plug.Conn

  @max_age 365 * 24 * 60 * 60

  def init(opts) do
    backend = Keyword.fetch!(opts, :backend)
    [backend: backend]
  end

  def call(conn, [backend: backend]) do
    case fetch_locale(conn, backend) do
      nil ->
        conn
      locale ->
        Gettext.put_locale(backend, locale)
        put_resp_cookie(conn, "locale", locale, max_age: @max_age)
    end
  end

  defp fetch_locale(conn, backend) do
    (conn.params["locale"] || conn.cookies["locale"])
    |> check_locale(backend)
  end

  defp check_locale(locale, backend) do
    supported_locales = Gettext.known_locales(backend)
    if locale in supported_locales do
      locale
    else
      nil
    end
  end
end
