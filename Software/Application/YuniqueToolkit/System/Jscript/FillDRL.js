function FillDRL(controllName, data) {
    var hiddenFieldName = controllName.replace("drl", "hdn");
    var selectedVal = $('#' + hiddenFieldName).val();

    var listOfOptions = ''
    var selectedElem = 0;
    var currentText = '';
    var currentValue = '';

    //    $(data).each(function (i, item) {
    //        if (item.V == selectedVal) {
    //            selectedElem = i;
    //        }

    //        currentText = item.T;
    //        if (currentText == null || currentText == 'null') {
    //            currentText = '';
    //        }

    //        listOfOptions += "<option value='" + item.V + "'>" + currentText + "</option>"
    //    })

    //    $('#' + controllName).append(listOfOptions).find('option').eq(selectedElem).prop('selected', 'selected');

    var select = document.getElementById(controllName);
    var foundBlank = false;

    if (select != null) {
        $(data).each(function (i, item) {
            if (item.V == selectedVal) {
                selectedElem = i;
            }

            currentText = item.T;
            if (currentText == null || currentText == 'null') {
                currentText = '';
            }

            currentValue = item.V;
            if (currentValue == null || currentValue == 'null') {
                currentValue = '';
            }

            if (currentText == '' && currentValue == '') {
                foundBlank = true;
            }
            else {
                listOfOptions += "<option value='" + currentValue + "'>" + currentText + "</option>"
            }
        })

        if (!foundBlank) {
            $('#' + controllName).empty();
        }
        $('#' + controllName).append(listOfOptions).find('option').eq(selectedElem).prop('selected', 'selected');
    }
};
