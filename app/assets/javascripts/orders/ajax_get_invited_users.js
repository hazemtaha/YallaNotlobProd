$(function(){
  var invitedUsers = function(e) {
      var orderId = $('#order_item_order_id').val();
      $.ajax({
          url: "/orders/"+orderId+"/invited_users",
          method: 'get',
          success: function(response) {
              console.log(response);
              $('.modal-body').empty();
              $.each(response,function(key,value){
                $('.modal-body').append(
                  $('<div/>')
                    .addClass("col-xs-3 col-sm-3 col-md-3 col-lg-3")
                    .append(
                      $('<div/>')
                        .addClass('thumbnail')
                        .append(
                          $('<img/>')
                            .attr('src',value.image.url)
                        ).append(
                          $('<div/>')
                            .addClass("caption")
                            .append(
                              $('<h3/>')
                                .addClass('text-info')
                                .text(value.username.toUpperCase())
                            )
                        )
                    )
                )
              });
              $('.modal-body').append($('<br/>'))
              // window.location.href = window.location.href;
              // $(e.target).parent().remove();
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
  $('#invited').click(invitedUsers);
});
