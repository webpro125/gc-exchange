class @DateRange
  constructor: (@type, @offset = 0) ->
    @.recalculate()

  setType: (type) ->
    if type != @type
      @offset = 0
      @type = type
      @.recalculate()

  forward: ->
    if @offset > 0
      @offset--
      @.recalculate()

  backward: ->
    @offset++
    @.recalculate()

  recalculate: ->
    _moment = moment().subtract(@offset, @type)
    type = @type
    type = 'isoweek' if type == 'week' # small patch to make week start from Monday instead of Sunday
    @from =_moment.clone().startOf(type)
    @to =_moment.clone().endOf(type)

  from4rails: -> @from.format()
  to4rails: -> @to.format()

  toString: ->
    if @type is 'year'
      @from.year()
    else if @type is 'month'
      @from.format('MMM YYYY')
    else if @type is 'today' or @type is 'day'
      @from.format('DD MMM YYYY')
    else if @type is ''
      'All Time'
    else
      "#{@from.format('ll')} - #{@to.format('ll')}"