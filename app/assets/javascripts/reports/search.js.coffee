reportSearchPage = ->
  return unless $('body').hasClass('report-search-page')

  filterType = 'today'
  $loading = $('#loading')
  $dateRangeIndicator = $('#date-range')
  cloudOptions =
    autoResize: true
    fontSize:
      from: 0.05
      to: 0.03

  updateReportData = (data) ->
    $('#trending-keywords').jQCloud(data.keywords, cloudOptions)
    $('#trending-postions').jQCloud(data.positions, cloudOptions)
    $('#trending-areas').jQCloud(data.areas, cloudOptions)
    $('#trending-departments').jQCloud(data.departments, cloudOptions)

  loadData = ->
    startDate = startRange(filterType)
    $('#filter-types-btn').text(filterType.split('-').join(' '))
    $dateRangeIndicator.text("#{startDate.format('ll')} - #{moment().endOf('day').format('ll')}")
    $loading.show()
    $.ajax '/reports/search',
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

$(document).ready(reportSearchPage)