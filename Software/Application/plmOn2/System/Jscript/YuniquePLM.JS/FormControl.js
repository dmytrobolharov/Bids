;(function($) {
    // common default settings
    var defaults = {
        'appRoot': Yunique.Data.getAppRoot() || '../',
        'identifier': 'FormControl',

        'endpoint': 'Style',
        'table': 'pStyleHeader',
        'callArgs': {
            'StyleID': Yunique.Data.getUrlKey('SID')
        },
        'schemaParams': ['StyleType'],
        'empty': false,
        'backgroundColor': '#ffffff'
    };
    var formModel =
            '<table data-bind="attr: {id: elemIdent(\'_Form\')}" min-height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">' +
            '   <tr>' +
            '       <td data-bind="attr: {width: tblWidth}">' +
            '           <table data-bind="style: {backgroundColor: backgroundColor}" width="100%" border="0" cellspacing="1" cellpadding="0">' +
            '               <tr data-bind="attr: {id: elemIdent(\'_Content\')}, foreach: columns" valign="top">' +
            '                   <td data-bind="attr: {width: $root.columnWidth}">' +
            '                       <table width="100%" border="0" cellspacing="0" cellpadding="1">' +
            '                       <tbody data-bind="foreach: $root.data">' +
            '                       <!-- ko if: column == $parentContext.$index() + 1 -->' +
            '                           <tr>' +
            '                               <td width="125" height="25" class="fontHead" nowrap>' +
            '                                   <span data-bind="text: alias"></span>' +
            '                               </td>' +
            '                           <!-- ko if: type == \'textbox\' -->' +
            '                               <td class="font">' +
            '                                   <input type="text" class="k-textbox" data-bind="attr: {id: $root.elemIdent(\'_txt\' + name), name: $root.elemIdent(\'_txt\' + name)}, style: {width: width}, value: $root.observableVals[$index()]">' +
            '                                   <input type="hidden" data-bind="attr: {name: \'hx_drl\' + name, value: alias}"><input type="hidden" data-bind="attr: {name: \'fx_drl\' + name, value: value}">' +
            '                               </td>' +
            '                           <!-- /ko -->' +
            '                           <!-- ko if: type == \'label\' -->' +
            '                               <td class="font">' +
            '                                   <span data-bind="attr: {id: $root.elemIdent(\'_txt\' + name)}, text: value"></span>' +
            '                               </td>' +
            '                           <!-- /ko -->' +
            '                           <!-- ko if: type == \'dropdownlist\' -->' +
            '                               <td class="font">' +
            //'                                   <input data-bind="attr: {id: $root.elemIdent(\'_drl\' + name)}, kendoDropDownList: {data: $data.lookups, dataTextField: \'value\', dataValueField: \'key\', value: $root.observableVals[$index()], optionLabel: \'Select...\' }, kendoDropDownListWidth: width" />' +
            '                                   <input data-bind="attr: {id: $root.elemIdent(\'_drl\' + name)}, kendoDropDownList: {data: $data.lookups, dataTextField: \'value\', dataValueField: \'key\', value: $root.observableVals[$index()] }, kendoDropDownListWidth: width" />' +
            '                                   <input type="hidden" data-bind="attr: {name: \'hx_drl\' + name, value: alias}"><input type="hidden" data-bind="attr: {name: \'fx_drl\' + name, value: value}">' +
            '                               </td>' +
            '                           <!-- /ko -->' +
            '                           <!-- ko if: type == \'memobox\' -->' +
            '                               <td class="font">' +
            '                                   <textarea class="k-textbox" data-bind="attr: {id: $root.elemIdent(\'_txt\' + name), name: $root.elemIdent(\'_txt\' + name)}, style: {width: width, margin: \'2px 0px\', height: \'52px\'}, value: $root.observableVals[$index()]" rows="4" cols="20"></textarea>' +
            '                                   <input type="hidden" data-bind="attr: {name: \'hx_drl\' + name, value: alias}"><input type="hidden" data-bind="attr: {name: \'fx_drl\' + name, value: value}">' +
            '                               </td>' +
            '                           <!-- /ko -->' +
            '                           <!-- ko if: type == \'checkbox\' -->' +
            '                               <td data-bind="style: {width: width}" class="font">' +
            '                                   <input type="checkbox" data-bind="attr: {id: $root.elemIdent(\'_chk\' + name)}, checked: $root.observableVals[$index()]" />' +
            '                                   <input type="hidden" data-bind="attr: {name: \'hx_drl\' + name, value: alias}"><input type="hidden" data-bind="attr: {name: \'fx_drl\' + name, value: value}">' +
            '                               </td>' +
            '                           <!-- /ko -->' +
            '                           <!-- ko if: type == \'calendarbox\' -->' +
            '                               <td data-bind="style: {width: width}" class="font">' +
            '                                   <input data-bind="attr: {id: $root.elemIdent(\'_txt\' + name)}, kendoDatePicker: {value: $root.observableVals[$index()]}" />' +
            '                                   <input type="hidden" data-bind="attr: {name: \'hx_drl\' + name, value: alias}"><input type="hidden" data-bind="attr: {name: \'fx_drl\' + name, value: value}">' +
            '                               </td>' +
            '                           <!-- /ko -->' +
            '                           <!-- ko if: type == \'currencybox\' -->' +
            '                               <td class="font">' +
            '                                   <input type="text" class="k-textbox" data-bind="attr: {id: $root.elemIdent(\'_txt\' + name), name: $root.elemIdent(\'_txt\' + name)}, style: {width: width}, value: $root.observableVals[$index()]">' +
            '                                   <input type="hidden" data-bind="attr: {name: \'hx_drl\' + name, value: alias}"><input type="hidden" data-bind="attr: {name: \'fx_drl\' + name, value: value}">' +
            '                               </td>' +
            '                           <!-- /ko -->' +
            '                           <!-- ko if: type == \'contentbox\' -->' +
            '                               <td class="font">' +
            '                                   <input type="text" class="k-textbox" data-bind="attr: {id: $root.elemIdent(\'_txt\' + name), name: $root.elemIdent(\'_txt\' + name)}, style: {width: width}, value: $root.observableVals[$index()]">' +
            '                               </td>' +
            '                           <!-- /ko -->' +
            '                           <!-- ko if: type == \'dropdownchecklist\' -->' +
            '                               <td class="font">' +
            '                                   <input data-bind="attr: {id: $root.elemIdent(\'_drl\' + name)}, kendoMultiSelect: {data: $data.lookups, dataTextField: \'value\', dataValueField: \'key\', value: $root.observableVals[$index()] }, kendoMultiSelectWidth: width" />' +
            '                                   <input type="hidden" data-bind="attr: {name: \'hx_drl\' + name, value: alias}"><input type="hidden" data-bind="attr: {name: \'fx_drl\' + name, value: value}">' +
            '                               </td>' +
            '                           <!-- /ko -->' +
            '                           </tr>' +
            '                       <!-- /ko -->' +
            '                       </tbody>' +
            '                       </table>' +
            '                   </td>' +
            '               </tr>' +
            '           </table>' +
            '       </td>' +
            '   </tr>' +
            '</table>',
        settings = {},
        headerObj,
        updatedData,
        headerData,
        headerSchema = {},
        headerLookups = {},
        formView = {},
        wrapper;
    var form = {
        init: function(options) {
            settings = $.extend({}, defaults, options);
            wrapper = this;
            if(!wrapper.length) {
                return false;
            }
            if(!settings.callArgs || (!settings.table && !settings.empty) || !settings.endpoint) {
                return false;
            }
            wrapper
                .addClass('font')
                .css({
                    'background-color': '#ffffff',
                    'border-width': '0px',
                    'width': '100%'
                });
            wrapper.append('<img id="' + settings.identifier + '_ApiLoader" src="' + settings.appRoot + 'System/Icons/api_loader.gif"/>');
            var getDataArgs = { 'SchemaFormat': 'json' };
            for(var prop in settings.callArgs) {
                getDataArgs[prop] = settings.callArgs[prop];
            }
            Yunique.Http.get('/' + settings.endpoint, getDataArgs)
                .then(function (resp) {
                    headerData = resp.YuniqueAPI;

                //--------------------------------------------------------
                /*    try {
                        for(var i = 0; i < 5; i++){
                            headerData.Lookups.SizeRange[i].value2 = 'A Cup';
                        }
                        for(var i = 5; i < 10; i++){
                            headerData.Lookups.SizeRange[i].value2 = 'Accessories';
                        }
                        for(var i = 10; i < 15; i++){
                            headerData.Lookups.SizeRange[i].value2 = 'Average';
                        }
                        for(var i = 15; i < 20; i++){
                            headerData.Lookups.SizeRange[i].value2 = 'Average-A';
                        }
                        for(var i = 20; i < 28; i++){
                            headerData.Lookups.SizeRange[i].value2 = 'Average-N';
                        }
                    } catch(e){}
					*/
                //--------------------------------------------------------

//                    console.log(headerData);

                    if (!headerData.Errors) {
                        var getSchemaArgs = { 'SchemaFormat': 'json', 'GetLookups': '1' };
                        if (settings.schemaParams) {
                            if (settings.schemaParams.constructor == Array) {
                                for(var i = 0; i < settings.schemaParams.length; i++) {
                                    getSchemaArgs[settings.schemaParams[i]] = headerData[settings.table][settings.schemaParams[i]] || '';
                                }
                            } else if (settings.schemaParams.constructor == Object) {
                                $.extend(getSchemaArgs, settings.schemaParams);
                            }
                        }
                        Yunique.Http.get('/' + settings.endpoint + '/Schema', getSchemaArgs)
                            .then(function (resp) {
                                if (!resp.YuniqueAPI.Errors) {
//                                    var headerSchema = {};
                                    for (var prop in resp.YuniqueAPI) {
                                        if (prop.indexOf('.xml') !== -1) {
                                            headerSchema = JSON.parse(resp.YuniqueAPI[prop].SchemaFile);
                                            headerLookups = resp.YuniqueAPI.Lookups;
                                            break;
                                        }
                                    }
//                                    headerObj = Yunique.Data.schemaParse('form', headerSchema, headerData[settings.table], headerData.Lookups);
                                    headerObj = Yunique.Data.schemaParse(
                                        'form', headerSchema, settings.empty ? {} : headerData[settings.table], headerLookups
                                    );
                                    var colCnt = [],
                                        tblWidth = wrapper.width() || 1000,
                                        local = headerData['@ClientCulture'] || 'en-US';
                                    for(var i = 1; i <= headerObj.columns; i++) {
                                        colCnt[i - 1] = i;
                                    }
//                                    kendo.culture(local);
                                    formView = {
                                        tblWidth: tblWidth,
                                        backgroundColor: settings.backgroundColor,
                                        data: ko.observableArray(headerObj.data),
                                        observableVals: [],
                                        dependLookups: [],
                                        columns: colCnt,
                                        pk: headerObj.pk,
                                        columnWidth: Math.round(100 / headerObj.columns) + '%',
                                        elemIdent: function(name) {
                                            return settings.identifier + name;
                                        },
                                        rootLink: function(addr) {
                                            return settings.appRoot + addr;
                                        }
                                    };
                                    for(var i = 0, l = headerObj.data.length; i < l; i++) {
                                        formView.observableVals.push(ko.observable(headerObj.data[i].value));
                                        formView.observableVals[i].subscribe(function() {
                                            updatedData = true;
                                        }, formView);

                                        //--------------------------------------------------------------------------------------
                                        /*
										if(headerObj.data[i].linkedCol) {
                                            console.log(headerObj.data[i].linkedCol);
                                            var ind = -1;
                                            for(var k = 0; k < l; k++) {
                                                if(headerObj.data[k].name === headerObj.data[i].linkedCol) {
                                                    ind = k;
                                                    break;
                                                }
                                            }
                                            if(ind !== -1) {
                                                formView.dependLookups[i] = ko.computed(function() {
                                                    var selected = formView.observableVals[ind](),
                                                        res = [];
                                                    if(selected) {

                                                        console.log(i);

                                                        for(var n = 0, m = headerObj.data[i].lookups.length; n < m; n++) {
                                                            if(!headerObj.data[i].lookups[n].value2) {
                                                                res.push(headerObj.data[i].lookups[n]);
                                                            } else if(headerObj.data[i].lookups[n].value2 === selected) {
                                                                res.push(headerObj.data[i].lookups[n]);
                                                            }
                                                        }
                                                    }

                                                    console.log('dependDS', res);

                                                    return res;
                                                });
                                                //console.log(headerObj.data[ind], formView.observableVals[ind](), ind);
                                            }
                                        }
										*/
                                        //--------------------------------------------------------------------------------------

                                    }

                                    // console.log(formView.dependLookups);

                                    var model = $(formModel);
                                    ko.bindingHandlers.kendoDropDownListWidth = {
                                        update: function (element, valueAccessor) {
                                            var dropdownlist = $(element).data("kendoDropDownList");
                                            dropdownlist.wrapper[0].style["width"] =
                                                ko.utils.unwrapObservable(valueAccessor());
                                        }
                                    };
                                    ko.bindingHandlers.kendoMultiSelectWidth = {
                                        update: function (element, valueAccessor) {
                                            var dropdownlist = $(element).data("kendoMultiSelect");
                                            dropdownlist.wrapper[0].style["width"] =
                                                ko.utils.unwrapObservable(valueAccessor());
                                        }
                                    };
                                    ko.applyBindings(formView, model[0]);
                                    wrapper.append(model);
                                    $('#' + settings.identifier + '_ApiLoader').css('display', 'none');
                                } else {
                                    form.showFormApiError(wrapper, settings.identifier, settings.appRoot, 'Can not display form');
                                }
                            }, function (errData) {
                                form.showFormApiError(wrapper, settings.identifier, settings.appRoot, 'Can not display form');
                            });
                    } else {
                        form.showFormApiError(wrapper, settings.identifier, settings.appRoot, 'Can not display form');
                    }
                }, function (errData) {
                    form.showFormApiError(wrapper, settings.identifier, settings.appRoot, 'Can not display form');
                });

            return this;
        },
        save: function(successCB, errorCB) {		
            if(headerObj && updatedData) {
                var callArgs = {},
                    data = headerObj.data,
                    row;
                for(var i = 0, l = data.length; i < l; i++) {
                    row = formView.observableVals[i]();
                    if(data[i].type == 'calendarbox') {
                        row = new Date(row);
                        row = row.getDate() + '/' + (row.getMonth() + 1) + '/' + row.getFullYear();
                    }
                    if(data[i].type == 'checkbox') {
                        row = row ? '1' : '0';
                    }
                    if(data[i].type == 'dropdownchecklist') {
                        row = typeof row == 'object' ? row.join(',') : row;
                    }
                    callArgs[data[i].name] = row;
                    if(!row) {
                        if(data[i].type == 'currencybox' || data[i].type == 'percentbox') {
                            callArgs[data[i].name] = data[i].defaultValue || '0';
                        }
                    }
                }
                callArgs[headerObj.pk.name] = headerObj.pk.value;
				
                Yunique.Http.put('/' + settings.endpoint, callArgs)
                    .then(function(res){
                        if (!res.YuniqueAPI.Errors) {
							if (successCB) {
								successCB();
							}
                            form.reinit(res.YuniqueAPI.Results);
                        } else {
							if (errorCB) {
								errorCB();
							}
                        }
                    }, function(err) {
						if (errorCB) {
								errorCB();
						}
                    }
                );
            } else {
				if (successCB) {
					successCB();
				}
			}

            return this;
        },
        batch: function(successCB) {
            var callArgs = {};
            if(headerObj && updatedData) {
                var data = headerObj.data,
                    row;
                for(var i = 0, l = data.length; i < l; i++) {
                    row = formView.observableVals[i]();
                    if(data[i].type == 'calendarbox') {
                        row = new Date(row);
                        row = row.getDate() + '/' + (row.getMonth() + 1) + '/' + row.getFullYear();
                    }
                    if(data[i].type == 'checkbox') {
                        row = row ? '1' : '0';
                    }
                    if(data[i].type == 'dropdownchecklist') {
                        row = typeof row == 'object' ? row.join(',') : row;
                    }
                    if(row) {
                        callArgs[data[i].name] = row;
                    }
                }
            }
            if (successCB) successCB(callArgs);

            return this;
        },
        reinit: function(table) {
            var updData = Yunique.Data.schemaParse('form', headerSchema, table, headerData.Lookups);
            formView.data = ko.observableArray(updData.data);
            formView.observableVals = [];
            for(var i = 0, l = updData.data.length; i < l; i++) {
                formView.observableVals.push(ko.observable(updData.data[i].value));
                formView.observableVals[i].subscribe(function() {
                    updatedData = true;
                }, formView);
            }
            $('#' + settings.identifier + '_Form').remove();
            var reinModel = $(formModel);
            ko.applyBindings(formView, reinModel[0]);
            wrapper.append(reinModel);
        },
        showFormApiError: function(wrapper, ident, root, err) {
            $('#' + ident +'_ApiLoader').css('display', 'none');
            wrapper.append('<img id="' + ident +'_ApiError" src="' + root +'System/Icons/icon_warning.gif"/><span class="fontHead" style="padding-left: 8px;">' + err + '</span>');
        }
    };
    $.fn.formControl = function(method) {
        method = (method && typeof method !== 'object') ? method.toLowerCase() : method;
        if(form[method]) {
            return form[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return form.init.apply(this, arguments);
        }
    };
})(jQuery);
