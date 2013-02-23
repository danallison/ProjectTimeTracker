ProjectTimeTracker.Views.Projects ||= {}

class ProjectTimeTracker.Views.Projects.NewView extends Backbone.View
  template: JST["backbone/templates/projects/new"]

  tagName: "ul"

  events:
    "click .button": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: ->
    @model.set({ title: @el.children[1].children[0].value })
    
    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (project) =>
        @model = project

        view = new ProjectTimeTracker.Views.Projects.ProjectView({ model: @model})
        $("#projects-list").append(view.render().el)
        @remove()

      error: (project, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    return this
