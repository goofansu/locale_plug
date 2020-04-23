# LocalePlug

Elixir plug to detect and set locale.

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/0cabb936409d4acb88ca5328993e3ee8)](https://app.codacy.com/gh/bright-u/locale_plug?utm_source=github.com&utm_medium=referral&utm_content=bright-u/locale_plug&utm_campaign=Badge_Grade_Dashboard)
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
