//= require highcharts/highcharts
//= require jqcloud/jqcloud.min
//= require reports/consultants
//= require reports/public.js.coffee
//= require reports/search

Highcharts.setOptions({
  global: {
    useUTC: false
  },
  xAxis: {
    dateTimeLabelFormats: {
      day: '%e %b %Y',
      week: '%e %b',
      month: '%b \'%y',
      year: '%Y'
    }
  },
  tooltip: {
    dateTimeLabelFormats: {
      day: '%e %b %Y',
      week: '%e %b',
      month: '%b \'%y',
      year: '%Y'
    }
  }
});