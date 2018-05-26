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


function saveComment(form){
    $.ajax({
           type: form.method,
           url: form.action,
           data: $("#commentForm").serialize(),
           dataType: "json",
           success: function(data, textStatus, xhr) {
           		if(textStatus == "success"){
           			action = "show('"+data.interview_schedule_id+"','"+data.interview_schedule_id+"','"+data.comment+"')";
           			if ($("#comment_"+data.interview_schedule_id+"_"+data.id).length) {
           				/*--------- Edit Comment ---------*/
           				$("#comment_"+data.interview_schedule_id+"_"+data.id).text(data.comment);
           				$("#comment_"+data.interview_schedule_id+"_"+data.id).siblings("#editLink").attr('onclick', action);
           			}else{
           				/*--------- New Comment ---------*/
           				window.location.reload();	
           			}
           		}else{
           			window.location.reload();
           		}
               $("#myModalComment").hide();
           	}, 
      			error: function (xhr, ajaxOptions, thrownError){
      				$("#myModalComment").hide();
      			}
         });
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


function next_step(id,stage,interviewers_names,inviewer_dates)
{
 $("#myModal_n").show()
  $("#scheds_id").val(id)
  $("#stage").val(stage)
  $("#interviewer_names").val(interviewers_names)
  $("#add_interview_dates").attr("data-id",$(".avail_date").length)
  if(Object.keys(inviewer_dates).length > 1)
  {
    UpdateDate(inviewer_dates)
  }
}


function show(id,comment_id,result)
{
  $("#myModalComment").show()
  // modal.style.display = "block";
  $("#sched_id").val(id)
  $("#comment_id").val(comment_id)
  $(".result").val(result)
}


function UpdateDate(dates)
{
  var count = 1
  for (var key in dates){
    val = count++
    DateSetup(dates,key,val)
  $("#add_interview_dates").attr("data-id",val)
  }
 
}

function meeting_with(id,result)
{

  $("#myModalMeeting").show()
  $("#review_id").val(id)
  $("#meeting").val(result)
}
