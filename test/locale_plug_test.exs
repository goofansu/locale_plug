defmodule LocalePlugTest do
  use ExUnit.Case, async: true
  use Plug.Test

  defmodule MyApp.Gettext do
    use Gettext, otp_app: :my_app
  end

  @opts LocalePlug.init(backend: MyApp.Gettext)

  test "set supported locale from params" do
    conn =
      conn(:get, "/hello?locale=fr")
      |> Plug.Conn.fetch_cookies()
      |> Plug.Conn.fetch_query_params()
      |> LocalePlug.call(@opts)

    assert Gettext.get_locale(MyApp.Gettext) == "fr"
    assert conn.resp_cookies["locale"][:value] == "fr"
    assert get_resp_header(conn, "content-language") == ["fr"]
  end

  test "set supported locale from params with partial match" do
    conn =
      conn(:get, "/hello?locale=fr_FR")
      |> Plug.Conn.fetch_cookies()
      |> Plug.Conn.fetch_query_params()
      |> LocalePlug.call(@opts)

    assert Gettext.get_locale(MyApp.Gettext) == "fr"
    assert conn.resp_cookies["locale"][:value] == "fr"
    assert get_resp_header(conn, "content-language") == ["fr"]
  end

  test "set unsupported locale from params" do
    conn =
      conn(:get, "/hello?locale=zh_CN")
      |> Plug.Conn.fetch_cookies()
      |> Plug.Conn.fetch_query_params()
      |> LocalePlug.call(@opts)

    assert Gettext.get_locale(MyApp.Gettext) == Gettext.get_locale()
    assert conn.resp_cookies["locale"] == nil
    assert get_resp_header(conn, "content-language") == []
  end

  test "set locale from headers" do
    conn =
      conn(:get, "/hello")
      |> Plug.Conn.put_req_header("accept-language", "zh-CN,fr;q=0.9,en;q=0.8,zh;q=0.7")
      |> Plug.Conn.fetch_cookies()
      |> Plug.Conn.fetch_query_params()
      |> LocalePlug.call(@opts)

    assert Gettext.get_locale(MyApp.Gettext) == "fr"
    assert conn.resp_cookies["locale"][:value] == "fr"
    assert get_resp_header(conn, "content-language") == ["fr"]
  end
end
