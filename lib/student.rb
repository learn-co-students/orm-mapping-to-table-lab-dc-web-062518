require 'pry'
class Student

  @@all = []
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @id = id
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = "CREATE TABLE IF NOT EXISTS students(id INTEGER PRIMARY KEY, name TEXT, grade TEXT);"
  DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE students"
    DB[:conn].execute(sql)
  end

  def save
    sql = "INSERT INTO students(name, grade) VALUES (?, ?)"
    sql2 = "SELECT id FROM students WHERE name = ? AND grade = ?"
    DB[:conn].execute(sql, @name, @grade)
    arr = DB[:conn].execute(sql2, @name, @grade)
    @id = arr[0][0]
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end

end
