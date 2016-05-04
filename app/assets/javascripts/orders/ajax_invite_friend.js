$(function() {
    $('#invite_friend').autocomplete({
        type: "POST",
        serviceUrl: '/users/lookup/',
        // if no suggestion available
        showNoSuggestionNotice: true,
        noSuggestionNotice: 'Sorry, no matching results',
        // triggered before ajax request and add invited groups/users ids to params object to send them to server for checking
        onSearchStart: function(params) {
            var invited_friends = [];
            var invited_groups = [];
            // loop over all hidden inputs containing the ids for invited users
            $('.invited').each(function(index) {
                invited_friends.push($(this).val());
            });
            // loop over all hidden inputs containing the ids for invited groups
            $('.group-invited').each(function(index) {
                invited_groups.push($(this).val());
            });
            params.invited = invited_friends;
            params.groups_invited = invited_groups;
        },
        // triggered when user select a suggestion
        onSelect: function(suggestion) {
            // if user selected a group
            if (suggestion.data.members) {
              // add hidden input with group id
                $('#groups-area').append('<input class="group-invited" type="hidden" name="group_invited[]" value="' + suggestion.data.id + '">');
                // append to the invited friends area all the friends inside this group
                $.each(suggestion.data.members, function(key, value) {
                    $('#invites-area').append('<input class="invited" type="hidden" name="invited[]" value="' + value.id + '">');
                    $('#friends-invited').append(
                        $('<div/>')
                        .addClass("panel panel-default")
                        .append($('<div/>')
                            .addClass("panel-heading")
                            .text(value.username.toUpperCase())
                            .append($('<span/>')
                                .addClass('btn glyphicon glyphicon-remove col-sm-push-9')
                                .attr("id", value.id)
                            )
                        )
                    );
                    // add click listener for the remove
                    $("#" + value.id).click(function(e) {
                        $(e.target).parent().parent().remove();
                        $('.invited[value = "' + value.id + '"]').remove();
                    });
                });
                // if user selected a user
            } else {

                $('#invites-area').append('<input class="invited" type="hidden" name="invited[]" value="' + suggestion.data.id + '">');
                $('#friends-invited').append(
                    $('<div/>')
                    .addClass("panel panel-default")
                    .append($('<div/>')
                        .addClass("panel-heading")
                        .text(suggestion.value.toUpperCase())
                        .append($('<span/>')
                            .addClass('btn glyphicon glyphicon-remove col-sm-push-9')
                            .attr("id", suggestion.data.id)
                        )
                    )
                );
                $("#" + suggestion.data.id).click(function(e) {
                    $(e.target).parent().parent().remove();
                    $('.invited[value = "' + suggestion.data.id + '"]').remove();
                });
            }
            $('#invite_friend').val("");
        }
    });
});
