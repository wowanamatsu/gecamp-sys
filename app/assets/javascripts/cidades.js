$(function() {
  var loadingHTML = "\
  <div class='box box-success'>\
            <div class='box-header'>\
              <h1 class='box-title'>GecampSYS</h1>\
            </div>\
            <div class='box-body'>\
              Carregando os dados do sistema\
            </div>\
            <div class='overlay'>\
              <i class='fa fa-refresh fa-spin'></i>\
            </div>\
          </div>\
        </div>\
  ";

  $(document.body).off('click', 'nav.pagination a');

  $(document.body).on('click', 'nav.pagination a', function(e) {
    e.preventDefault();
    var url = $(this).attr('href');
    $("#cidades").html(loadingHTML).load(url, function(){
      window.history.pushState(url, window.title, url);
    });
    return false;
  });

  $(window).bind('popstate', function(event) {
    var url = location.href;
    $("#books_container").html(loadingHTML).load(url);
  });

  
});