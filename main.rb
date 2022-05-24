class Board
    def initialize(xsize = 3, ysize = 3)
        if xsize != ysize then 
            puts "You cannot win diagonally in a rectangular board!" 
        end
        @xsize = xsize
        @ysize = ysize
        @state = Array.new(@xsize) { Array.new(@ysize, '_') }
    end

    def state
        #  0   1   2 
        #0 _ | _ | _
        #1 _ | _ | _
        #2 _ | _ | _
        col_guide = ""
        @ysize.times do |col|
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
end