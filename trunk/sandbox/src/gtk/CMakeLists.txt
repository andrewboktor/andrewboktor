link_directories(${GTK_LIBRARY_DIRS})
include_directories(${GTK_INCLUDE_DIRS})

add_library(gtk object.m widget.m container.m bin.m 
	window.m button.m box.m vbox.m hbox.m 
	drawingarea.m entry.m spinbutton.m misc.m 
	label.m separator.m hseparator.m vseparator.m 
	combobox.m range.m scale.m hscale.m vscale.m 
	togglebutton.m progress.m progressbar.m 
	notebook.m gtk.m textview.m)
target_link_libraries(gtk ${GTK_LIBRARIES})

