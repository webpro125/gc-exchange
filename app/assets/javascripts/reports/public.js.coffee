reportVisitsPage = ->
  return unless $('body').hasClass('report-public-page')

  filterType = 'last-month'
  $loading = $('#loading')
  $dateRangeIndicator = $('#date-range')
  chartData = {}

  pieChartOption =
    chart:
      type: 'pie'
      backgroundColor: null
    title: false
    credits:
      enabled: false
    plotOptions:
      pie:
        allowPointSelect: true
        cursor: 'pointer'
        dataLabels:
          enabled: false
    series: [{
      name: 'Sessions'
      colorByPoint: true
      data: []
    }]

  sessionGraphOption =
    chart:
      type: 'line'
    title:
      text: ''
    credits:
      enabled: false
    yAxis:
      min: 0
      allowDecimals: false
    xAxis:
      type: 'datetime'
      gridLineWidth: 1
      maxZoom: 24 * 3600 * 1000 * 30
    legend:
      enabled: false
    series: [
      {name: 'Sessions', data: []}
    ]

  google.charts.load('current', packages: ['geochart'])

  dataToTable = (records) ->
    return "No Data" unless records.length
    list = []
    list.push """#{record[0]}: #{record[1]}""" for record in records
    list.join("<br>")

  processData = (data) ->
    for type in ['pageviews', 'avg_session_duration', 'pages_per_session']
      total = 0
      for record in data[type]
        record[0] = moment(record[0]).valueOf()
        total += parseInt(record[1])
        record[1] = parseInt(record[1])
      data[type + '_total'] = total

  renderSessionGraph = (type) ->
    sessionGraphOption.series[0].data = chartData[type]
    $('#detail-session-graph').show().highcharts sessionGraphOption

  renderGeoCountryMap = (id, records) ->
    for record in records
      record[1] = parseInt(record[1])
    records.unshift ['Country', 'Sessions']
    chart = new google.visualization.GeoChart(document.getElementById(id))
    chart.draw(google.visualization.arrayToDataTable(records), {})

  renderGeoCityMap = (id, records) ->
    for record in records
      record[1] = parseInt(record[1])
    records.unshift ['City', 'Sessions']
    chart = new google.visualization.GeoChart(document.getElementById(id))
    chart.draw(google.visualization.arrayToDataTable(records), {
      displayMode: 'markers'
    })

  renderPieChart = (id, data) ->
    records = []
    for record in data
      records.push {name: record[0], y: parseInt(record[1])}
    pieChartOption.series[0].data = records
    $(id).highcharts pieChartOption

  updateReportData = (data) ->
    processData(data)
    $('#detail-session-graph').hide()
    chartData = data
    renderPieChart('#sessions-per-device', data.sessions_per_device)
    renderPieChart('#sessions-in-bound', data.sessions_in_bound)
    renderPieChart('#sessions-per-browser', data.sessions_per_browser)
    $('#total-pageviews').text(data.pageviews_total)
    $('#avg-session-duration').text(data.avg_session_duration_total)
    $('#page-per-session').text(data.pages_per_session_total)
    renderGeoCountryMap('sessions-per-country', data.sessions_per_country, 'Country')
    renderGeoCityMap('sessions-per-city', data.sessions_per_city, 'City')
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

  $('.report-data .panel.expandable').on 'click', (e) ->
    e.preventDefault()
    renderSessionGraph($(@).data('type'))

  $('#drop-filter-types a[data-filter]').on 'click', Foundation.utils.debounce( (e) ->
    e.preventDefault()
    filter = $(@).data('filter')
    if filterType isnt filter
      filterType = filter
      loadData()
  , 500, true)

$(document).ready(reportVisitsPage)