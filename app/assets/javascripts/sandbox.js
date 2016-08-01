function ready() {
    //Calculator::
    var total = "";
    var click_value = "";
    var operation = null;
    
    
    $("#clear").click(function() {
        total = "";
        click_value = "";
        operation = null;
        clear();
    });
    
    $(".digit").click(function() {
        if (operation == null) {
            total = total + this.innerHTML;
            write_digit(total);
        }
        else {
            click_value = click_value + this.innerHTML;
            write_digit(click_value);
        }
    });
    
    $("#equal").click(function() {
        total = Number(total);
        click_value = Number(click_value);
        if (operation == "plus") {
            total = total + click_value;
        }
        if (operation == "minus") {
            total = total - click_value;
        }
        if (operation == "times") {
            total = total * click_value;
        }
        if (operation == "divide") {
            total = total / click_value;
        }
        operation = null;
        click_value = "";
        write_digit(total);
    });

    $(".operation").click(function() {
        if (operation == null) {
            //add functionality for strings of operations (5+5+5)
            operation = this.id;
            color_all_default();
            color_red(this.id);
        }
        else {
            total = Number(total);
            click_value = Number(click_value);
            if (operation == "plus") {
                total = total + click_value;
            }
            if (operation == "minus") {
                total = total - click_value;
            }
            if (operation == "times") {
                total = total * click_value;
            }
            if (operation == "divide") {
                total = total / click_value;
            }
            write_digit(total);
            operation = this.id;
            color_all_default();
            color_red(this.id);
            click_value = "";
        }
    });

    $(document).keypress(function(event) {
        var key = String.fromCharCode(event.which);
        if (key == "+")
            document.getElementById("plus").click();
        if (key == "-")
            document.getElementById("minus").click();
        if (key == "x" || key == "*")
            document.getElementById("times").click();
        if (key == "/")
            document.getElementById("divide").click();
        if (key == "0" || key == "1" || key == "2" || key == "3" || key == "4" || key == "5" || key == "6" || key == "7" || key == "8" || key == "9")
            document.getElementById("num_" + key).click();
        if (event.which == 13)
            document.getElementById("equal").click();
        if (key == "c")
            document.getElementById("clear").click();
            
    });








    //practice buttons
    
    $("#mouse_hold").mouseup(function() {
        release_button("indicator");
    });

    $("#mouse_hold").mouseout(function() {
        release_button("indicator");
    });
    

    
    
    //panel indicators +/-
    $(".panel-link").ready(function() {
        var panels = document.getElementsByClassName("panel-link");
        for (var i = 0; i < panels.length; i++) {
            if (i == 0)
                panels[i].innerHTML = "+ " + panels[i].innerHTML;
            else
                panels[i].innerHTML = "- " + panels[i].innerHTML;
        }
        
    });
    $(".panel-link").click(function() {
        var panels = document.getElementsByClassName("panel-link");
        for (var i = 0; i < panels.length; i++) {
            if (panels[i] == this)
                continue;
            panels[i].innerHTML = "- " + panels[i].innerHTML.substr(1);
        }
        if (this.innerHTML[0] == "+")
            this.innerHTML = "- " + this.innerHTML.substr(1);
        else
            this.innerHTML = '+ ' + this.innerHTML.substr(1);
    });


}


function clear() {
    color_all_default();
    document.getElementById("output").innerHTML = "0";
}
function color_all_default() {
    var operations = document.getElementsByClassName("operation");
    for (var i = 0; i < operations.length; i++) {
        operations[i].style.borderColor = "#ffffff";
    }
}

function write_digit(num){
    color_all_default();
    document.getElementById("output").innerHTML = num;
}



function color_blue(id){
    document.getElementById(id).style.color = "#0066ff";
}

function color_red(id) {
    document.getElementById(id).style.borderColor = "#FF0000";
}

function hold_button(id) {
    document.getElementById(id).innerHTML = "Held";
}

function release_button(id) {
    document.getElementById(id).innerHTML = "Released";
}









$(document).ready(function() {
    ready();
});