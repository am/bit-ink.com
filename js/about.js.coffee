window.About =
  init: () ->
    lastp = 0
    config =
      swipeStatus: (event, phase, direction, distance, duration, fingerCount)->

        updateSlide = (d) =>
          pa = lastp + d
          pa = Math.max 0, pa
          pa = Math.min 150, pa
          pa

        switch direction
          when "down"
            curp = updateSlide(distance)
          when "up"
            curp = updateSlide(-distance)
          else
            return

        switch phase
          when "move"
            $('.pane').css('-webkit-transform', 'matrix(1, 0, 0, 1, 0, ' + curp + ')')
          when "cancel", "end"
            lastp = curp
            if lastp < 50
              lastp = 0
            else
              lastp = 120
            animation =
              translate: [0, lastp]
            $('.pane').transition animation, 500, 'snap'
            null
          else

    $('.pane').swipe(config)

    document.ontouchmove = (e) ->
      e.preventDefault()