var detectReplyInputFocusedHash = {};

$(document).ready( function() {
    $("input[name='subject[hashtag_id]']").val($("#select_hashtag option:selected").val());
    $("#select_hashtag").change(function() {
        $("input[name='subject[hashtag_id]']").val($("#select_hashtag option:selected").val());
    });

    // comment의 답글 ui를 컨트롤 하기 위한 메서드
    detectReplyInputFocused();
    initUIEvents();
    ///////////////////////////////////////

    //평가를 저장하기 위한 메서드
    submitValue();

    //댓글을 저장하기 위한 메서드
    submitComment();

    //답글을 저장하기 위한 메서드
    submitReply();

    initDropzone();
});

function initUIEvents() {
    $(".comment").unbind().click(function(){
        var currentComment = $(this).data("commentid");
        $("#commentactions-" + currentComment).slideDown("fast");
    });


    $(".commentLi").hover(function(){
        var currentComment = $(this).data("commentid");
        $("#comment-" + currentComment).stop().animate({opacity: "1", backgroundColor: "#f8f8f8", borderLeftWidth: "4px"},{duration: 100, complete: function() {}} );

    }, function () {
        var currentComment = $(this).data("commentid");

        if($('#reply-text-' + currentComment).val().length == 0 && (detectReplyInputFocusedHash[currentComment] == null || detectReplyInputFocusedHash[currentComment] != "focused")) {
            $("#comment-" + currentComment).stop().animate({opacity: "1", backgroundColor: "#fff", borderLeftWidth: "1px"},{duration: 100, complete: function() {}} );
            $("#commentactions-" + currentComment).slideUp("fast");
        }
    });
}

function detectReplyInputFocused() {
    $('input[id^="reply-text-"]').focusin(function() {
        detectReplyInputFocusedHash[$(this).data("commentid")] = "focused";
    });

    $('input[id^="reply-text-"]').focusout(function() {
        var currentComment = $(this).data("commentid");

        delete detectReplyInputFocusedHash[currentComment];

        if ($(this).val().length == 0) {
            $("#comment-" + currentComment).stop().animate({opacity: "1", backgroundColor: "#fff", borderLeftWidth: "1px"},{duration: 100, complete: function() {}} );
            $("#commentactions-" + currentComment).slideUp("fast");
        }
    });
}

function submitValue() {
    $("#submit-subject-value").click(function() {
        var userId = $("#textarea-user-id").val();

        if(userId == null || userId.length == 0) {
            alert("로그인 후 입력할 수 있습니다.");
            return;
        }

        var inputValue = $("#input-subject-value").val();

        if(isNaturalNumber(inputValue)) {
            var data_params = "valuation[subject_id]=" + $("#textarea-subject-id").val()
                            + "&valuation[user_id]=" + userId
                            + "&valuation[user_nickname]=" + $("#textarea-user-nickname").val()
                            + "&valuation[price]=" + inputValue;

            $.ajax({
                url: '/valuations',
                type: 'POST',
                data: data_params,
                success: function() {
                    location.reload();
                },
                error: function(e) {
                    alert('평가에 실패했습니다.');
                }
            });
        }
    });
}

function isNaturalNumber(str) {
    var n = Math.floor(Number(str));
    return String(n) === str && n >= 0;
}

function submitComment() {
    $("#sendMessageButton").click(function() {
        var commentValue = $("#commentText").val();

        if (commentValue.length == 0) {
            alert("댓글을 입력하세요.");
        } else {
            //async 하게 또는 sync하게 댓글 저장하는 로직

            var userValue = $("#textarea-user-value").val();

            if(userValue == null) {
                alert("평가 후 댓글을 달 수 있습니다.");
            } else {
                postComment(commentValue, null);
            }
        }
    });
}

function submitReply() {
    $('button[id^="reply-to"]').click(function(){
        var currentComment = $(this).data("commentid");
        var replyValue = $('#reply-text-' + currentComment).val();

        if (replyValue.length == 0) {
            alert("답글을 입력하세요.");
        } else {
            postComment(replyValue, currentComment);
        }
    });
}

