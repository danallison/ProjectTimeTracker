ProjectTimeTracker.Views.Projects ||= {}

class ProjectTimeTracker.Views.Projects.ProjectView extends Backbone.View
  template: JST["backbone/templates/projects/project"]

  events:
    "click .destroy" : "destroy"
    "click .timer"   : "toggleTimer"

  tagName: "ul"
  
  className: "project"

  destroy: ->
    @model.destroy()
    this.remove()

    return false

  toggleTimer: ->
    if @timer
      @stopTimer()
      $(".project").removeClass("background")
    else
      @startTimer()
      
  startTimer: ->
    @timer = new ProjectTimeTracker.Extras.Timer(@el.children[0], @model.attributes.total_time)
    $(".project").addClass("background")
    $(@el).removeClass("background")
    
    activeView = ProjectTimeTracker.Extras.ActiveView
    if activeView
      activeView.stopTimer()
    ProjectTimeTracker.Extras.ActiveView = @
    
    @timedUpdate()
    
  stopTimer: ->
    clearTimeout(@timeout)
    @save({ total_time: @timer.end().newTotal })
    @timer = null
    ProjectTimeTracker.Extras.ActiveView = null
    
  timedUpdate: ->
    @save({ total_time: @timer.totalTime })
    @timeout = setTimeout( =>
      @timedUpdate()
    , 20000)
    
  save: (attrs) ->
    @model.unset("created_at")
    @model.unset("updated_at")
    @model.save(attrs)
  
  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
