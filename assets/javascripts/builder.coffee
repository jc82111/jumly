class DiagramBuilder
  @selectHTMLScriptElements = (element)->
    $("script", element).not(".ignored")

DiagramBuilder::beforeCompose = (f)->
  @_diagram.bind "beforeCompose", f
  this

DiagramBuilder::afterCompose = (f)->
  @_diagram.bind "afterCompose", f
  this

DiagramBuilder::accept = (closure)->
  closure.apply this, []

DiagramBuilder::build = (text)->
  try
    typename = this.constructor.name.replace(/^JUMLY/, "")
                                    .replace(/Diagram(Builder)?$/, "")
                                    .toLowerCase()
    @diagram = $.jumly ".#{typename}-diagram"
    @accept -> eval CoffeeScript.compile text
    @diagram.trigger "build.after"
    @diagram
  catch ex
    $.logger(this).error ex, ex.stack if @verbose
    throw ex

JUMLY.DiagramBuilder = DiagramBuilder
