# using GtkIDE

using Gtk
include("solver.jl")

path = dirname(@__FILE__)

sudoku_sheet = LoadData("$path/sudoku.csv")
answer_sheet = SolveModel(sudoku_sheet)


# 스도쿠 생성
sudoku_element = Array(Gtk.GtkEntry, 9,9)
for row in 1:9, col in 1:9
    p = sudoku_sheet[row, col]
    p == 0 ? (edit = true) : (edit = false)
    p == 0 && (p = "")
    sudoku_element[row, col] = @GtkEntry(text=p, width_request=10, height_request=10, max_length=1, width_chars=1, max_width_chars=1, editable=edit)
end

box_container = Array(Gtk.GtkBoxLeaf, 9,3)
for row in 1:9, col in 1:3
    row % 3 == 0 ? (mb = 15) : (mb = 0)
    box_container[row, col] = @GtkBox(:h, name="$row,$col", width_request=30, height_request=10, spacing=5, margin_left=15, margin_bottom = mb)

    t = box_container[row, col]
    push!(t, sudoku_element[row, (col-1)*3+1])
    push!(t, sudoku_element[row, (col-1)*3+2])
    push!(t, sudoku_element[row, (col-1)*3+3])
end

# 그리드로 관리
maingrid = @GtkGrid(margin_top=10, margin_left=10, row_spacing=5, column_spacing=5)
for row in 1:10, col in 1:4
    if row == 1 || col == 1
        if row == 1 && col == 1

        elseif row == 1
            maingrid[col, row] = @GtkLabel([" A ── B ── C"," D ── E ── F"," G ── H ── I"][col-1])
        elseif col == 1
            maingrid[col, row] = @GtkLabel(string(row-1))
        end
    else
        maingrid[col, row] = box_container[row-1, col-1]
    end
end


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
