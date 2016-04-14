reportSearchPage = ->
  return unless $('body').hasClass('admin-report-search-page')

  filterType = 'today'
  $loading = $('#loading')
  $dateRangeIndicator = $('#date-range')
  chartData = {}
  cloudOptions =
    autoResize: true
    removeOverflowing: false
    fontSize:
      from: 0.05
      to: 0.03
  $trendingKeywords = $('#trending-keywords').jQCloud([], cloudOptions)
  $trendingPositions = $('#trending-positions').jQCloud([], cloudOptions)
  $trendingAreas = $('#trending-areas').jQCloud([], cloudOptions)
  $trendingDepartments = $('#trending-departments').jQCloud([], cloudOptions)
  $trendingCerts = $('#trending-certs').jQCloud([], cloudOptions)
  $cumulativeSearchesChart = $('#cumulative-search-graph')

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

  cumulativeSearchOptions =
    chart:
      type: 'line'
      zoomType: 'x'
    title:
      text: 'Cumulative Search Hit Metrics per Range'
    credits:
      enabled: false
    yAxis:
      min: 0
      allowDecimals: false
    xAxis:
      type: 'datetime'
      gridLineWidth: 1
    plotOptions:
      series:
        pointInterval: 24 * 3600 * 1000
    series: [
      {name: 'Search Hits', data: []}
    ]

  processData = (data) ->
    for type in ['keywords', 'positions', 'areas', 'departments', 'certifications']
      data[type].sort (a, b) ->
        if a.weight < b.weight
          1
        else if a.weight > b.weight
          -1
        else
          0
    data

  showTrendingModal = (type, title) ->
    $modal = $('#trending-table-modal')
    $content = $('#trending-table-modal #top-trending-table tbody')
    $modal.find('.modal-title').text('Top 10 ' + title)
    $content.html('')
    records = chartData[type][0..10]
    if records.length > 0
      $content.append("""<tr><td>#{record.text}</td><td>#{record.weight}</td></tr>""") for record in records
    else
      $content.html("<tr><td colspan='2'>No trending data.</tr>")
    $modal.modal('show')

  updateReportData = (data) ->
    chartData = processData(data)
    $trendingKeywords.jQCloud('update', data.keywords)
    $trendingPositions.jQCloud('update', data.positions)
    $trendingAreas.jQCloud('update', data.areas)
    $trendingDepartments.jQCloud('update', data.departments)
    $trendingCerts.jQCloud('update', data.certifications)
    cumulativeSearchOptions.plotOptions.series.pointStart = moment(data.cumulative_searches_start).valueOf()
    cumulativeSearchOptions.series[0].data = data.cumulative_searches
    $cumulativeSearchesChart.highcharts cumulativeSearchOptions

  loadData = ->
    $dateRangePicker = $('#report-range').data('daterangepicker')
    $loading.show()
    $.ajax '/admin/reports/search',
      dataType: 'JSON'
      data:
        from: $dateRangePicker.startDate.format()
        to: $dateRangePicker.endDate.format()
    .done (data) ->
      updateReportData(data)
    .complete ->
      $loading.hide()

  loadData()

  $('.report-data a.top-trending').on 'click', (e) ->
    e.preventDefault()
    showTrendingModal($(@).data('type'), $(@).text())

  $('#report-range').on 'apply.daterangepicker', (e, picker) ->
    loadData()


$(document).ready(reportSearchPage)