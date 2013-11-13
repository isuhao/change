Crafty.c 'Ticker',

  init: ->
    @requires('2D, DOM, Text, Delay')
    .textColor('black')
    .attr({w: 174, h: 46, x: 752, y: 107, z: 500})
    .textFont(size: '39px')
    .css('text-align': 'center')
    .delay(@_tick, 1000, Infinity)

    @_declaredEnd = false
    @_remainingSeconds = Config.game.time

    @_updateTicker()

  addTime: (time) ->
    @_remainingSeconds += time
    @_updateTicker()

  subtractTime: (time) ->
    @_remainingSeconds -= time
    @_remainingSeconds = Math.max(0, @_remainingSeconds)
    @_updateTicker()

    @_declareEnd() if @_didRoundEnd()

  _tick: ->
    if @_didRoundEnd()
      @_declareEnd()
      return

    @_remainingSeconds -= 1
    @_updateTicker()
    @_declareEnd if @_didRoundEnd()

  _updateTicker: ->
    @text(@_remainingSeconds.toMMSS())
    @trigger('RoundTimeChanged')

  _didRoundEnd: ->
    @_remainingSeconds == 0

  _declareEnd: ->
    if !@_declaredEnd
      @_declaredEnd = true
      @trigger('RoundTimeEnded')
