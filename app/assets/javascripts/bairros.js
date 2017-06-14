$(function() {
  var loadingHTML = "<div class='loading'>Loading...</div>";

  $(document.body).off('click', 'nav.pagination a');

  $(document.body).on('click', 'nav.pagination a', function(e) {
    e.preventDefault();
    var url = $(this).attr('href');
    $("#bairros").html(loadingHTML).load(url, function(){
      window.history.pushState(url, window.title, url);
    });
    return false;
  });

  $(window).bind('popstate', function(event) {
    var url = location.href;
    $("#books_container").html(loadingHTML).load(url);
  });

  
});