# LocalePlug

Elixir plug to detect and set locale.

[![CI](https://github.com/bright-u/locale_plug/workflows/CI/badge.svg)](https://github.com/bright-u/locale_plug/actions?query=workflow%3ACI)

`locale` is detected according to following order:

> params > cookies > "accept-language" in request headers

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
plug LocalePlug, backend: MyApp.Gettext
```
