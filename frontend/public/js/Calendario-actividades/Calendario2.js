$(document).ready(function() {

    var date = new Date();
    var yyyy = date.getFullYear().toString();
    var mm = (date.getMonth()+1).toString().length == 1 ? "0"+(date.getMonth()+1).toString() : (date.getMonth()+1).toString();
    var dd  = (date.getDate()).toString().length == 1 ? "0"+(date.getDate()).toString() : (date.getDate()).toString();
    
    $('#calendar').fullCalendar({
        header: {
            language: 'es',
            left: 'prev,next today',
            center: 'title',
            right: 'month,basicWeek,basicDay',
        },
        defaultDate: yyyy+"-"+mm+"-"+dd,
        editable: true,
        eventLimit: true, // allow "more" link when too many events
        selectable: true,
        selectHelper: true,
        select: function(start, end) {
            $('#ModalAdd #start').val(moment(start).format('YYYY-MM-DD HH:mm:ss'));
            $('#ModalAdd #end').val(moment(end).format('YYYY-MM-DD HH:mm:ss'));
            $('#ModalAdd').modal('show');
        },
        eventRender: function(event, element) {
            element.bind('click', function() {
                console.log("Se selecciono solo un evento:",event);
                $('#ModalEdit #id').val(event.id);
                $('#ModalEdit #title').val(event.title);
                $('#ModalEdit #color').val(event.color);
                $('#ModalEdit').modal('show');
            });
        },
        dayClick: function(date, allDay, jsEvent, view) {
            if(!allDay) {
                // strip time information
                date = new Date(date.getFullYear(), date.getMonth(), date.getDay());
            }
            document.getElementById("actividadFecha").innerHTML="<option value='' selected disabled>Seleccione la actividad:</option>";
            $('#calendar').fullCalendar('clientEvents', function(event) {
                if(event.start <= date && event.end >= date) {
                    console.log("Se selecciono todo el dia:",event.length,event);
                    document.getElementById("actividadFecha").innerHTML+=`<option value="a">${event.title}</option>`;
                    return true;
                }
                return false;
            });
        },
        events: obj
    });
});