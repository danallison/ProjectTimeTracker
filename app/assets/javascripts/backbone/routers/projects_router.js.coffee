class ProjectTimeTracker.Routers.ProjectsRouter extends Backbone.Router
  initialize: (options) ->
    @projects = new ProjectTimeTracker.Collections.ProjectsCollection()
    @projects.reset options.projects

  routes:
    ""  : "index"

  index: ->
    @view = new ProjectTimeTracker.Views.Projects.IndexView(projects: @projects)
    $("#projects").html(@view.render().el)
