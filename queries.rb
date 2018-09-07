QUERIES = {
  all_todos: %{
    SELECT * FROM todos
  },

  find_todo_by_title: %{
    SELECT * FROM todos
    WHERE title = '%s'
  }
}
