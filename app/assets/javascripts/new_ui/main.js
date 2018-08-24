alertify.set('notifier', 'position', 'top-right');

$(function () {
  $("a.jobs-action").on('click', function (event) {
    event.preventDefault();
    if (this.href.indexOf('close_job') > 0) {
      if (confirm("Are you sure you want to close this Job.")) {
        updateTheJob(this);
      }
    } else {
      updateTheJob(this);
    }
    return false;
  })
});

function token() {
  return $("meta[name='csrf-token']").attr("content");
}


function saveComment(form) {
  $("#btnSaveComment").prop('disabled', true);
  $("#btnSaveComment").text('Saving...');
  $.ajax({
    type: form.method,
    url: form.action,
    data: $("#commentForm").serialize(),
    dataType: "json",
    success: function (data, textStatus, xhr) {
      if (textStatus == "success") {
        action = "show('" + data.interview_schedule_id + "','" + data.interview_schedule_id + "','" + data.comment + "')";
        if ($("#comment_" + data.interview_schedule_id + "_" + data.id).length) {
          /*--------- Edit Comment ---------*/
          $("#comment_" + data.interview_schedule_id + "_" + data.id).text(data.comment);
          $("#comment_" + data.interview_schedule_id + "_" + data.id).siblings("#editLink").attr('onclick', action);
        } else {
          /*--------- New Comment ---------*/
          window.location.reload();
        }
      } else {
        window.location.reload();
      }
      $("#btnSaveComment").prop('disabled', false);
      $("#myModalComment").hide();
      $("#btnSaveComment").text('Submit');
    },
    error: function (xhr, ajaxOptions, thrownError) {
      $("#btnSaveComment").prop('disabled', false);
      $("#myModalComment").hide();
      $("#btnSaveComment").text('Submit');
    }
  });
}

function updateTheJob(e) {
  $.ajax({
    type: "post",
    url: e.href,
    data: {
      'authenticity_token': token()
    },
    cache: false,
    success: function (data, textStatus, xhr) {
      if (textStatus == "success") {
        setJobStatusUrl(data);
      } else {
        alertify.error("Unable to Update the job.");
      }
    },
    error: function (xhr, ajaxOptions, thrownError) {

    }
  });
}

function setJobStatusUrl(obj) {
  var jobelement = $("#job_" + obj.id);
  if (obj.status == "open") {
    jobelement.attr('href', jobelement.attr('href').replace("open_job", "close_job"));
    jobelement.text("Close the job");
    alertify.success(obj.title + " " + obj.status + " " + "Successfully!");
  } else if (obj.status == "closed") {
    jobelement.attr('href', jobelement.attr('href').replace("close_job", "open_job"));
    jobelement.text("Open the job");
    alertify.warning(obj.title + " " + obj.status + " " + "Successfully!");
  }
  $("a#options").click();
}


function next_step(id, stage, interviewers_names, inviewer_dates, interview_id, field,user_id) {
  console.log(inviewer_dates);
  $('#interview-round-submit-button').val('Submit');
  //$("#myModal_n").show()
  if (field == 'all fields') {
    $('.stage-field').show();
    $('.interviewer-names-field').show();
    $('#date1').show();
  } else if (field == 'interviewer') {
    $('.stage-field').hide();
    $('.interviewer-names-field').show();
    $('#date1').hide();
  } else if (field == 'date') {
    $('.stage-field').hide();
    $('.interviewer-names-field').hide();
    $('#date1').show();
  }
  $("#interview_id").val(interview_id)
  $("#scheds_id").val(id)
  $("#stage").val(stage)
  $("#interviewer_names option[value='+interviewers_names+']").attr('selected','selected');
  $("#interview_avail_date1").val(inviewer_dates)
  $("#user_id").val(user_id)
  //$("#add_interview_dates").attr("data-id", $(".avail_date").length)
  // && Object.keys(inviewer_dates).length > 1
//  if (typeof inviewer_dates !== "undefined" && Object.keys(inviewer_dates).length > 1) {
//    UpdateDate(inviewer_dates)
//  }
}


function show(id, comment_id, result) {
  $("#myModalComment").show()
  // modal.style.display = "block";
  $("#sched_id").val(id)
  $("#comment_id").val(comment_id)
  $(".result").val(result)
}


function UpdateDate(dates) {
  console.log(dates);
  var count = 1
  for (var key in dates) {
    //val = count++ for now keep it equal to 1
    val = count;
    DateSetup(dates, key, val)
    $("#add_interview_dates").attr("data-id", val)
  }

}

function meeting_with(id, result) {

  $("#myModalMeeting").show()
  $("#review_id").val(id)
  $("#meeting").val(result)
}

function showJobDetails(jobId) {
  $("#job-description, #job-title").html('');
  $("#job-title").html($('#job-title-' + jobId).html());
  $("#job-industry").html($("#job-" + jobId + "-industry").val());
  $("#job-description").html($("#job-discription-" + jobId).val());
  $("#jobDetialsModel").show();
}

function setCommentDetails(element) {
  var review = $(element).data('review');
  if(review == '1'){
    $('#comment-heading').text('Pre Screen Note');
    $('#comment').attr('placeholder','Pre Screen Note');
  }
  else{
    $('#comment-heading').text('Comment');
    $('#comment').attr('placeholder','Comment');
  }
  $('#sched_id').val($(element).data('schedule_id'));
  $('#comment').val($(element).data('comment'));
  $('#comment_id').val($(element).data('comment-id'));
}

function setPreScreenNoteDetails(element) {
  $('#p_interview_id').val($(element).data('interview-id'));
  console.log($(element).data('interview-id'));
  $('#note').val($(element).data('note'));
  $('#note_id').val($(element).data('note-id'));
  $('#p_user_id').val($(element).data('user-id'));
}

function setFeedbackDetails(element) {
  $('#schedule_id').val($(element).data('schedule_id'));
  $('#feedback').val($(element).data('feedback'));
  $('#feedback_id').val($(element).data('feedback-id'));
}

function showAddScheduleButton(id, stage, last_stage, interview_total_stage) {
  stage = parseInt(stage);
  last_stage = parseInt(last_stage);
  interview_total_stage = parseInt(interview_total_stage);
  if (stage == last_stage) {
    if (stage !== interview_total_stage) {
      $(".add-schedule-button-" + id).show();
    }
  }
}

function populateInterviewSchedulePopUp(element) {
  var job_id = $(element).data('job');
  var user_id = $(element).data('user-id');
  url = "/interview_schedules/populate_interview_schedule_popup?job_id=" + job_id;
  $.ajax({
    url: url,
    type: "GET",
    dataType: "script",
    data: {
      user_id: user_id
    }
  });
}

function candidateInterviewSchedulePopUp(element) {
  var job_id = $(element).data('job');
  url = "/interview_schedules/candidate_interview_schedule_popup?job_id=" + job_id;
  $.ajax({
    url: url,
    type: "GET",
    dataType: "script"
  });
}

function showAssignJobPopup(element) {
  var job_id = $(element).data('job');
  url = "/jobs/"+job_id+"/assign_jobs/new";
  $.ajax({
    url: url,
    type: "GET",
    dataType: "script"
  });
}

function changeSubmittingText(element){
  $(element).val('Submitting...');
}
