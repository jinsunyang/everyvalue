$(document).ready(function($) {
    $(".subject-clickable-row").click(function() {
        window.location = $(this).data("href");
    });
});

