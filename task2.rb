
class Brick
  def initialize(color:, state:, number:)
    @color = color
    @state = state
    @number = number
  end

  attr_accessor :color, :state, :number

end

class Bricks_factory
  def initialize(quantity)
    @quantity = quantity
    @arr_bricks = []
    @temporary_var_state
    @quantity_of_bricks = (1..@quantity).to_a
  end

  def create_bricks
    (1..@quantity).each { |i| @arr_bricks << Brick.new(color: create_color, state: create_state, number: create_number) }
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

  def sort_a(field)
    @arr_errors = []
    @arr_result = []
    @arr_bricks.each do |i|
      if field == 'broken'
        if i.inspect.scan(/\"broken\"/) == []
          p "does not contain a required field"
          @arr_errors << i
        else
          @arr_result << i
        end
      else
        if i.inspect.scan(field) == []
          p "does not contain a required field"
          @arr_errors << i
        else
          @arr_result << i
        end
      end
    end
    p @arr_errors
    @arr_result.sort_by { field }
  end

end

