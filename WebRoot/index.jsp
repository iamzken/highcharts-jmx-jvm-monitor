<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>system monitor</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<script type="text/javascript" src="js/jquery.js"></script>
	<script src="https://code.highcharts.com/highcharts.js"></script>
	<script src="https://code.highcharts.com/modules/exporting.js"></script>
	
  </head>
  
  <body>
	<div id="container" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
  </body>
  
  <script type="text/javascript">
  
  		
  		$(function () {
  		    $(document).ready(function () {
  		        Highcharts.setOptions({
  		            global: {
  		                useUTC: false
  		            }
  		        });

  		        $('#container').highcharts({
  		            chart: {
  		                type: 'spline',
  		                animation: Highcharts.svg, // don't animate in old IE
  		                marginRight: 10,
  		                events: {
  		                    load: function () {

  		                        // set up the updating of the chart each second
  		                      var series = this.series[0];
  		                      setInterval(function () {
		                            var x = (new Date()).getTime(), // current time
		                            y = $.ajax({
		                            		url:"http://localhost:8888/spring_mvc/getMemRate",
		                            		success:function(data){
					                            series.addPoint([x, parseInt(data)], true, true);
		                            		}
	  		                            }
		                            );
		                               // y = 70;
		                              //y=parseInt(y);
		                           // console.log("y"+y);
		                        }, 1000);
  		                    }
  		                }
  		            },
  		            title: {
  		                text: 'jvm monitor tools'
  		            },
  		            xAxis: {
  		                type: 'datetime',
  		                tickPixelInterval: 150
  		            },
  		            yAxis: {
  		                title: {
  		                    text: 'Value'
  		                },
  		                plotLines: [{
  		                    value: 0,
  		                    width: 1,
  		                    color: '#808080'
  		                }]
  		            },
  		            tooltip: {
  		                formatter: function () {
  		                    return '<b>' + this.series.name + '</b><br/>' +
  		                        Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) + '<br/>' +
  		                        Highcharts.numberFormat(this.y, 2);
  		                }
  		            },
  		            legend: {
  		                enabled: false
  		            },
  		            exporting: {
  		                enabled: false
  		            },
  		            series: [{
  		                name: 'jvm memory',
  		                data: (function () {
  		                    // generate an array of random data
  		                    var data = [],
  		                        time = (new Date()).getTime(),
  		                        i;

  		                    for (i = -19; i <= 0; i += 1) {
  		                        data.push({
  		                            x: time + i * 1000,
  		                            y: 1
  		                        });
  		                    }
  		                    return data;
  		                }())
  		            }]
  		        });
  		    });
  		});
  		
  </script>
</html>
