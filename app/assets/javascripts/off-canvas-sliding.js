$(document).on('ready page:load', function () {

	$(function() {
		$(".mobile-menu").click(function() {
			toggleNav();

		});

		
	});

function toggleNav() {
	if($(".off-canvas-menu").hasClass("open")) {
		$(".off-canvas-menu").removeClass("open");
	} else {
		$(".off-canvas-menu").addClass("open");
	}
}

function h(e) {
	$(e).css({'height': 'auto', 'overflow-y': 'hidden'}).height(e.scrollHeight);
}
$('textarea').each(function () {
	h(this);
}).on('input', function () {
	h(this);
});

});