//= require highcharts/highcharts
//= require jqcloud/jqcloud.min
//= require daterangepicker/daterangepicker
//= require admin/reports/consultants
//= require admin/reports/public.js.coffee
//= require admin/reports/search

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