require 'pg'

class Database
  def initialize(pg_conn, queries)
    @pg_conn = pg_conn
    @queries = queries
  end

  def self.connect(db_url, queries)
    pg_conn = PG::Connection.new(db_url)
    new(pg_conn, queries)
  end

  def method_missing(query, *args)
    sql = @queries.fetch(query)
    @pg_conn.exec_params(sql, args).to_a.map do |row|
      Record.new(row)
    end
  end

  class Record
    def initialize(row)
      @row = row
    end

    def method_missing(column_name)
      @row.fetch(column_name.to_s)
    end
  end
end
