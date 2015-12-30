$(document).ready(function(){
  var entity_select = $("#consultant_entity_attributes_entity_type")
  if ( entity_select.length > 0 ) {
    changeEntitySelect(entity_select);

    $("#consultant_entity_attributes_entity_type").change(function(){
      changeEntitySelect($(this))
    })
  }
})

function changeEntitySelect(entity_select) {
  value = entity_select.val()
  if ( value == "sole_proprietor" || value == "" ) {
    $(".entity-fields").slideUp();
  }
  else {
    $(".entity-fields").slideDown();
  }
}
