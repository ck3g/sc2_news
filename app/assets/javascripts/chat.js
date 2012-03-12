$(function(){
    var firstTime = true;
    (function loadChatMessages() {
        $(".chat-messages").load("/chat_messages", function(){
            if (firstTime) {
                $(this).prop({ scrollTop: $(this).prop("scrollHeight") });
                firstTime = false;
            }
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