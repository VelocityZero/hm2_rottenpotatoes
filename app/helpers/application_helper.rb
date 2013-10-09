module ApplicationHelper
 def sortas(column, title)
	direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
	link_to title, {:sort => column, :direction => direction}
  end
  def sort_select(column)
  	return column == session[:sort]? "hilite": nil
  end
  def checkbox(rating)
	name = rating[0];
	checked = rating[1];
  end
end
