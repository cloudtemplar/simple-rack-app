# frozen_string_literal: true

require_relative '../database'

describe Database do
  let(:db) { Database.connect(db_url, queries) }
  let(:db_url) { 'postgres://localhost/framework_test' }
  let(:queries) do
    {
      create: %{
        CREATE TABLE todos (title text, description text)
      },
      drop: %{
        DROP TABLE IF EXISTS todos
      },
      create_todo: %{
        INSERT INTO todos(title, description)
        VALUES ({title}, {description})
      },
      find_todo: %{
        SELECT * FROM todos
        WHERE title = {title}
      },
      all_todos: %{
        SELECT * FROM todos
      }
    }
  end

  before do
    db.drop
    db.create
  end

  it 'does not have sql injection vulnerabilities' do
    title = "'; drop table todos; --"
    description = "Something"
    expect { db.create_todo(title: title, description: description) }
      .to change { db.all_todos.length }
      .by(1)
  end

  it 'retrieves records that it has inserted' do
    db.create_todo(
      title:       'Todo',
      description: 'Do some stuff'
    )
    todo = db.find_todo(title: 'Todo').fetch(0)
    expect(todo.title).to eq('Todo')
  end

  it "doesn't care about the order of params" do
    db.create_todo(
      description: 'Do some stuff',
      title:       'Todo'
    )
    todo = db.find_todo(title: 'Todo').fetch(0)
    expect(todo.title).to eq('Todo')
  end
end
