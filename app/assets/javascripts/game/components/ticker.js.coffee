Crafty.c 'Ticker',

  init: ->
    @requires('2D, DOM, Text, Delay')
    .textColor('black')
    .attr({w: 174, h: 46, x: 752, y: 107, z: 500})
    .textFont(size: '39px')
    .css('text-align': 'center')
    .delay(@_tick, 1000, Infinity)

    @_secondsInRound = Config.game.time
    @_remainingSeconds = @_secondsInRound

    @_updateTicker()

  addTime: (time) ->
    @_secondsInRound += time
    @trigger('RoundTimeAdded')
    @_updateTicker()

  subtractTime: (time) ->
    @_secondsInRound -= time
    @trigger('RoundTimeSubtracted')
    @_updateTicker()

  _tick: ->
    return if @_didRoundEnd()
    @_remainingSeconds -= 1
    @_updateTicker()
    @trigger('RoundTimeEnded') if @_didRoundEnd()

  _updateTicker: ->
    @text(@_remainingSeconds.toMMSS())
    @trigger('RoundTimeChanged')

  _didRoundEnd: ->
    @_remainingSeconds == 0