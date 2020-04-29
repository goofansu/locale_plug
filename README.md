# LocalePlug

Elixir plug to detect and set locale.

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/01d3951dd40b485c8701959c1e273516)](https://www.codacy.com/manual/goofansu/locale_plug?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=goofansu/locale_plug&amp;utm_campaign=Badge_Grade)
[![CI](https://github.com/goofansu/locale_plug/workflows/CI/badge.svg)](https://github.com/goofansu/locale_plug/actions?query=workflow%3ACI)

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
