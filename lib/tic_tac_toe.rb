## display_board ##
def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

## input_to_index ##
def input_to_index(num)
    num.to_i - 1
end

## move ##
def move(board, index, current_player)
    board[index] = current_player
end

## position_taken? ##
def position_taken?(board, index)
    if board[index] == "" || board[index] == " " || board[index] == nil
        return false
    elsif board[index] == "X" || board[index] == "O"
        return true
    end
end

## turn_count ##
def turn_count(board)
    return 9 - board.count(" ")
end

## current_player ##
def current_player(board)
    turn_count(board).even? ? 'X' : 'O'
end

## valid_move? ##
def valid_move?(board, index)
    index.between?(0,8) && !position_taken?(board, index)
end

## turn ##
def turn(board)
    # ask for input
    puts "Please enter 1-9:"

    # get input until valid
    index = input_to_index(gets)
    until valid_move?(board, index)
        puts "Invalid move. Please try again."
        index = input_to_index(gets)
    end

    # make the move
    move(board, index, current_player(board))

    # display updated board
    display_board(board)
end

## WIN_COMBINATIONS constant ##
WIN_COMBINATIONS = [
  [0,1,2], # top row
  [3,4,5], # middle row
  [6,7,8], # bottom row
  [0,3,6], # left column
  [1,4,7], # middle column
  [2,5,8], # right column
  [0,4,8], # left diagonal
  [2,4,6] # right diagonal
]

## won? ##
def won?(board)
  # check each win combo
  WIN_COMBINATIONS.each do |win_combo|
    # if win_combo indices are all "X" or all "O", return win_combo
    if win_combo.all? {|index| board[index] == "X"} then
      return win_combo
    elsif win_combo.all? { |index| board[index] == "O" } then
      return win_combo
    end
  end
  # no win, return false
  return false
end

## full? ##
def full?(board)
  # return true if none of the indices are empty
  return board.none? {|index| index == " "}
end

## draw? ##
def draw?(board)
  # return true if board if full & not won
  return full?(board) && !won?(board)
end

## over? ##
def over?(board)
  return full?(board) || won?(board) || draw?(board)
end 

## winner ##
def winner(board)
  win_combo = won?(board)
  if win_combo == false then
    return nil
  else
    return board[win_combo.first]
  end
end

## play ##
def play(board)
    until over?(board) do
        turn(board)
    end

    if won?(board) then
        puts "Congratulations #{winner(board)}!"
    else
        puts "Cat's Game!"
    end
end