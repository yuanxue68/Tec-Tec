module ApplicationHelper
  def is_active?(key, page_name)
    "active" if params[key] == page_name || (page_name.nil? && params[key].empty?)
	end
end
