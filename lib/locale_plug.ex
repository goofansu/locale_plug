defmodule LocalePlug do
  @moduledoc """
  Fetch locale and set it for the specified Gettext backend.

  Detect locale in following order: params > cookies > accept-language header
  """

  import Plug.Conn

  @max_age 365 * 24 * 60 * 60

  def init(opts) do
    backend = Keyword.fetch!(opts, :backend)
    [backend: backend]
  end

  def call(conn, backend: backend) do
    case fetch_locale(conn, backend) do
      nil ->
        conn

      locale ->
        Gettext.put_locale(backend, locale)

        conn
        |> put_resp_header("content-language", locale_to_language(locale))
        |> put_resp_cookie("locale", locale, max_age: @max_age)
    end
  end

  defp fetch_locale(conn, backend) do
    fetch_locale_from_params(conn, backend) ||
      fetch_locale_from_cookies(conn, backend) ||
      fetch_locale_from_headers(conn, backend)
  end

  defp fetch_locale_from_params(conn, backend) do
    conn.params["locale"] |> validate_locale(backend)
  end

  defp fetch_locale_from_cookies(conn, backend) do
    conn.cookies["locale"] |> validate_locale(backend)
  end

  defp fetch_locale_from_headers(conn, backend) do
    conn
    |> locales_from_accept_language()
    |> Enum.find(fn locale -> validate_locale(locale, backend) end)
  end

  # Accept-Language: en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7
  defp locales_from_accept_language(conn) do
    case get_req_header(conn, "accept-language") do
      [value | _] ->
        values = String.split(value, ",")
        Enum.map(values, &resolve_locale_from_accept_language/1)

      _ ->
        []
    end
  end

  defp resolve_locale_from_accept_language(language) do
    language
    |> String.split(";")
    |> List.first()
    |> language_to_locale()
  end

  defp language_to_locale(language) do
    String.replace(language, "-", "_", global: false)
  end

  defp locale_to_language(locale) do
    String.replace(locale, "_", "-", global: false)
  end

  defp validate_locale(nil, _), do: nil

  defp validate_locale(locale, backend) do
    supported_locales = Gettext.known_locales(backend)

    if locale in supported_locales do
      locale
    else
      nil
    end
  end
end
