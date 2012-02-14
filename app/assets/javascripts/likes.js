$(document).ready(function() {
    $('#friends').change(function() {
        var fr_id = $(this).val();
        $.ajax('http://rguffyat.heroku.com/service/common_connections/likes', {
            type: "POST",
            data: "id=" + fr_id,
            success: function(results) {
                console.log(results);
                $('#friend_name').text(results.friend.first_name);
                var common_items = results.likes.length;
                if(common_items == 0) {
                    $('#num_items').text('nothing');
                }
                else if(common_items == 1) {
                    $('#num_items').text(common_items + ' thing');
                }
                else{
                    $('#num_items').text(common_items + ' things');
                }
                clearList();
                if(common_items != 0) {
                    addItemsToList(results.likes);
                }
                $('.results').show();
            },
            error: function() {
                console.log('ajax error');
            }
        });
    });
});

function addItemsToList(list) {
    for(item in list) {
        $('#common_list').append('<li>' + list[item].name + '</li>');
    }
}

function clearList() {
    $('#common_list li').remove();
}