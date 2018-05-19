alertify.set('notifier','position', 'top-right');

$(function(){
	$("a.jobs-action").on('click',function(event){
		event.preventDefault();
		if(this.href.indexOf('close_job') > 0){
			if (confirm("Are you sure you want to close this Job.")){
				updateTheJob(this);
			}
		}else{
			updateTheJob(this);
		}
	    return false;
	})
});

function token(){
  return $("meta[name='csrf-token']").attr("content");
}

function updateTheJob(e){
	$.ajax({
        type: "post",
        url: e.href,
        data: {'authenticity_token': token() },
         cache: false,
    	success: function(data, textStatus, xhr) {
    		if (textStatus == "success") {
	           setJobStatusUrl(data);
	        }else{
	        	alertify.error("Unable to Update the job.");
	        }
        },
        error: function (xhr, ajaxOptions, thrownError){

        }
    });	
}

function setJobStatusUrl(obj){
	var jobelement = $("#job_"+obj.id);
	if(obj.status == "open"){
		jobelement.attr('href', jobelement.attr('href').replace("open_job", "close_job"));
		jobelement.text("Close the job");
		alertify.success(obj.title +" "+ obj.status + " " + "Successfully!");
	}else if(obj.status == "closed" ){
		jobelement.attr('href', jobelement.attr('href').replace("close_job", "open_job"));
		jobelement.text("Open the job");
		alertify.warning(obj.title +" "+ obj.status + " " + "Successfully!");
	}
	$("a#options").click();
}
