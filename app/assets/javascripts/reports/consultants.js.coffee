reportPage = ->
  return unless $('body').hasClass('report-consultants-page')

  dateRange = new DateRange('day')
  $loading = $('#loading')
  $dateRangeIndicator = $('#date-range')
  $consultantChart = $('#consultant-chart')

  chartOptions =
    chart:
      type: 'line'
    title: false
    credits:
      enabled: false
    yAxis:
      min: 0
      allowDecimals: false
    xAxis:
      type: 'category'
      gridLineWidth: 1
    tooltip:
      shared: true
    series: [
      {name: 'New Accounts', data: []}
      {name: 'Profiles Approved', data: []}
      {name: 'Profiles Pending', data: []}
    ]

  updateReportData = (data) ->
    chartOptions.xAxis.categories = data.categories
    chartOptions.series[0].data = data.user_count
    chartOptions.series[1].data = data.profiles_approved
    chartOptions.series[2].data = data.profiles_pending
    $consultantChart.highcharts chartOptions

  loadData = ->
    $('#filter-types-btn').text(dateRange.type)
    $dateRangeIndicator.text(dateRange)
    $loading.show()
    $.ajax '/reports/consultant',
      dataType: 'JSON'
      data:
        from: dateRange.from4rails()
        to: dateRange.to4rails()
        filter: dateRange.type
    .done (data) ->
      updateReportData(data)
    .complete ->
      $loading.hide()

  loadData()

  $('#drop-filter-types a[data-filter]').on 'click', Foundation.utils.debounce( (e) ->
    e.preventDefault()
    filter = $(@).data('filter')
    if dateRange.type isnt filter
      dateRange.setType(filter)
      loadData()
  , 500, true)

  $('#offset-minus').on 'click', Foundation.utils.debounce( (e) ->
    dateRange.backward();
    loadData()
  , 500, true)

  $('#offset-plus').on 'click', Foundation.utils.debounce( (e) ->
    dateRange.forward()
    loadData()
  , 500, true)

$(document).ready(reportPage)