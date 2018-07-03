class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]

  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def self.create_table
    sql_create = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      )
      SQL
    DB[:conn].execute(sql_create)
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE students")
  end

  def save
    sql_insert = <<-SQL
      INSERT INTO students (name, grade)
        VALUES (?, ?)
      SQL
    DB[:conn].execute(sql_insert, @name, @grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name:, grade:)
    var = Student.new(name, grade)
    var.save
    var
  end

end
