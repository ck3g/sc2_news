$(function(){

    (function loadChatMessages() {
        $(".chat-messages").load("/chat_messages", function(){
            $(this).attr("scrollTop", $(this).height());
            setTimeout(loadChatMessages, 2000);
        });
    })();




    $(".chat-form-input").on("keypress",function(e){
        var $input = $(this);
        if(e.keyCode == 13) {
            $input.attr("disabled", "disabled");
            $.ajax({
                url: "/chat_messages",
                dataType: "html",
                type: "POST",
                cache: false,
                data: {chat_message: {body: $input.val()}},
                success: function(response) {
                    $(".chat-messages").load("/chat_messages", function(){
                        $input.removeAttr("disabled", "disabled").val("");
                    });
                },
                error: function(response) {
                    $input.removeAttr("disabled", "disabled");
                    console.log(response);
                }
            });
        }
    });
});