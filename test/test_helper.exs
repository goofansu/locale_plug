[__DIR__, "fixtures", "my_app", "ebin"]
|> Path.join()
|> Code.prepend_path()

ExUnit.start()