function postComment(contents, parentCommentId) {
    var userId = $("#textarea-user-id").val();

    if(userId == null || userId.length == 0) {
        alert("로그인 후 입력할 수 있습니다.");
        return;
    }

    var userValue = $("#textarea-user-value").val();

    if(userValue == null || userValue.length == 0) {
        if(parentCommentId == null) {
            alert("평가 후 댓글을 달 수 있습니다.");
        } else {
            alert("평가 후 답글을 달 수 있습니다.");
        }
    } else {
        var userNickname = $("#textarea-user-nickname").val();
        var data_params = "comment[user_id]=" + userId + "&comment[contents]=" + contents + "&comment[user_nickname]=" + userNickname;

        if (parentCommentId == null) {
            data_params += "&comment[subject_id]=" + $("#textarea-subject-id").val();
        } else {
            data_params += "&comment[parent_id]=" + parentCommentId;
        }

        $.ajax({
            url: '/comments',
            type: 'POST',
            data: data_params,
            success: function() {
                location.reload();
            },
            error: function(e) {
                alert('작성에 실패했습니다.');
            }
        });
    }
}

function initDropzone() {
    Dropzone.options.subjectForm = {
        autoProcessQueue: false,
        dictDefaultMessage: "파일을 끌어다 놓으시거나 클릭하세요.",
        uploadMultiple: true,
        parallelUploads: 100,
        maxFiles: 100,
        addRemoveLinks : true,
        paramName: 'subject_attachments[]',
        dictRemoveFile: '파일 삭제',

        // previewTemplate: document.querySelector('#preview-template').innerHTML,
        // thumbnailHeight: 120,
        // thumbnailWidth: 120,

        // createImageThumbnails: true

        // The setting up of the dropzone
        init: function() {
            var myDropzone = this;

            // this.on("addedfile", function(file) {
            //
            //     // Create the remove button
            //     var removeButton = Dropzone.createElement("<button>Remove file</button>");
            //
            //     // Capture the Dropzone instance as closure.
            //     var _this = this;
            //
            //     // Listen to the click event
            //     removeButton.addEventListener("click", function(e) {
            //         // Make sure the button click doesn't submit the form:
            //         e.preventDefault();
            //         e.stopPropagation();
            //
            //         // Remove the file preview.
            //         _this.removeFile(file);
            //         // If you want to the delete the file on the server as well,
            //         // you can do the AJAX request here.
            //     });
            //
            //     // Add the button to the file preview element.
            //     file.previewElement.appendChild(removeButton);
            //
            //     // $(".dz-details").on("click", function(e) {
            //     //    e.preventDefault();
            //     //    e.stopPropagation();
            //     //
            //     //    _this.removeFile(file);
            //     // });
            // });

            // First change the button to actually tell Dropzone to process the queue.
            this.element.querySelector("input[type=submit]").addEventListener("click", function(e) {
                // Make sure that the form isn't actually being sent.
                // console.log($("input[name='subject_attachments[content][]'")[0].files);
                e.preventDefault();
                e.stopPropagation();
                myDropzone.processQueue();
            });

            // this.on("complete", function (file) {
            //     if (this.getUploadingFiles().length === 0 && this.getQueuedFiles().length === 0) {
            //         // show 로 가거나, 목록으로 가거나인데 show 로 가야할듯.
            //
            //     }
            // });

            // Listen to the sendingmultiple event. In this case, it's the sendingmultiple event instead
            // of the sending event because uploadMultiple is set to true.
            // this.on("sendingmultiple", function() {
            //     // Gets triggered when the form is actually being sent.
            //     // Hide the success button or the complete form.
            // });
            // this.on("successmultiple", function(files, response) {
            //     // Gets triggered when the files have successfully been sent.
            //     // Redirect user or notify of success.
            // });
            // this.on("errormultiple", function(files, response) {
            //     // Gets triggered when there was an error sending the files.
            //     // Maybe show form again, and notify user of error
            // });
        },

        success: function(file, response) {
            var redirect_url = response["redirect"];
            if (redirect_url == null || redirect_url.length == 0) {
                redirect_url = "http://localhost:5000"
            }
            window.location.replace(redirect_url);
        },

        error: function(file, errorMessage) {
            console.log(errorMessage);
        }
    }
}