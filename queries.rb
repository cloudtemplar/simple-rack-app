QUERIES = {
  all_todos: %{
    SELECT * FROM todos
  },

  find_todo_by_description: %{
    SELECT * FROM todos
    WHERE description = '%s'
  }
}
