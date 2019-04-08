# LocalePlug

A plug to set locale for web applications.

The plug fetches `locale` from `Plug.Conn.params` and `Plug.Conn.cookies`, setting the locale for specified backend. 

## Installation

```elixir
def deps do
  [
    {:locale_plug, "~> 0.1.0"}
  ]
end
```

## Usage

```elixir
plug LocalePlug, backend: BeaverWeb.Gettext
```
