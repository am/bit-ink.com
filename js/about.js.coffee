class BitInkApp
  # app variables
  isOpen = false
  lastp = 0
  # swipe configuration
  config =
    swipeStatus: (event, phase, direction, distance, duration, fingerCount)->

      updateSlide = (d) =>
        pa = lastp + d
        pa = Math.max 0, pa
        pa = Math.min 150, pa
        pa

      switch direction
        when "down"
          current_y = updateSlide(distance)
        when "up"
          current_y = updateSlide(-distance)
        else
          return

      switch phase
          when "move"
            $('.pane').css('-webkit-transform', 'matrix(1, 0, 0, 1, 0, ' + current_y + ')')
          when "cancel", "end"
            lastp = current_y
            if lastp < 50
              lastp = 0
              # brain melter
              isOpen = true
            else
              lastp = $('header').outerHeight()
              # brain melter again
              isOpen = false
            null
          else

  constructor: ->
    # set listeners
    $('.pane').swipe config
    $('.pane').click onClickPane

    # open panel
    $('.pane').delay(500).click();

  onClickPane = (e) ->
    to_y = (if isOpen then 0 else $('header').outerHeight())
    animation =
      translate: [0, to_y]
    $('.pane').transition animation, 500, 'snap'
    isOpen = !isOpen
    if isOpen
      # track event analytics
      _gaq.push ['_trackEvent', 'Home', 'open header panel']

  document.ontouchmove = (e) ->
    e.preventDefault()

# make var avaliable to the public scope for latter initiation
window.BitInkApp = BitInkApp