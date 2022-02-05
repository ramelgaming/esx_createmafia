$(function() {
    function display(bool) {
        if (bool) {
            $("body").fadeIn(500);
        } else {
            $("body").fadeOut(0);
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;


        $("#mafiaxp").html("Experience " + item.experience + " /")
        $("#gangxp").html("Experience " + item.experience + " /")
        $("#cartelxp").html("Experience " + item.experience + " /")
        $("#familyrankup").html("Family RankUp: " + item.familyrankup + " XP")
        $("#familycargo").html(item.familytype + " Cargo")
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })




    document.onkeyup = function(data) {
        if (data.which == 27) {
            $.post('http://rc_moneyWash/exit', JSON.stringify({}));
            return
        }
    };
    $("#close").click(function() {
        $.post('http://rc_moneyWash/exit', JSON.stringify({}));
        return
    })



})
$(function() {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
            var item = event.data;
            if (item.type === "ui") {
                if (item.status == true) {
                    display(true)
                } else {
                    display(false)
                }
            }
        })
        // if the person uses the escape key, it will exit the resource
    document.onkeyup = function(data) {
        if (data.which == 27) {
            $.post('http://esx_createmafia/exit', JSON.stringify({}));
            return
        }
    };
    $("#close").click(function() {
        $.post('http://esx_createmafia/exit', JSON.stringify({}));
        return
    })
    $("#closegang").click(function() {
        $("#gangwindow").fadeOut(0)
        $("#container").delay(0).fadeIn(0)
        return
    })
    $("#submitgang").click(function() {
        let inputValue = $("#inputgang").val()
        if (inputValue.length >= 30) {
            return
        } else if (!inputValue) {
            return
        }
        $.post('http://esx_createmafia/gangmake', JSON.stringify({
            text: inputValue,
        }));
        $.post('http://esx_createmafia/exit', JSON.stringify({}));
        return;
    })
    $("#closemafia").click(function() {
        $("#mafiawindow").fadeOut(0)
        $("#container").delay(0).fadeIn(0)
        return
    })
    $("#submitmafia").click(function() {
        let inputValue = $("#inputmafia").val()
        if (inputValue.length >= 30) {
            return
        } else if (!inputValue) {
            return
        }
        $.post('http://esx_createmafia/mafiamake', JSON.stringify({
            text: inputValue,
        }));
        $.post('http://esx_createmafia/exit', JSON.stringify({}));
        return;
    })

    $("#closecartel").click(function() {
        $("#cartelwindow").fadeOut(0)
        $("#container").delay(0).fadeIn(0)
        return
    })
    $("#submitcartel").click(function() {
        let inputValue = $("#inputcartel").val()
        if (inputValue.length >= 30) {
            return
        } else if (!inputValue) {
            return
        }
        $.post('http://esx_createmafia/cartelmake', JSON.stringify({
            text: inputValue,
        }));
        $.post('http://esx_createmafia/exit', JSON.stringify({}));
        return;
    })
})