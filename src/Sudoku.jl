# using GtkIDE

using Gtk
path = dirname(@__FILE__)

include("solver.jl")
include("GamePlay.jl")
include("MainMenu.jl")
include("MainWindow.jl")
include("init.jl")



# 입력 버튼 기능
B_input = @GtkButton("Enter")
function input_answer(widget)
    println("Input Answer")
end
B_answer = @GtkButton("Answer Sheet")
function show_answer_sheet(widget)
    print(answer_sheet)
end

a = signal_connect(input_answer, B_input, "clicked")
b = signal_connect(show_answer_sheet, B_answer, "clicked")



maingrid[2, 11] = B_input
maingrid[3, 11] = B_answer



window = @GtkWindow("Sudoku", 800, 680)
push!(window, maingrid)
showall(window)


destroy(window)

init_sudoku()
