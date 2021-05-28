module Turn

function start(grid::Matrix{Int})
  opponentrow, opponentcol = parse.(Int, readline() |> split)

  if (opponentrow, opponentcol) != (-1, -1)
    grid[opponentrow + 1, opponentcol + 1] = 2
  end

  println(stderr,
          """
          $(grid[1,1]) | $(grid[1,2]) | $(grid[1,3])
          $(grid[2,1]) | $(grid[2,2]) | $(grid[2,3])
          $(grid[3,1]) | $(grid[3,2]) | $(grid[3,3])
          """
         )

  valid_action_count = parse.(Int, readline())
  actions = map(1:valid_action_count) do i
    parse.(Int, readline() |> split)
  end

  for mynum in 1:2
    indexes = rowcheck(grid, mynum)
    indexes != (0, 0) && return resp(indexes[1], indexes[2], grid)

    indexes = colcheck(grid, mynum)
    indexes != (0, 0) && return resp(indexes[1], indexes[2], grid)

    indexes = diagonalcheck(grid, mynum)
    indexes != (0, 0) && return resp(indexes[1], indexes[2], grid)
  end

  grid[2,2] == 0 && return resp(2, 2, grid)

  for action in actions
    grid[action[1] + 1, action[2] + 1] = 1

    indexes = rowcheck(grid, 1)
    indexes != (0, 0) && return resp(action[1] + 1, action[2] + 1, grid)

    indexes = colcheck(grid, 1)
    indexes != (0, 0) && return resp(action[1] + 1, action[2] + 1, grid)

    indexes = diagonalcheck(grid, 1)
    indexes != (0, 0) && return resp(action[1] + 1, action[2] + 1, grid)

    grid[action[1] + 1, action[2] + 1] = 0
  end

  resp(actions[1][1] + 1, actions[1][2] + 1, grid)
end

function rowcheck(grid::Matrix{Int}, mynum::Int)
  for colnum in 1:3
    for rownum in 1:3
      grid[colnum, mod(rownum + 1, 3) + 1] == mynum &&
      grid[colnum, mod(rownum + 2, 3) + 1] == mynum &&
      grid[colnum, mod(rownum + 0, 3) + 1] == 0 &&
      return (colnum, mod(rownum, 3) + 1)
    end
  end

  (0,0)
end

function colcheck(grid::Matrix{Int}, mynum::Int)
  for colnum in 1:3
    for rownum in 1:3
      grid[mod(colnum + 1, 3) + 1, rownum] == mynum &&
      grid[mod(colnum + 2, 3) + 1, rownum] == mynum &&
      grid[mod(colnum + 0, 3) + 1, rownum] == 0 &&
      return (mod(colnum, 3) + 1, rownum)
    end
  end

  (0,0)
end

function diagonalcheck(grid::Matrix{Int}, mynum::Int)
  collist = [1,2,3]
  for rowlist in [[1,2,3], [3,2,1]]
    for i in 1:3
      grid[collist[mod(i + 1, 3) + 1], rowlist[mod(i + 1, 3) + 1]] == mynum &&
      grid[collist[mod(i + 2, 3) + 1], rowlist[mod(i + 2, 3) + 1]] == mynum &&
      grid[collist[mod(i + 0, 3) + 1], rowlist[mod(i + 0, 3) + 1]] == 0 &&
      return (collist[mod(i, 3) + 1], rowlist[mod(i, 3)] + 1)
    end
  end

  (0,0)
end

function resp(row, col, grid)
  grid[row, col] = 1

  println("$(row - 1) $(col - 1)")

  grid
end

end

module Game
using ..Turn

function call(grid)
  while true
    grid = Turn.start(grid)
  end
end
end; Game.call([0 0 0
                0 0 0
                0 0 0])
