defmodule LocalePlugTest do
  use ExUnit.Case, async: true
  use Plug.Test

  defmodule MyApp.Gettext do
    use Gettext, otp_app: :my_app
  end

  @opts LocalePlug.init(backend: MyApp.Gettext)

  test "set supported locale" do
    conn =
      conn(:get, "/hello?locale=fr")
      |> Plug.Conn.fetch_cookies()
      |> Plug.Conn.fetch_query_params()
      |> LocalePlug.call(@opts)

    assert Gettext.get_locale(MyApp.Gettext) == "fr"
    assert conn.resp_cookies["locale"][:value] == "fr"
  end

  test "set unsupported locale" do
    conn =
      conn(:get, "/hello?locale=zh_CN")
      |> Plug.Conn.fetch_cookies()
      |> Plug.Conn.fetch_query_params()
      |> LocalePlug.call(@opts)

    assert Gettext.get_locale(MyApp.Gettext) == Gettext.get_locale()
    assert conn.resp_cookies["locale"] == nil
  end
end
