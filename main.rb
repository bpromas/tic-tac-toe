class Board
    attr_reader :turn

    def initialize(rows = 3, cols = 3)
        if rows != cols then 
            puts "Warning: You cannot win diagonally in a rectangular board!" 
        end
        @rows = rows
        @cols = cols
        @state = Array.new(@rows) { Array.new(@cols, '_') }
        @turn = 1
    end

    public

    def print_state
        #  0   1   2 
        #0 _ | _ | _
        #1 _ | _ | _
        #2 _ | _ | _
        col_guide = ""
        @cols.times do |col|
            col_guide += "  #{col} " 
        end
        p col_guide

        @state.each_with_index do |row, row_index| 
            p "#{row_index} #{row.join(" | ")} "
        end
    end

    def mark(row, col)
        if @state[row][col] == "_" then
            @state[row][col] = @turn == 1 ? "O" : "X"
            toggle_turn
        else
            puts "Invalid placement!"
        end
    end

    def victory_check
        #check horizontal wins
        @state.each do |row| 
            if row.all? {|symbol| symbol == "O"} then
                puts "Player 1 wins!"
                return 1
            elsif row.all? {|symbol| symbol == "X"} then
                puts "Player 2 wins!"
                return 2
            end
        end

        #create a rotated board
        rotated_state = @state.transpose.map(&:reverse)

        #check vertical wins
        rotated_state.each do |row| 
            if row.all? {|symbol| symbol == "O"} then
                puts "Player 1 wins!"
                return 1
            elsif row.all? {|symbol| symbol == "X"} then
                puts "Player 2 wins!"
                return 2
            end
        end

        #check diagonal wins
        if @rows == @cols
            diag1 = Array.new(@rows)
            step = 0
            while step < @rows
                diag1[step] = @state[step][step]
                step += 1
            end            
            if diag1.all? {|symbol| symbol == "O"} then
                puts "Player 1 wins!"
                return 1
            elsif diag1.all? {|symbol| symbol == "X"} then
                puts "Player 2 wins!"
                return 2
            end

            diag2 = Array.new(@rows)
            step = 0
            while step < @rows
                diag2[step] = rotated_state[step][step]
                step += 1
            end  
            if diag2.all? {|symbol| symbol == "O"} then
                puts "Player 1 wins!"
                return 1
            elsif diag2.all? {|symbol| symbol == "X"} then
                puts "Player 2 wins!"
                return 2
            end
        end

        if @state.flatten.none? { |elem| elem == "_" } then
            puts "It's a draw!"
            return 0
        end
    end

    private

    def toggle_turn
        @turn = @turn == 1 ? 2 : 1
    end
end

puts "How many rows will the board have?"
rows = gets.chomp().to_i
puts "How many columns will the board have?"
cols = gets.chomp().to_i
board = Board.new(rows, cols)

while board.victory_check == nil do
    board.print_state
    puts "Player #{board.turn} what row do you want to place in?"
    row = gets.chomp().to_i
    puts "Player #{board.turn} what column do you want to place in?"
    col = gets.chomp().to_i
    board.mark(row, col)
end
board.print_state