# You have two classes, BricksFactory and Brick.
# BricksFactory - should be able to create a given number of bricks, randomly determine the color of each brick,
# and be able to return the total number of unbroken bricks for all time.

# In addition, BricksFactory should have two methods:
#- which must return the last 10 created unbroken bricks of the requested color.
#- which must return a sorted array of unbroken bricks (sorting by color).
# *If you want, you can try writing logic for the Brick class,
# where each brick will know which field it should be sorted by.

# A Brick has three properties - color, serial number, and state.
# Each brick has a 20% chance of being broken when created - so in this case the state field will be set to "broken".
# The serial number is equal to the total count of all successfully created blocks.

class Brick
  def initialize
    @color
    @state
  end

  # attr_accessor :hash_size
  # attr_accessor :color, :serial_number, :state

  def get_color
    @color = %w[red white brown orange gray].shuffle.first
  end

  def get_serial_number(quantity_of_bricks, state)
    if state == 'unbroken'
      quantity_of_bricks[0]
    else
      nil
    end
  end

  def get_state
    res = rand(101)
    @state = res > 20 ? 'unbroken' : 'broken'
  end

end

class BricksFactory < Brick

  def initialize(quantity)
    @arr_quantity = (1..quantity.to_i).to_a
    @arr_for_number = (1..quantity.to_i).to_a
    @db_of_bricks = {}
  end

  def create_bricks_hash
    @arr_quantity.each do |i|
      hash_brick = {
        :color => get_color,
        :state => get_state,
        :serial_number => get_serial_number(@arr_for_number, @state),
      }
      @db_of_bricks["bricks##{i}"] = hash_brick

      @arr_for_number.shift if @state == 'unbroken'
    end
    @db_of_bricks
  end

  def only_unbroken_bricks
    result = {}
    create_bricks_hash
    @db_of_bricks.each_pair do |key, value|
      if value[:state] == 'unbroken'
        result[key] = value
      end
    end
    result
  end

  def last_ten_unbroken_bricks(color)
    result = only_unbroken_bricks if @db_of_bricks == {}
    arr_hash = result.to_a
    b = []
    arr_hash.reverse.map do |i|
      b << i if i[1][:color] == color
      break if b.size == 10
    end
    b.reverse.to_h
  end

  def hash_sort_by_color
    result = only_unbroken_bricks if @db_of_bricks == {}
    result.to_a.sort_by { |s| s[1][:color]}
  end
end

# задам питання укр, бо на англ не зможу.
#
# задумка була така, що в Brick ми отримуємо колір, (в моїй реалізації це безглуздо робит ьсаме в цьому класі, а не в фариці)номер і
# чи розбитий кирпич. Потім ми наслідуємо у BricksFactory від Brick ці методи та властивості(? може це просто змінні),
# але ж вони не будуть працювати без виклику. Потрібно буде викликати методи створення цих властивостей.
# Але ж кількість кирпичів задається у BricksFactory, а так як я BricksFactory роблю таким класом, який наслідує
# то будь-які дані я ж не зможу передати у Brick з BricksFactory?  у такому випадкку => (BricksFactory < Brick) передаються методи та властивості
# з Brick у BricksFactory?
#
# якщо я наслідую класс, а  з ним і методи то навіщо мені потрібні ті властивості(колір, номер та стан), якщо так як я написав
# вони не будуть працювати без виклику методів.
#
# Властивості, це то шо ми можемо виклакати як методи після оголошення класу?(типу a.color)
# ну наприклад зміні, які зберігають інформацію в середені класу то не властивості?(наприклад просто оголосити в initialize зміну @color)
# Властивості це те шо ми передаєм під час виклику(a = BricksFactory.new(10) - 10 це ж властивість?) та ті шо оголошуємо сетерами і гетереами?
#
# ще питання по initialize, туди потрібно писати тільки ті зміні, що ми  будемо з них робити геттери і сеттери, чи і ті що просто використовувати?
# ну наприклад. записав туди просто змінну, в якій буду використовувати значення.
#