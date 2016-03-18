reportConsultantPage = ->
  return unless $('body').hasClass('report-consultants-page')

  dateRange = new DateRange('day')
  $loading = $('#loading')
  $dateRangeIndicator = $('#date-range')
  $consultantAccountChart = $('#consultant-account-chart')
  $consultantLoginChart = $('#consultant-login-chart')

  accountChartOptions =
    chart:
      type: 'line'
    title:
      text: 'Consultant Account Metrics'
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
      text: 'Consultant Login Metrics'
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