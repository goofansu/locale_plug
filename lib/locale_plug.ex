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

  def call(conn, backend: backend) do
    case fetch_locale(conn) |> validate_locale(backend) do
      {:ok, locale} ->
        Gettext.put_locale(backend, locale)
        put_resp_cookie(conn, "locale", locale, max_age: @max_age)

      :error ->
        conn
    end
  end

  defp fetch_locale(%{params: %{"locale" => locale}}), do: {:ok, locale}
  defp fetch_locale(%{cookies: %{"locale" => locale}}), do: {:ok, locale}
  defp fetch_locale(_), do: :error

  defp validate_locale({:ok, locale}, backend) do
    supported_locales = Gettext.known_locales(backend)

    if locale in supported_locales do
      {:ok, locale}
    else
      :error
    end
  end

  defp validate_locale(:error, _), do: :error
end
