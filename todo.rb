class Todo < ActiveRecord::Base
  def due_today?
    due_date == Date.today
  end

  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_today? ? nil : due_date

    "#{id} #{display_status} #{todo_text} \t #{ display_date}"
  end

  def self.to_displayable_list
    all.map {|todo| todo.to_displayable_string }
  end
  def self.overdue
    where("due_date < ?", Date.today)
  end
  def self.due_today
    where("due_date = ?", Date.today)
  end
  def self.due_later
    where("due_date > ?", Date.today)
  end

  def self.show_list
    puts "My Todo-list\n\n"
    puts "Overdue\n"

    puts overdue.map { |todo| todo.to_displayable_string }
    puts "\n\n"
    puts "Due Today\n"
    puts due_today.map { |todo| todo.to_displayable_string }
    puts "\n\n"

    puts "Due Later\n"
    puts due_later.map { |todo| todo.to_displayable_string }
    puts "\n\n"
  end
  def self.add_task(h)
    #puts h[:todo_text]
    Todo.create!(todo_text: h[:todo_text] , due_date: Date.today + h[:due_in_days], completed: false)

  end
  def self.mark_as_complete(todo_id)
    to_update_job=Todo.find(todo_id).update_attribute(:completed, true)
    Todo.find(todo_id)
  end

end
