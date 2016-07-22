global sudoku_sheet = LoadData("$path/sudoku.csv")
global answer_sheet = SolveModel(sudoku_sheet)

function init_sudoku()
    # 스도쿠 생성
    global sudoku_element = Array(Gtk.GtkEntry, 9,9)
    for row in 1:9, col in 1:9
        p = sudoku_sheet[row, col]
        p == 0 ? (edit = true) : (edit = false)
        p == 0 && (p = "")
        sudoku_element[row, col] = @GtkEntry(text=p, width_request=10, height_request=10, max_length=1, width_chars=1, max_width_chars=1, editable=edit)
    end

    # 스도쿠 그리드
    global sudokuGrid = @GtkGrid(margin_top=10, margin_bottom=25, margin_left=10, row_spacing=5, column_spacing=5)
    letters = map(x->uppercase(string(Char(x))), 97:122)
    for row in 2:10, col in 2:10
        sudokuGrid[row, col] = sudoku_element[row-1, col-1]
        if row == 2
            sudokuGrid[col, 1] = @GtkLabel(letters[col-1])
            sudokuGrid[1, col] = @GtkLabel(string(col-1))
        end
    end
end
