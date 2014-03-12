<% inner = capture do -%>
class <%= file_name.camelize %> < Arrthorizer::ContextRole
  def applies_to_user?(user, context)
    # TODO: insert logic here
    false
  end
end
<% end -%>
<% regular_class_path.reverse.map do |mod| -%>
<%  inner = capture do -%>
module <%= mod.camelize %>
<%= indent(inner,2) -%>
end
<% end -%>
<% end -%>
<%= inner %>
