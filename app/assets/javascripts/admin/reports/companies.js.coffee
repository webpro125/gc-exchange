reportCompaniesPage = ->
  return unless $('body').hasClass('admin-report-companies-page')

  dateRange = new DateRange('day')
  $loading = $('#loading')
  $dateRangeIndicator = $('#date-range')
  $companyLoginChart = $('#company-login-chart')
  $companyAccountChart = $('#company-account-chart')
  $cumulativeLoginChart = $('#cumulative-login-chart')

  accountChartOptions =
    chart:
      type: 'line'
    title:
      text: 'Number of Discrete Client Company Account Metrics per Range'
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
    ]

  accountLoginOptions =
    chart:
      type: 'line'
    title:
      text: 'Number of Discrete Client Company Login Metrics per Range'
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
      text: 'Cumulative Client Company Login Metrics'
    credits:
      enabled: false
    yAxis:
      min: 0
      allowDecimals: false
    xAxis:
      type: 'datetime'
      gridLineWidth: 1
      maxZoom: 24 * 3600 * 1000 * 30
    tooltip:
      shared: true
    plotOptions:
      series:
        pointInterval: 24 * 3600 * 1000
    series: [
      {name: 'Total Logins', data: []}
      {name: 'Uniq Logins', data: []}
    ]

  updateReportData = (data) ->
    accountChartOptions.xAxis.categories = data.categories
    accountChartOptions.series[0].data = data.company_count
    $companyAccountChart.highcharts accountChartOptions

    accountLoginOptions.xAxis.categories = data.categories
    accountLoginOptions.series[0].data = data.total_logins
    accountLoginOptions.series[1].data = data.uniq_logins
    $companyLoginChart.highcharts accountLoginOptions

    cumulativeLoginOptions.plotOptions.series.pointStart = moment(data.cumulative_start).unix() * 1000
    cumulativeLoginOptions.series[0].data = data.cumulative_logins
    cumulativeLoginOptions.series[1].data = data.cumulative_uniq_logins
    $cumulativeLoginChart.highcharts cumulativeLoginOptions

  loadDataDebounce = $.debounce(1000, ->
    $.ajax '/admin/reports/company',
      dataType: 'JSON'
      data:
        from: dateRange.from4rails()
        to: dateRange.to4rails()
        filter: dateRange.type
    .done (data) ->
      updateReportData(data)
    .complete ->
      $loading.hide()
  )

  loadData = ->
    $('#filter-types-btn #filter-label').text(dateRange.type)
    $dateRangeIndicator.text(dateRange)
    $loading.show()
    loadDataDebounce()

  loadData()

  $('#drop-filter-types a[data-filter]').on 'click', (e) ->
    e.preventDefault()
    filter = $(@).data('filter')
    if dateRange.type isnt filter
      dateRange.setType(filter)
      loadData()

  $('#offset-minus').on 'click', (e) ->
    dateRange.backward();
    loadData()

  $('#offset-plus').on 'click', (e) ->
    dateRange.forward()
    loadData()

$(document).ready(reportCompaniesPage)