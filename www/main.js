$(document).ready(function() {
  $('#source').on('keyup change', function() {
    try {
      console.log(_parser.parse($(this).val()));
    } catch (e) {
      console.log(e);
    }
  });
});