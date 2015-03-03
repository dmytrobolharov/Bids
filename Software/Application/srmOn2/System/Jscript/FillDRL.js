function FillDRL(controllName, data) {
    //var hiddenFieldName = controllName.replace("drl", "ddd");
    var hiddenFieldName = controllName.replace("drl", "hdn");
    var selectedVal = $('#' + hiddenFieldName).val();

    var listOfOptions = ''
    var selectedElem = 0;
    var currentValue = '';
    $(data).each(function (i, item) {
        if (item.V == selectedVal) {
            selectedElem = i;
        }

        currentText = item.T;
        if (currentText == null || currentText == 'null') {
            currentText = '';
        }

        listOfOptions += "<option value='" + item.V + "'>" + currentText + "</option>"
    })

    $('#' + controllName).append(listOfOptions).find('option').eq(selectedElem).prop('selected', 'selected');
};
