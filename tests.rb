require 'minitest/autorun'
require 'csv'

class Student
  def self.all
    CSV.foreach "db.csv" do |row|
    end
  end

  attr_reader :id, :first_name, :test_average
  def initialize attributes
    @id, @first_name, @last_name, @absences, @quiz_average, @test_average = attributes
  end

  def self.without_absences
    students = []
    CSV.foreach "db.csv" do |row|
      if row[3] == "0"
        students.push row
      end
    end
    students
  end
end
class StudentTest < Minitest::Test
  def test_student_attributes
    s = Student.new([1, "Su", "Kim", 0, 99, 100])
    assert_equal 1, s.id
    assert_equal "Su", s.first_name
    assert_equal 100, s.test_average
  end

  def test_can_find_student_with_best_tests
    assert_equal 0, Student.without_absences.count
  end

  def test_can_find_highest_scoring_student
    assert_equal 14, Student.top_by_test_score.first_name
  end
end
