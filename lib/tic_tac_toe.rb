require 'pry'
class TicTacToe

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def display_board
    puts "-----------\n #{@board[0]} | #{@board[1]} | #{@board[2]} \n #{@board[3]} | #{@board[4]} | #{@board[5]} \n #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(input)
    input.to_i - 1
  end

  def move(index, token = 'X')
    @board[index] = token
  end

  def position_taken?(index)
    @board[index] == ' ' ? false : true
  end

  def valid_move?(index)
    !position_taken?(index) && index >= 0 && index <= 8
  end

  def turn_count
    9 - @board.count(' ')
  end

  def current_player
    turn_count % 2 == 0 ? 'X' : 'O'
  end

  def turn
    input = input_to_index(gets.chomp)
    if valid_move?(input)
      move(input, current_player)
    else
      turn
    end
    display_board
  end

  def won?
    xarr = []
    oarr = []
    @board.each_with_index do |value, i|
      if value == 'X'
        xarr << i
      elsif value == 'O'
        oarr << i
      end
    end
    WIN_COMBINATIONS.each do |win|
      if (win - xarr).empty?
        return win
      elsif (win - oarr).empty?
        return win
      end
    end
    false
  end

  def full?
    turn_count == 9 ? true : false
  end

  def draw?
    !won? && full? ? true : false
  end

  def over?
    won? || draw? ? true : false
  end

  def winner
    xarr = []
    oarr = []
    @board.each_with_index do |value, i|
      if value == 'X'
        xarr << i
      elsif value == 'O'
        oarr << i
      end
    end
    WIN_COMBINATIONS.each do |win|
      if (win - xarr).empty?
        return "X"
      elsif (win - oarr).empty?
        return "O"
      end
    end
    nil
  end

  def play
    while !over?
      puts "Please choose your next move."
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end
end