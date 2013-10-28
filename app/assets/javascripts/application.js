// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require_tree .

$(document).ready(function(){
   $(".list_item").click(function(){
      /* personally I would throw a url attribute (<tr url="http://www.hunterconcepts.com">) on the tr and pull it off on click */
      window.location = $(this).attr("url");
   });

   $('a.zoom').easyZoom({
		parent: '#listing_body'
	});
});

var BAROMETER;
if(BAROMETER == undefined) {
  BAROMETER = {};
}

BAROMETER.load = function(barometer_id) {
  this.barometer_id = barometer_id;
  this.empty_url = "http://getbarometer.s3.amazonaws.com/assets/barometer/images/transparent.gif";
  this.feedback_url = 'http://getbarometer.com/system/feedback_form/' + this.barometer_id;

  this.tab_html = '<a id="barometer_tab" onclick="BAROMETER.show();" href="#">Feedback</a>';
  this.overlay_html = '<div id="barometer_overlay" style="display: none;">' +
			'<div id="barometer_main" style="top: 130.95px;">' +
			'<a id="barometer_close" onclick="document.getElementById(\'barometer_overlay\').style.display = \'none\';return false" href="#"/></a>' +
			'<div id="overlay_header">' +
				'<p id="contact_header">Contact Trinlist</p>' +
				'</div>' +
				'<iframe src="' + this.empty_url + '" id="barometer_iframe" allowTransparency="true" scrolling="no" frameborder="0" class="loading"></iframe>' +
				'</div>' +
				'<div id="barometer_screen" onclick="document.getElementById(\'barometer_overlay\').style.display = \'none\';return false" style="height: 100%;"/>' +
				'</div>' +
	'</div>';
       
    document.write(this.tab_html);
    document.write(this.overlay_html);    
};

BAROMETER.show = function() {
  document.getElementById('barometer_iframe').setAttribute("src", this.feedback_url);
  document.getElementById('barometer_overlay').style.display = "block";
  return false;
};