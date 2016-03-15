reportConsultantPage = ->
  return unless $('body').hasClass('report-consultants-page')

  dateRange = new DateRange('day')
  $loading = $('#loading')
  $dateRangeIndicator = $('#date-range')
  $consultantAccountChart = $('#consultant-account-chart')
  $consultantLoginChart = $('#consultant-login-chart')
  $cumulativeLoginChart = $('#cumulative-login-chart')

  accountChartOptions =
    chart:
      type: 'line'
    title:
      text: 'Number of Discrete Consultant Account Metrics per Range'
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

  accountLoginOptions =
    chart:
      type: 'line'
    title:
      text: 'Number of Discrete Consultant Login Metrics per Range'
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
      {name: 'Total Logins', data: []}
      {name: 'Uniq Logins', data: []}
    ]

  cumulativeLoginOptions =
    chart:
      type: 'line'
      zoomType: 'x'
    title:
      text: 'Cumulative Consultant Login Metrics'
    credits:
      enabled: false
    yAxis:
      min: 0
      allowDecimals: false
    xAxis:
      type: 'datetime'
      dateTimeLabelFormats:
        day: '%e %b %Y'
      gridLineWidth: 1
      maxZoom: 24 * 3600 * 1000 * 30
    tooltip:
      shared: true
      dateTimeLabelFormats:
        day: '%e %b %Y'
    plotOptions:
      series:
        pointInterval: 24 * 3600 * 1000
    series: [
      {name: 'Total Logins', data: []}
      {name: 'Uniq Logins', data: []}
    ]

  updateReportData = (data) ->
    accountChartOptions.xAxis.categories = data.categories
    accountChartOptions.series[0].data = data.user_count
    accountChartOptions.series[1].data = data.profiles_approved
    accountChartOptions.series[2].data = data.profiles_pending
    $consultantAccountChart.highcharts accountChartOptions

    accountLoginOptions.xAxis.categories = data.categories
    accountLoginOptions.series[0].data = data.total_logins
    accountLoginOptions.series[1].data = data.uniq_logins
    $consultantLoginChart.highcharts accountLoginOptions

    cumulativeLoginOptions.plotOptions.series.pointStart = moment(data.cumulative_start).unix() * 1000
    cumulativeLoginOptions.series[0].data = data.cumulative_logins
    cumulativeLoginOptions.series[1].data = data.cumulative_uniq_logins
    $cumulativeLoginChart.highcharts cumulativeLoginOptions

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

$(document).ready(reportConsultantPage)