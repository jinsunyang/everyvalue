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

    //wysiwyg 초기화 (summernote)
    initSubjectContentsWysiwyg();
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

function initSubjectContentsWysiwyg() {
    $('#subject_contents').summernote({
        toolbar: [
            ['style', ['style']],
            ['font', ['bold', 'italic', 'underline', 'strikethrough', 'clear']],
            // ['fontname', ['fontname']],
            ['fontsize', ['fontsize']],
            ['color', ['color']],
            ['para', ['ul', 'ol', 'paragraph']],
            // ['height', ['height']],
            ['table', ['table']],
            ['insert', ['link', 'picture', 'video', 'hr']]
        ],
        height: 500,
        lang : 'ko-KR',
        callbacks: {
            onImageUpload: function(files) {
                console.log(files);
                Array.from(files).forEach(file => {
                    sendFile(file);
                });
            },
            onMediaDelete: function(target) {
                console.log("testtesttest");
                console.log(target);
                console.log(target[0].src)
                // deleteFile(target[0].src);
                // sendFile에서 success 했을 때 img tag에 data-id 로 id를 넣어두고 delete할 때 해당 id 로 activerecord destory 하면서 upload 되었던 파일도 삭제한다.
                // 사실 나중에 구현할 배치로 커버되는 작업이어서 일단은 패스해도 된다.
            }
        }

    });

    // $('.note-editable').css('font-size','14px');

    function sendFile(file) {
        data = new FormData();
        data.append("subject_attachment[content]", file);
        $.ajax({
            data: data,
            type: "POST",
            url: $('#subject_contents').data().uploadUrl,
            cache: false,
            contentType: false,
            processData: false,
            success: function(data, response) {
                // 여기서 subject_attachments id를 subject submit 시에 넘겨줘서 subject_attachments 의 subject_id 에 빈 값이 들어가지 않도록
                // <input type="hidden" name="subject[subject_attachments]" value="542"> 이런식으로 값이 추가되도록
                // wysiwyg 에서 이미지를 지우면 해당 subject에 속했던 subject_attachments의 id도 비워준다.
                insertHiddenInputForSubjectAttachmentId(document.getElementById('subject_attachment_id'), data["content_id"]);

                $('#subject_contents').summernote('insertImage', data["url"]["url"], data["url"]["url"]);
            }
        });
    }
}

function insertHiddenInputForSubjectAttachmentId(parentElement, contentId) {
    var hiddenInput = document.createElement('input');
    hiddenInput.type = 'hidden';
    hiddenInput.name = '[subject_attachments][]';
    hiddenInput.value = contentId;

    parentElement.appendChild(hiddenInput);

    return;
}