function game_init()

  score = 0
  timer = 0

  snake.dir = "right"
  snake.nodes = {}

  node = {}
  node.x = 1
  node.y = 1
  table.insert(snake.nodes,node)

  food = {}
  food.x = math.random(1,screen_w/cel-1)
  food.y = math.random(1,screen_h/cel-1)
  print(food.x)
  print(food.y)

  speed_timer = 0
  speed_time_interval = 0.005
end

function game_load()

  cel = 10

  snake = {}

  game_init()

end

function game_update(dt)

  speed_timer = speed_timer + dt

  --ciclo
  if speed_timer >= speed_time_interval then

    speed_timer = 0

    if snake.nodes[1].x == food.x and snake.nodes[1].y == food.y then

      node = {}
      node.x = food.x
      node.y = food.y
      table.insert(snake.nodes,1,node)

      score = score + 1
      food.x = math.random(1,(screen_w/cel)-1)
      food.y = math.random(1,(screen_h/cel)-1)

      print(food.x .."-".. food.y)

    end

    for i = table.getn(snake.nodes),2,-1 do
      snake.nodes[i].x = snake.nodes[i-1].x
      snake.nodes[i].y = snake.nodes[i-1].y
    end

    --cabeça
    if snake.dir == "right" then
      snake.nodes[1].x = snake.nodes[1].x + 1
    elseif snake.dir == "left" then
      snake.nodes[1].x = snake.nodes[1].x - 1
    elseif snake.dir == "up" then
      snake.nodes[1].y = snake.nodes[1].y - 1
    elseif snake.dir == "down" then
      snake.nodes[1].y = snake.nodes[1].y + 1
    end

    for i=2, table.getn(snake.nodes),1 do
      if snake.nodes[1].x == snake.nodes[i].x and snake.nodes[1].y == snake.nodes[i].y then
        gamestate = "gameover"
      end
    end

    if snake.nodes[1].x >= screen_w/cel or snake.nodes[1].x < 1 or
    snake.nodes[1].y >= screen_h/cel or snake.nodes[1].y < 1 then
      gamestate = "gameover"
    end

  end
  --end ciclo

end

function game_draw()

  for index in pairs(snake.nodes) do
    love.graphics.rectangle("fill",snake.nodes[index].x*cel,snake.nodes[index].y*cel,cel,cel)
  end
  love.graphics.rectangle("fill",food.x*cel,food.y*cel,cel,cel)

end

function game_keypressed(key,unicode)

  if key == "left" and snake.dir ~= "right" then
    snake.dir = "left"
  elseif key == "right" and snake.dir ~="left" then
    snake.dir = "right"
  elseif key == "up" and snake.dir ~="down" then
    snake.dir = "up"
  elseif key =="down" and snake.dir ~="up" then
    snake.dir = "down"
  end


end
