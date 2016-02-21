reportPage = ->
  return unless $('body').hasClass('report-metrics-page')
  dateRange = new DateRange('today')
  $loading = $('#loading')
  $dateRangeIndicator = $('#date-range')

  $newAccounts = $('#new-accounts')
  $profilesPending = $('#profiles-pending')
  $profilesApproved = $('#profiles-approved')

  updateReportData = (data) ->
    $newAccounts.text(data.new_accounts)
    $profilesApproved.text(data.approved)
    $profilesPending.text(data.pending)

  loadData = ->
    if dateRange.type is 'today'
      $('#offset-minus, #offset-plus').addClass('disabled')
    else
      $('#offset-minus, #offset-plus').removeClass('disabled')
    $dateRangeIndicator.text(dateRange)
    $loading.show()
    $.ajax
      dataType: 'JSON'
      type: 'GET'
      url: '/reports'
      data:
        from: dateRange.from4rails()
        to: dateRange.to4rails()
    .done (data) ->
      updateReportData(data)
    .complete ->
      $loading.hide()

  loadData()

  $('.filter-types > li > button').on 'click', Foundation.utils.debounce( (e) ->
    e.preventDefault()
    filter = $(@).data('filter')
    if dateRange.type isnt filter
      dateRange.setType(filter)
      loadData()
  , 500, false)

  $('#offset-minus').on 'click', Foundation.utils.debounce( (e) ->
    dateRange.backward();
    loadData()
  , 500, false)

  $('#offset-plus').on 'click', Foundation.utils.debounce( (e) ->
    dateRange.forward()
    loadData()
  , 500, false)

$(document).ready(reportPage)