//turbolinks를 사용할 때는 $(document).ready 로 자바스크립트 로드가 잘 안되므로, $(document).on("turbolinks:load") 로 사용해야 한다.
//turbolinks 는 아마도.. 웹 캐싱하는 라이브러리인듯 싶다.
$(document).on("turbolinks:load", function() {
    $("a[name=selected_hashtag]").click(function() {
        $("#selected_hashtag_hidden_field").val($(this).attr("value"));
    });
});

