//Pretty Buttons Project Colette Nash K00212038

$(document).ready(function(){

//Global Variable for the button text used for the dynamic text creation and to generate html
var valText="Click Me"

	//creates the button and puts an initial text on it
	$( function() {
		$("#button_regular").button().text(valText);
		} );

	//Dynamically changes the text on the button as you type using the keyup() method
		$("#text").keyup(function(){
			valText = $(this).val();
			$("#button_regular").text(valText);
		});

	//Changing the border radius on the button using the slider
		$("#radius").slider({
			animate:"fast",
			value:1,
			min:0,
			max:100,
			step:2,
			slide:changeRadius
    });
		function changeRadius (event, slider) {
         $("#button_regular").css('border-radius', slider.value + '%');
		}

		//Reset the border radius and the slider to default value
		$("#resetRadius").click( function(){
			$("#button_regular").css('border-radius', '1%');
			$("#radius").slider({
				value:1
   			});
		});



			//Changes the size of the button by dragging with the mouse or by touch using the resizable() method
			// $( function() {
			// 	$( "#button_regular" ).resizable();
			// 	$( "#button_regular" ).draggable();
			// 	});

			//

	//
	//Changing the size of the button using the slider
		// $("#size").slider({
		// 	animate:"fast",
		// 	value:1,
		// 	min:2,
		// 	max:26,
		// 	step:2,
		// 	slide:changeSize
    // });
		// function changeSize (event, slider) {
    //      $("#button_regular").css('padding', slider.value + '%');
		// }

		// //Reset the padding and the slider to default value
		// $("#resetSize").click( function(){
		// 	$("#button_regular").css('padding', '1%');
		// 	$("#size").slider({
		// 		value:1
   // 			});
		// });

	//
	// //Changing the size of the font using the slider
	// 	$("#font").slider({
	// 		animate:"fast",
	// 		value:20,
	// 		min:20,
	// 		max:50,
	// 		step:2,
	// 		slide:changeFont
  //   });
	// 	function changeFont (event, slider) {
  //        $("#button_regular").css('font-size', slider.value + 'px');
	// 	}
  //
	// 	//Reset the font size and the slider to default value
	// 	$("#resetFont").click( function(){
	// 		$("#button_regular").css('font-size', '20px');
	// 		$("#font").slider({
	// 			value:20
  //  			});
	// 	});

	//
	//Changing the size of the border using the slider
		$("#border").slider({
			animate:"fast",
			value:1,
			min:1,
			max:20,
			step:2,
			slide:changeBorder
    });
		function changeBorder (event, slider) {
         $("#button_regular").css('border-width',
			 slider.value + 'px');
		}

	//Reset the border width and the slider to default value
	$("#resetBorder").click( function(){
			$("#button_regular").css('border-width', '1px');
			$("#border").slider({
				value:1
   			});
		});

	//
	//Changing the shadow of the border using the slider
		$("#shadow").slider({
			animate:"fast",
			value:1,
			min:5,
			max:100,
			step:2,
			slide:changeShadow
    	});

		function changeShadow (event, slider) {
         $("#button_regular").css({
		 boxShadow: '10px 10px 10px white' },
		 slider.value + 'px');
		}

	//Reset the shadow and the slider to default value
		$("#resetShadow").click( function(){
			$("#button_regular").css('box-shadow', '0.5px 0.5px 0.5px white');
			$("#shadow").slider({
				value:1
   			});
		});

	//
	//Chose an image for the button
	$(function () {
		$('#wallpaper').on('change', function () {
			var wallPaper = $('option:selected', this).val();
			$('#button_regular').css('background-image', 'url(' + wallPaper + ')');
		});
	});

	//
	//Choose a font family for the button
	$(function () {
		$('#fontFamily').on('change', function () {
		$('#button_regular').css("font-family", $(this).val());
		});
	});

	//
	//Generate HTML
	$('#genHtml').click(function (){
		$('#areaHtml').html('<button>' + valText +'</button>' );
		});


	//
	//Generate CSS
	$('#genCss').click(function (){
		$('#areaCss').html('This functionality is not working!');
		});

//		var style = css($(".main"));
//		$("#areaCss").css(style);
		//var style = window.getComputedStyle($('#button_regular').get(0),null);
		//alert(style);
		//$('.main').style.cssText;
	//});

	$('#back').click(function(){
		parent.history.back();
		return false;
	});

	//Dont let the form refresh my page :)
	$("#buttonForm").submit(function(e) {
    e.preventDefault();
});

});
