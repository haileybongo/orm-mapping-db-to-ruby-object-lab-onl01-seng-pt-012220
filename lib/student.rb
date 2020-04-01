class Student
  attr_accessor :id, :name, :grade

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
  
  def self.new_from_db(row)
    new_student = self.new  
    new_song.id = row[0]
    new_song.name =  row[1]
    new_song.length = row[2]
    new_song  # return the newly created instance
  end
  
  def self.find_by_name(name)
      sql = <<-SQL
      SELECT *
      FROM songs
      WHERE name = ?
      LIMIT 1
    SQL
 
    DB[:conn].execute(sql, name).map do |row|
      self.new_from_db(row)
    end.first
  end
  
  def self.all 
    sql = <<-SQL
      SELECT *
      FROM songs
    SQL
 
    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end
  end
end
