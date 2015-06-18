class TowerOfHanoi

  def initialize(ndisks)
    @ndisks = ndisks
    @num_moves=1
    @initial_disks = (1..ndisks).to_a.reverse
    @board = [(1..ndisks).to_a.reverse,[],[]]
    @stacks = ['a','b','c']
  end

  def play
    puts "Stacks are letters and disks are numbers."
    puts "You have started a new game with #{@ndisks} disks"
    puts "The game is starting, enter 'q' anytime to quit"

    current_board
    ask_move
  end

  def current_board ()
    puts ""
    puts "Current Board"
    puts "a= " + @board[0].inspect
    puts "b= " + @board[1].inspect
    puts "c= " + @board[2].inspect
  end

  def check_input(user_input)
    if @stacks.include?(user_input)
      true
    elsif user_input == 'q'
      exit
    else
      false
    end
  end  

  def ask_move ()
    
    @from = ""
    @to = ""

    puts ""
    puts "This is move ##{@num_moves}"
    puts "What move do you want to make?"
    puts "Move from stack (a, b or c)"
    @from = gets.chomp

    until check_input(@from)
      puts "Indicate what stack you want to take a disk from. Enter only a, b, or c."
      @from = gets.chomp
    end

    puts "Move to the stack (a, b or c)"
    @to = gets.chomp

    until check_input(@to)
      puts "Indicate what stack you want to move the disk to. Enter only a, b, or c."
      @to = gets.chomp
    end

    validate_move

  end #end of ask_move

  def validate_move()

    @from_i = @stacks.index(@from)
    @to_i = @stacks.index(@to)
    
    # Take the disk out of the 'from' stack
    possible_move = @board[@from_i][-1]

    #Check 'from' stack is not empty
    if @board[@from_i].empty?      
      puts "Invalid move. The stack you are taking the disk from is empty. Try again."
      ask_move 

    #Check 'to' stack is empty or doesn't have a smaller disk
    elsif !@board[@to_i][-1].nil? && possible_move > @board[@to_i][-1]
      puts "Invalid move, the stack you chose has a smaller disk, try again."
      ask_move
    
    #All good? Execute move
    else
      execute_move
    end

  end #end of validate_move

  def finished?()
    #Check if second stack or third stack is equal to the initial configuration of disks at the first stack
    if @board[1] == @initial_disks || @board[2]== @initial_disks
      return true
    end
  end

  def execute_move()

    #moves disk to new stack
    current_move = @board[@from_i].pop
    @board[@to_i].push(current_move)
    
    #shows board and counts number of moves
    puts current_board
    @num_moves +=1

    #checks if finished
    if finished?
      @num_moves -=1
      min_moves = 2**@ndisks - 1
      puts "Congratulations. You finished the game in #{@num_moves} moves. The minimum number of moves is #{min_moves}."
    else
      ask_move
    end

  end #end of validate_move

end

puts "Welcome to the tower of Hanoi! How many disks you want to play with?"
user_disks = gets.chomp.to_i
t = TowerOfHanoi.new(user_disks)
t.play
