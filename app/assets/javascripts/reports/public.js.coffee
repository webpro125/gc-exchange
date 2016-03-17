reportVisitsPage = ->
  return unless $('body').hasClass('report-public-page')

  filterType = 'today'
  $loading = $('#loading')
  $dateRangeIndicator = $('#date-range')

  google.charts.load('current', packages: ['geochart'])

  dataToTable = (records) ->
    return "No Data" unless records.length
    list = []
    list.push """#{record[0]}: #{record[1]}""" for record in records
    list.join("<br>")

  renderGeoMap = (id, records) ->
    for record in records
      record[1] = parseInt(record[1])
    records.unshift ['Country', 'Sessions']
    chart = new google.visualization.GeoChart(document.getElementById(id))
    chart.draw(google.visualization.arrayToDataTable(records), {})

  updateReportData = (data) ->
    $('#total-pageviews').text(data.pageviews)
    $('#avg-session-duration').text(data.avg_session_duration)
    $('#page-per-session').text(data.pages_per_session)
    $('#sessions-per-device').html(dataToTable(data.sessions_per_device))
    $('#sessions-in-bound').html(dataToTable(data.sessions_in_bound))
    $('#sessions-per-browser').html(dataToTable(data.sessions_per_browser))
    renderGeoMap('sessions-per-country', data.sessions_per_country)
    if data.valid then $('#alert-message').hide() else $('#alert-message').show()

  loadData = ->
    startDate = startRange(filterType)
    $('#filter-types-btn').text(filterType.split('-').join(' '))
    if filterType == 'today'
      $dateRangeIndicator.text("#{startDate.format('ll')}")
    else
      $dateRangeIndicator.text("#{startDate.format('ll')} - #{moment().endOf('day').format('ll')}")
    $loading.show()
    $.ajax '/reports/public',
      dataType: 'JSON'
      data:
        from: startDate.format()
        to: moment().endOf('day').format()
    .done (data) ->
      updateReportData(data)
    .complete ->
      $loading.hide()

  startRange = (filter) ->
    if filter == 'today'
      moment().startOf('day')
    else if filter == 'last-week'
      moment().subtract(7, 'day')
    else if filter == 'last-month'
      moment().subtract(1, 'month')
    else if filter == 'last-2-months'
      moment().subtract(2, 'month')
    else if filter == 'last-3-months'
      moment().subtract(3, 'month')

  loadData()

  $('#drop-filter-types a[data-filter]').on 'click', Foundation.utils.debounce( (e) ->
    e.preventDefault()
    filter = $(@).data('filter')
    if filterType isnt filter
      filterType = filter
      loadData()
  , 500, true)

$(document).ready(reportVisitsPage)