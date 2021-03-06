// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
// require_tree . 을 추가하지 않았기 때문에 javascript 파일이 추가되면 일일이 밑에 추가해줘야 한다.
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap-sprockets
//= require bootstrap-select.min
//= require fileinput.min
//= require home
//= require root
//= require subjects

// how to disable turbolinks https://stackoverflow.com/questions/38649550/how-to-disable-turbolinks-in-rails-5
// require turbolinks

$.urlParam = function(name){
    var results = new RegExp('[\?&]' + name + '=([^]*)').exec(window.location.href);
    if (results == null){
        return null;
    }
    else{
        return results[1] || 0;
    }
}