class Brick
  attr_reader :color, :state
  attr_accessor :number

  def initialize(color, state, number = nil)
    @color = color
    @state = state
    @number = number
  end

  def self.create_state
    result = rand(101)
    result > 20 ? 'unbroken' : 'broken'
  end

end

module Sorting_by_given_field
  def sort_by_field(field)
    arr_errors = []
    arr_result = []
    @arr_bricks.each do |i|
      if field == 'broken'
        if i.inspect.scan(/\"broken\"/) == []
          p "does not contain a required field"
          arr_errors << i
        else
          arr_result << i
        end
      else
        if i.inspect.scan(field) == []
          p "does not contain a required field"
          arr_errors << i
        else
          arr_result << i
        end
      end
    end
    p arr_errors
    arr_result.sort_by { field }
  end

end

class BricksFactory

  include Sorting_by_given_field
  def initialize
    @arr_bricks = []
  end

  def create_color
    arr = %w[red white brown orange gray]
    arr.sample
  end

  def create_number(value, number)
    value == 'unbroken' ? number : nil
  end

  def create_bricks(quantity)
    number = 0
    quantity.times do
      temporary_object = Brick.new(create_color, Brick.create_state)
      number += 1 if temporary_object.state == 'unbroken'
      temporary_object.number = create_number(temporary_object.state, number)
      @arr_bricks << temporary_object
    end
    @arr_bricks
  end

  def only_unbroken_bricks
    res = @arr_bricks.filter { |i| i if i.state == 'unbroken' }
    res.size
  end

  def user_color_bricks(user_color)
    @arr_bricks.reverse.each_with_object([]) do |element, result|
      result << element if element.color == user_color
      break result if result.size == 10
    end.reverse
  end

  def sort_by_color
    @arr_bricks.sort_by { |s| s.color }
  end

  alias user_color_bricks sort_by_field
end
