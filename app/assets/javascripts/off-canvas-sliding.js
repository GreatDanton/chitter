$(document).on('ready page:load', function () {

	// function for sliding off-canvas menu
	$(function() {
		$(".mobile-menu").click(function() {
			if($(".off-canvas-menu").hasClass("open")) {
		$(".off-canvas-menu").removeClass("open");
	} else {
		$(".off-canvas-menu").addClass("open");
	}
	});	
});

// function for auto adding rows into comment form
function h(e) {
	$(e).css({'height': 'auto', 'overflow-y': 'hidden'}).height(e.scrollHeight);
}
$('textarea').each(function () {
	h(this);
}).on('input', function () {
	h(this);
});

//smooth back to top scrolling
	$(".back-to-top").click(function(event) {
		event.preventDefault();
		$("body,html").animate({
			scrollTop: 0,
		}, 700);

	});



});