ProjectTimeTracker.Views.Projects ||= {}

class ProjectTimeTracker.Views.Projects.IndexView extends Backbone.View
  template: JST["backbone/templates/projects/index"]
  
  events:
    "click #new-button" : "newProject"

  initialize: () ->
    @options.projects.bind('reset', @addAll)

  addAll: () =>
    @options.projects.each(@addOne)

  addOne: (project) =>
    view = new ProjectTimeTracker.Views.Projects.ProjectView({model : project})
    @$("#projects-list").append(view.render().el)

  newProject: =>
    console.log(@)
    view = new ProjectTimeTracker.Views.Projects.NewView({collection: @options.projects })
    @$("#projects-list").append(view.render().el)

  render: =>
    $(@el).html(@template(projects: @options.projects.toJSON() ))
    @addAll()

    return this
