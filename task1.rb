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

class BricksFactory
  def initialize
    @arr_unbroken_bricks = []
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
      @arr_unbroken_bricks << temporary_object
    end
    @arr_unbroken_bricks
  end

  def only_unbroken_bricks
    res = @arr_unbroken_bricks.filter { |i| i if i.state == 'unbroken' }
    res.size
  end

  def bricks_some_color(user_color)
    @arr_unbroken_bricks.reverse.each_with_object([]) do |element, result|
      result << element if element.color == user_color
      break result if result.size == 10
    end.reverse
  end

  def sort_by_color
    @arr_unbroken_bricks.sort_by { |s| s.color }
  end

end
