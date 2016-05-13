//= require highcharts/highcharts
//= require jqcloud/jqcloud.min
//= require daterangepicker/daterangepicker
//= require jquery.ba-throttle-debounce
//= require admin/reports/consultants
//= require admin/reports/public
//= require admin/reports/search
//= require admin/reports/general-users
//= require admin/reports/companies

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