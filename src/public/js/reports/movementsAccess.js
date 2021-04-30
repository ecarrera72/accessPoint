document.addEventListener( 'DOMContentLoaded', () => {
    let confiDatepicker = {
        formatter: (input, date, instance) => { input.value = strftime('%d-%m-%Y', date)},
        customMonths: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
        customDays: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa'],
        dateSelected: new Date()
    }

    datepicker('#toDatePicker', confiDatepicker);
    datepicker('#fromDatePicker', confiDatepicker);

    let from = document.getElementById('fromDatePicker');
    let to = document.getElementById('toDatePicker');
    let filter = document.getElementById('btnFilter');
    let clean = document.getElementById('btnClean');

    filter.addEventListener( 'click', () => {
        $('#tbl').bootstrapTable('refresh');
    });

    clean.addEventListener( 'click', () => {
        from.value = '';
        to.value = '';
        $('#tbl').bootstrapTable('refresh');
    });
});

function queryParams(params) {
    params.fromDate = $('#fromDatePicker').val();
    params.toDate = $('#toDatePicker').val();
    return params
}