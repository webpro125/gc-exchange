reportSearchPage = ->
  return unless $('body').hasClass('report-search-page')

  filterType = 'today'
  $loading = $('#loading')
  $dateRangeIndicator = $('#date-range')
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

  updateReportData = (data) ->
    $trendingKeywords.jQCloud('update', data.keywords)
    $trendingPositions.jQCloud('update', data.positions)
    $trendingAreas.jQCloud('update', data.areas)
    $trendingDepartments.jQCloud('update', data.departments)
    $trendingCerts.jQCloud('update', data.certifications)

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