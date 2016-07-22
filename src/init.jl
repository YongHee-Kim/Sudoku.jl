

# 기타...

# GameWindow
init_sudoku()

# MainWindow
global win = @GtkWindow("Sudoku.jl",800,600) |>
    ((mainVbox = @GtkBox(:v)) |>
        menubar |>
        (sudokuGrid) |>
        (ButtonBox = @GtkBox(:h) |>
            (enterButton = @GtkButton("ENTER")) |>
            (answerButton = @GtkButton("SEE ANSWER"))
        ) |>
        (statusBar = @GtkStatusbar())
    )

    # statusBar 세팅
    setproperty!(statusBar,:margin,2)
    push!(statusBar, UInt32(1), "Developed by ")


showall(win)
