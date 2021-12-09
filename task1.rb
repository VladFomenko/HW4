class Brick
  def initialize(color:, state:, number:)
    @color = color
    @state = state
    @number = number
  end

  attr_accessor :color, :state, :number


end

# module Arr_sort
#   def sort_smth_field(field)
#     @arr_bricks.filter {|i| i if i.state == 'unbroken'}.sort_by { |s| s.field}
#   end
#
# end

class Bricks_factory
  def initialize(quantity)
    @quantity = quantity
    @arr_bricks = []
    @temporary_var_state
    @quantity_of_bricks = (1..@quantity).to_a
  end

  #include Arr_sort


  def create_bricks
    (1..@quantity).each {|i| @arr_bricks << Brick.new(color: create_color, state: create_state, number: create_number)}
    @arr_bricks
  end


  def create_color
    %w[red white brown orange gray].shuffle.first
  end

  def create_state
    result = rand(101)
    @temporary_var_state = result > 20 ? 'unbroken' : 'broken'
  end

  def create_number
    if @temporary_var_state == 'unbroken'
      @quantity_of_bricks[0]
      @quantity_of_bricks.shift
    else
      nil
    end
  end

  def only_unbroken_bricks
    res = @arr_bricks.filter {|i| i if i.state == 'unbroken'}
    res.size
  end

  def bricks_some_color(user_color)
    @result = []
    @arr_bricks.reverse.filter do |i|
      @result << i if i.color == user_color
      break if @result.size > 9
    end
    @result.reverse
  end

  def sort_by_color
    #не зміг уникнути повторення коду. Вже існує метод, який видаляє побиті цегли.
    @arr_bricks.filter {|i| i if i.state == 'unbroken'}.sort_by { |s| s.color}
  end

end