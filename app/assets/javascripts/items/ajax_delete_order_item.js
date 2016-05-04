$(function(){
  var deleteItem = function(e) {
      var idAttr = $(e.target).attr('id');
      var itmId = idAttr.substr(10, idAttr.length - 1);
      var orderId = $('#order_item_order_id').val();
      $.ajax({
          url: "/orders/"+orderId+"/items/"+itmId,
          method: 'DELETE',
          success: function(response) {
              // console.log(response);
              // window.location.href = window.location.href;
              $(e.target).parent().remove();
          },
          error: function(xmlHttpRequestObj, status, error) {
              // console.log(error);
          },
          complete: function(xmlHttpRequestObj) {
              // console.log("complete");
          },
          // dataType: 'json',
          async: true
      });
  }
  $('.delete-item').click(deleteItem);
});
