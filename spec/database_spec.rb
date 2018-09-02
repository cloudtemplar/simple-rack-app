# frozen_string_literal: true

require_relative '../database'

describe Database do
  let(:db) { Database.connect(db_url, queries) }
  let(:db_url) { 'postgres://localhost/framework_test' }
  let(:queries) do
    {
      create_todo: %{
        INSERT INTO todos(description)
        VALUES ($1)
      },
      find_todo: %{
        SELECT * FROM todos
        WHERE description = $1
      },
      all_todos: %{
        SELECT * FROM todos
      }
    }
  end

  it 'does not have sql injection vulnerabilities' do
    description = "'; drop table todos; --"
    expect { db.create_todo(description) }
      .to change { db.all_todos.length }
      .by(1)
  end

  it 'retrieves records that it has inserted' do
    db.create_todo('Todo')
    todo = db.find_todo('Todo').fetch(0)
    expect(todo.description).to eq('Todo')
  end
end
