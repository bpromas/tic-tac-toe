class Board
    def initialize(rows = 3, cols = 3)
        if rows != cols then 
            puts "Warning: You cannot win diagonally in a rectangular board!" 
        end
        @rows = rows
        @cols = cols
        @state = Array.new(@rows) { Array.new(@cols, '_') }
    end

    def state
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

    def mark(symbol, row, col)
        @state[row][col] = symbol
    end

    def victory_check
        #check horizontal wins
        @state.each do |row| 
            if row.all? {|symbol| symbol == "O"} then
                puts "O wins!"
                return 1
            elsif row.all? {|symbol| symbol == "X"} then
                puts "X wins!"
                return 2
            end
        end

        #create a rotated board
        rotated_state = @state.transpose.map(&:reverse)

        #check vertical wins
        rotated_state.each do |row| 
            if row.all? {|symbol| symbol == "O"} then
                puts "O wins!"
                return 1
            elsif row.all? {|symbol| symbol == "X"} then
                puts "X wins!"
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
                puts "O wins!"
                return 1
            elsif diag1.all? {|symbol| symbol == "X"} then
                puts "X wins!"
                return 2
            end

            diag2 = Array.new(@rows)
            step = 0
            while step < @rows
                diag2[step] = rotated_state[step][step]
                step += 1
            end  
            if diag2.all? {|symbol| symbol == "O"} then
                puts "O wins!"
                return 1
            elsif diag2.all? {|symbol| symbol == "X"} then
                puts "X wins!"
                return 2
            end

        end
    end
end