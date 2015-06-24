function BOMBOLDisable(BOLorBOM, obj, cType) {
	var objId;
	var optObj;
	if (arrCost.length>0) {
	if (BOLorBOM=='BOL') {
		objId='#' + obj.id.replace('BOL', 'BOM') + ' option';
		$(objId).each( function() {if ($(this).val()!='-1') {$(this).removeAttr("disabled");}});
		if (obj.value!='-1') {
			$(objId).each( function() {
				optObj=$(this);
				if (optObj.val()!='-1') {
					$.each(arrCost[1], function(index, value)
						{
							if (optObj.val().substring(2)==value && arrCost[0][index]==cType && arrCost[2][index]==obj.value.substring(2)) {optObj.attr("disabled","disabled");}
						}
					)
				}
			});
		}
		else {
			$(objId).each( function() {
				if ($(this).val()!='-1') {$(this).removeAttr("disabled");}
			});
		}
	} 
	if (BOLorBOM=='BOM') {
		objId='#' + obj.id.replace('BOM', 'BOL') + ' option';
		$(objId).each( function() {if ($(this).val()!='-1') {$(this).removeAttr("disabled");}});
		if (obj.value!='-1') {
			$(objId).each( function() {
				optObj=$(this);
				if (optObj.val()!='-1') {
					$.each(arrCost[2], function(index, value)
						{
							if (optObj.val().substring(2)==value && arrCost[0][index]==cType && arrCost[1][index]==obj.value.substring(2)) {optObj.attr("disabled","disabled");}
						}
					)
				}
			});
		}
	}
	}
} 