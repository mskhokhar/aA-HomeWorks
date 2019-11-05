class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1 
    @name2 = name2
    @cups = Array.new(14){[]}
    (0..5).each { |idx| 4.times{ cups[idx] << :stone } }
    (7..12).each { |idx| 4.times{ cups[idx] << :stone } }
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if !start_pos.between?(1,14)
    raise "Starting cup is empty" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    last_cup = nil
    idx = start_pos
    loop do
      cups[idx] << cups[start_pos].pop
      last_cup = idx
      break if cups[start_pos].empty?
      next if idx == 13 or idx == 6
      idx += 1
      idx = 0 if idx > 12
    end
    render
    next_turn(last_cup)
    if cups[last_cup].length == 1
      return :switch 
    elsif last_cup == 6
      return :prompt
    else
      return last_cup
    end
    
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    (0...6).all?{|idx| cups[idx].empty?} || (7...13).all?{|idx| cups[idx].empty?}
  end

  def winner
    if cups[6].length == cups[13].length
      return :draw
    end
  end
end
