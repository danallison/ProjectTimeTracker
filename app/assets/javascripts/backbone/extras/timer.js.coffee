class ProjectTimeTracker.Extras.Timer
  constructor: (@el, @startingTotal = 0) ->
    @startDate = new Date().getTime()
    @expectedNow = @startDate
    @run()
    
  run: ->
    now = new Date().getTime()
    @totalTime = (now - @startDate) + @startingTotal
    
    next = 1000 - (now - @expectedNow)
    
    if next < 0
      next = 0
      @expectedNow = now
    
    @el.textContent = ProjectTimeTracker.Extras.Timer.stringify(@totalTime)
    
    @expectedNow += 1000
    
    t = @
    @timeout = setTimeout(() -> 
      t.run()
    , next)
    
  end: ->
    t = @
    clearTimeout(t.timeout)
    
    { startDate: @startingDate, endDate: new Date().getTime(), newTotal: @totalTime }
    

ProjectTimeTracker.Extras.Timer.stringify = (milliseconds) ->
    seconds = Math.floor(milliseconds / 1000) % 60
    minutes = Math.floor(milliseconds / 1000 / 60) % 60
    hours = Math.floor(milliseconds / 1000 / 60 / 60)
    
    "#{Math.floor(hours/10)}#{hours % 10} : #{Math.floor(minutes/10)}#{minutes % 10} : #{Math.floor(seconds/10)}#{seconds % 10}"
