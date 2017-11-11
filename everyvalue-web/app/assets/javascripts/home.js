//turbolinks를 사용할 때는 $(document).ready 로 자바스크립트 로드가 잘 안되므로, $(document).on("turbolinks:load") 로 사용해야 한다.
//turbolinks 는 아마도.. 웹 캐싱하는 라이브러리인듯 싶다.
$(document).ready(function() {
    var hashtag_id = $.urlParam('hashtag_id');

    if (hashtag_id != null) {
        $("#selected_hashtag_hidden").val(hashtag_id);
        $("li[name=selected_hashtag]").removeClass("active");
        $("#selected_hashtag_" + hashtag_id).addClass("active");
    } else {
        $("li[name=selected_hashtag]").removeClass("active");
        $("#selected_hashtag_0").addClass("active");
    }

    $(".subject_search_select").change(function() {
        if($(".subject_search_select option:selected").val() ==  "user_nickname") {
            $(".subject_search_predicate_select option").filter('[value=eq]').attr("selected", true);
            $(".subject_search_predicate_select option").filter('[value=cont]').attr("selected", false);
        } else {
            $(".subject_search_predicate_select option").filter('[value=cont]').attr("selected", true);
            $(".subject_search_predicate_select option").filter('[value=eq]').attr("selected", false);
        }
    });
});

