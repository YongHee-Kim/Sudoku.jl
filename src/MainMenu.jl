# 메뉴바
global menubar = @GtkMenuBar() |>
    (fileMenu = @GtkMenuItem("_File")) |>
    (settingsMenu= @GtkMenuItem("_Settings"))|>
    (helpMenu = @GtkMenuItem("_Help"))
