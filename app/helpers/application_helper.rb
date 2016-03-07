module ApplicationHelper
  def is_active?(controller_name, action, page_name)
    "active" if params[:controller] == controller_name && (params[action] == page_name || (page_name.nil? && params[action].empty?))
	end
end
