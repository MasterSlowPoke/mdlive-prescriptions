module RemindersHelper
  def link_to_add_rules(name, f)
    new_rule = f.object.reminder_rules.klass.new
    id = new_rule.object_id
    fields = f.fields_for("reminder_rules", new_rule, child_index: id) do |builder|
      render("reminder_rule_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields button-link", data: {id: id, fields: fields.gsub("\n", "")} )
  end
end
