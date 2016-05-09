jQuery ->
  if $('.pagination').length
    waypoint = new Waypoint(
      element: $('.pagination')
      handler: ->
        alert('a')
    )





