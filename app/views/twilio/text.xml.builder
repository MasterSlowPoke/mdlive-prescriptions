xml.instruct!
xml.Response do
  xml.Message "Hello, #{@user.name}. You have #{pluralize(@user.reminders.count, 'reminder')}!"
end