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
autosize.update($('textarea'));


});