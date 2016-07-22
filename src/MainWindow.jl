type MainWindow <: GtkWindow

    handle::Ptr{Gtk.GObject}

    function MainWindow()

        w = @GtkWindow("Sudoku.jl",800,600)
        signal_connect(main_window_key_press_cb, w, "key-press-event", Void, (Ptr{Gtk.GdkEvent},), false)
        signal_connect(main_window_quit_cb, w, "delete-event", Void, (Ptr{Gtk.GdkEvent},), false)

        n = new(w.handle)
        # Gtk.gobject_move_ref(n, w)
    end
end

## exiting
function main_window_quit_cb(widgetptr::Ptr,eventptr::Ptr, user_data)
    #
    # if typeof(project) == Project
    #     save(project)
    # end
    # #REDIRECT_STDOUT && stop_console_redirect(watch_stdio_tastk,stdout,stderr)
    # global is_running = false
    #
    println("sudoku ended!")
    destroy(user_data)
    return nothing
end


function main_window_key_press_cb(widgetptr::Ptr, eventptr::Ptr, user_data)
    # println(widgetptr)
    # println("..........")
    # println(eventptr)
    # println("..........")
    # println(user_data)

    event = convert(Gtk.GdkEvent, eventptr)

    if event.keyval == Gtk.GdkKeySyms.Escape
        destroy(user_data)
    end
    return nothing
end

function sidePanelButton_clicked_cb(widgetptr::Ptr, user_data)
    toggle_sidepanel()
    return nothing
end

function editorButtonclicked_cb(widgetptr::Ptr, user_data)
    toggle_editor()
    return nothing
end

function toggle_editor()#use visible ?
    if Gtk.G_.position(mainPan) > 0
        mainPanPos = Gtk.G_.position(mainPan)
        Gtk.G_.position(mainPan,0)
    else
        Gtk.G_.position(mainPan,650) #FIXME need a layout type to save all these things
    end
end

function toggle_sidepanel()
    visible(sidepanel_ntbook,!visible(sidepanel_ntbook))
end
