$(document).ready(function(){
  $('.header-slider').slick({
	dots: true,
	infinite: true,
	arrows: false,
  });
});


$(document).ready(function(){

    // Select and loop the container element of the elements you want to equalise
    $('.under-slider-four-sec').each(function(){  
      
      // Cache the highest
      var highestBox = 0;
      
      // Select and loop the elements you want to equalise
      $('.common-sec', this).each(function(){
        
        // If this box is higher than the cached highest then store it
        if($(this).height() > highestBox) {
          highestBox = $(this).height(); 
        }
      
      });  
            
      // Set the height of all those children to whichever was highest 
      $('.common-sec',this).height(highestBox);
                    
    }); 
	
});


//$(document).ready(function(){

    // Select and loop the container element of the elements you want to equalise
    //$('.box-job').each(function(){  
      
      // Cache the highest
     // var highestBox = 0;
      
      // Select and loop the elements you want to equalise
     // $('.equal-height', this).each(function(){
        
        // If this box is higher than the cached highest then store it
        //if($(this).height() > highestBox) {
         // highestBox = $(this).height(); 
       // }
      
     // });  
            
      // Set the height of all those children to whichever was highest 
     // $('.equal-height',this).height(highestBox);
                    
    //}); 
	
//});//



// for height
    Array.prototype.max = function() { // Функція для визначення максимального значення в   масиві
        return Math.max.apply(null, this);
    };
    var makeEqualHeight = function (className) { // string ("className")
        var elements = document.getElementsByClassName(className);
        var heights = []; // масив для запису висот всіх блоків з класом - className
        for(var i = 0; i < elements.length; i++) // проходимо по всіх елементах з класом - className
        {
            var height = elements.item(i).offsetHeight; // витягуємо висоту в блоку
            heights.push(height); // записуємо висоту блоку в масив
        }

        var maxHeight = Math.max.apply(null, heights); // шукаємо максимальну висоту серед       блоків
        $("."+className).height(maxHeight); // даємо максимальну висоту усім блокам
    }


    makeEqualHeight("equal-height");
    makeEqualHeight("equal-height-2");

    if ($( window ).width+17 > 991) {
        makeEqualHeight("equal-height");
        makeEqualHeight("equal-height-2");
    }
    // for height

    $( window ).resize(function() {
        if ($( window ).width+17 > 991) {
            makeEqualHeight("equal-height");
            makeEqualHeight("equal-height-2");
            makeEqualHeight("equal-height");
        }

    });

