ProjectTimeTracker.Views.Projects ||= {}

class ProjectTimeTracker.Views.Projects.ProjectView extends Backbone.View
  template: JST["backbone/templates/projects/project"]

  events:
    "click .destroy" : "destroy"
    "click .timer"   : "toggleTimer"

  tagName: "ul"

  destroy: ->
    @model.destroy()
    this.remove()

    return false

  toggleTimer: ->
    if @timer
      @stopTimer()
    else
      @startTimer()
      
  startTimer: ->
    @timer = new ProjectTimeTracker.Extras.Timer(@el.children[0], @model.attributes.total_time)
    $(@el.children[0]).addClass("active")
    activeView = ProjectTimeTracker.Extras.ActiveView
    if activeView
      activeView.stopTimer()
    ProjectTimeTracker.Extras.ActiveView = @
    
  stopTimer: ->
    @save()
    $(@el.children[0]).removeClass("active")
    @timer = null
    ProjectTimeTracker.Extras.ActiveView = null
      
  save: ->
    @model.unset("created_at")
    @model.unset("updated_at")
    @model.save({ total_time: @timer.end().newTotal })
  
  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
