$(document).ready(function(){


  function formatRepo (repo) {
    if (repo.loading) return repo.text;

    var markup = '<div class="clearfix">' +
    '<div class="col-sm-1">' +
    '</div>' +
    '<div clas="col-sm-10">' +
    '<div class="clearfix">' +
    '<div class="col-sm-6">' + repo.nome + '</div>' +
    '<div class="col-sm-3"><i class="fa fa-code-fork"></i> ' + repo.nome + '</div>' +
    '<div class="col-sm-2"><i class="fa fa-star"></i> ' + repo.nome + '</div>' +
    '</div>';

    if (repo.description) {
      markup += '<div>' + repo.nome + '</div>';
    }
    markup += '</div></div>';
    return markup;
  }

  function formatRepoSelection (repo) {
    return repo.nome || repo.text;
  }


  
  $('#municipios').select2({

    ajax: {
    url: "/municipios.json?select2_trigger=true",
    dataType: 'json',
    delay: 250,
    data: function (params) {
      return {
        q: params.term, // search term
        page: params.page
      };
    },
    processResults: function (data, params) {
      // parse the results into the format expected by Select2
      // since we are using custom formatting functions we do not need to
      // alter the remote JSON data, except to indicate that infinite
      // scrolling can be used
      params.page = params.page || 1;
      console.log(data.municipios)
      return {
        results: data.municipios,
        pagination: {
          more: (params.page * 30) < data.total_count
        }
      };
    },
    cache: true
  },
  escapeMarkup: function (markup) { return markup; }, // let our custom formatter work
  minimumInputLength: 1,
  templateResult: formatRepo, // omitted for brevity, see the source of this page
  templateSelection: formatRepoSelection // omitted for brevity, see the source of this page

  });
});







































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
