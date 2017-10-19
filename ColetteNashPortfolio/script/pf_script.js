$(document).ready(function() {
	//Portfolio Image Overlays
	$(".image").hover(function(event){

		if($("body").width() > "1024") { //Responsive for small devices
			$(".image").animate({opacity: '1'});
			$(this).find("img").animate({opacity: '0'}); //Hide the overlay
		} else {
			$(".image").animate({opacity:'0.7'});
		}
		$(this).animate({opacity: '1'}); //On hover show overlay
	},

	function(){
		$(this).find("img").animate({opacity: '1'}); //Find the image
		$(".image").animate({opacity: '1'}); //Show the overlay
	});
});

//Image Modal
$(function() {
    	$('img').on('click', function() {
			$('.enlargeImageModalSource').attr('src', $(this).attr('src'));
			$('#enlargeImageModal').modal('show');
		});
});
