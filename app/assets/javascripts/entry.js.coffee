entries = ->
  $('#preview-button').on 'click', (e) ->
    $('#preview-body').val( $('#entry_body').val() )
    $('#preview-form').submit()

$(document).ready(entries)
$(document).on('page:load', entries)