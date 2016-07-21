reportVisitsPage = ->
  return unless $('body').hasClass('report-public-page')

  $loading = $('#loading')
  $dateRangeIndicator = $('#date-range')
  chartData = {}

  typeName =
    pageviews: 'Page Views'
    avg_session_duration: 'Avg. Session Duration'
    pages_per_session: 'Pages Per Session'

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
          enabled: true
          format: '<b>{point.name}</b>: {point.percentage:.1f} %'
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
      labels:
        align: 'right'
    xAxis:
      type: 'datetime'
      gridLineWidth: 1
      maxZoom: 24 * 3600 * 1000 * 30
    tooltip: {}
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

  durationFormat = (seconds) ->
    moment.utc(seconds * 1000).format('HH:mm:ss')

  displayDateRange = (start, end) ->
    $('#report-range span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
  displayDateRange(moment().subtract(29, 'days'), moment());

  $('#report-range').daterangepicker(
    startDate: moment().subtract(29, 'days')
    opens: 'left'
    ranges:
      'Today': [moment(), moment()],
      'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
      'Last 7 Days': [moment().subtract(6, 'days'), moment()],
      'Last 30 Days': [moment().subtract(29, 'days'), moment()],
      'This Month': [moment().startOf('month'), moment().endOf('month')],
      'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
  , displayDateRange)

  processData = (data) ->
    for type in ['pageviews', 'avg_session_duration', 'pages_per_session']
      total = 0
      for record in data[type]
        record[0] = moment(record[0]).valueOf()
        total += parseInt(record[1])
        record[1] = parseInt(record[1])
      data[type + '_total'] = total

    for type in ['sessions_per_device', 'sessions_in_bound', 'sessions_per_browser']
      total = 0
      for record in data[type]
        total += parseInt(record[1])
        record[1] = parseInt(record[1])
      data[type + '_total'] = total

  renderSessionGraph = (type, title) ->
    sessionGraphOption.series[0].name = typeName[type]
    sessionGraphOption.series[0].data = chartData[type]
    sessionGraphOption.title.text = title
    if type == 'avg_session_duration'
      sessionGraphOption.tooltip.formatter = ->
        """#{moment(this.x).format('MMM DD YYYY')}<br/> <span style="color:#{this.color}">\u25CF</span> #{this.series.name}: <b>#{durationFormat(this.y)}</b><br/>"""
      sessionGraphOption.yAxis.tickInterval = 3600
      sessionGraphOption.yAxis.labels.formatter = ->
        durationFormat(this.value)
    else
      sessionGraphOption.tooltip = {}
      sessionGraphOption.yAxis.tickInterval = undefined
      sessionGraphOption.yAxis.labels.formatter = undefined
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

  renderPieChart = (id, type) ->
    records = []
    data = chartData[type]
    for record in data
      records.push {name: record[0], y: record[1]}
    pieChartOption.series[0].data = records
    $(id).highcharts pieChartOption
    $(id + '-total').text(chartData[type + '_total'])

  updateReportData = (data) ->
    $('.report-data .panel.expandable').removeClass('active')
    processData(data)
    $('#detail-session-graph').hide()
    chartData = data
    renderPieChart('#sessions-per-device', 'sessions_per_device')
    renderPieChart('#sessions-in-bound', 'sessions_in_bound')
    renderPieChart('#sessions-per-browser', 'sessions_per_browser')
    $('#total-pageviews').text(data.pageviews_total)
    $('#avg-session-duration').text(durationFormat(data.avg_session_duration_sum))
    $('#page-per-session').text(data.pages_per_session_total)
    renderGeoCountryMap('sessions-per-country', data.sessions_per_country, 'Country')
    renderGeoCityMap('sessions-per-city', data.sessions_per_city, 'City')
    if data.valid then $('#alert-message').hide() else $('#alert-message').show()

  loadData = ->
    $dateRangePicker = $('#report-range').data('daterangepicker')
    $loading.show()
    $.ajax '/admin/reports/public',
      dataType: 'JSON'
      data:
        from: $dateRangePicker.startDate.format()
        to: $dateRangePicker.endDate.format()
    .done (data) ->
      console.log(data)
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
    $('.report-data .panel.expandable').removeClass('active')
    $(@).addClass('active')
    renderSessionGraph($(@).data('type'), $(@).find('p').text())

  $('#report-range').on 'apply.daterangepicker', (e, picker) ->
    loadData()

$(document).ready(reportVisitsPage)