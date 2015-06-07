;
(function ($) {
    // common default settings
    var defaults = {
        'endpoint': '/Style',
        'removeEndpoint': '',
        'removeBy': '',
        'parametrs': '{"SchemaFormat": "json"}',
        'datatable': 'pStyleHeader',
        'lookups': false,
        'dataSource': { pageSize: 5 },
        'pageSize': 5,
        'pageable': true,
        'editable': true,
        'sortable': true,
        'resizable': true,
        'reorderable': true,
        'groupable': true,
        'columnMenu': true,
        'filterable': false,
        'scrollable': true,
        'searchable': false,
        'useUserPreference': false,
        'checkBoxColumn': false,
        'serverPaging': false
    };

    window.$ = jQuery
    var Yunique = window.Yunique = window.Yunique || {},
        settings = {},
        gridPK,
        updatedItems = [],
        updatedData = [];

    defaults.appRoot = Yunique.Data.getAppRoot() || '../';
    // methods for building grid control
    var methods = {
        init: function (options) {

            var gridSchema, //gridSchema
                gridLookups,
                gridSearchLookups,
                gridGrouping,
                gridElement,
                gridDatasource,
                gridDataSchema = {},
                gridColumns = [],
                wrapper = this,
                currentPage = document.location.pathname.match(/[^\/]+$/)[0];
            settings = $.extend({}, defaults, options);
            gridElement = '#' + settings.gridname;
            settings.removeEndpoint = settings.removeEndpoint || settings.endpoint;

            var dataSourceResp;

            wrapper.append('<img id="' + settings.identifier + '_ApiLoader" src="' + settings.appRoot + 'System/Icons/api_loader.gif"/>');

            LoadUserPreferenceToLocalStorage();

            buildGrid(JSON.parse(settings.parametrs));

            function buildGrid(schemaParams, searchSchemaParams) {
                schemaParams['getlookups'] = '1';
                Yunique.Http.get(settings.endpoint + '/Schema', schemaParams)
                    .then(function (schemaResp) {

                        gridLookups = schemaResp.YuniqueAPI.Lookups

                        removeGrid();

                        gridDatasource = new kendo.data.DataSource({
                            transport: {
                                read: function (options) {
                                    var params, args = {};
                                    /*Pagination*/
                                    if(settings.serverPaging){
                                        args['pagesize'] = options.data.pageSize;
                                        args['PageNumber'] = options.data.page;
                                    }
                                    else{
                                        args['pagesize'] = '999999';/*Get all data from server(Bad practice)*/
                                    }

                                    /*Sorting*/
                                    if(options.data.sort && options.data.sort.length > 0){
                                        args['orderby'] = options.data.sort[0].field.toString()+ ' ' + options.data.sort[0].dir.toString();
                                    }
                                    /*/!!!PROPERLY TEST IT!!!/*/
                                    if (!options.data.filter) {
                                        params = searchSchemaParams;
                                    } else {
                                        params = options.data.filter.filters[0]
                                    }

                                    Yunique.Http.get(settings.endpoint, params, args)
                                        .then(function (_dataSourceResp) {
                                            dataSourceResp=_dataSourceResp;
                                            var ygridDatasource = objectToArray(_dataSourceResp.YuniqueAPI[settings.datatable]);
                                            options.success(ygridDatasource);
                                        })

                                }
                            },
                            pageSize: 5,
                            serverPaging: settings.serverPaging,
                            serverFiltering: settings.serverPaging,

                            serverSorting: settings.serverPaging,
                            //serverGrouping: false,
                            schema: {
                                model: gridDataSchema.model,
                                // total: function (response) {
                                    // /*DON'T FORGET TO FIX THIS HARDCODE*/
                                    // return 67;//response.total;
                                // }
                            }


                        });

                        if (!searchSchemaParams) {
                            searchSchemaParams = JSON.parse(settings.parametrs);
                        }

                        gridDatasource.fetch(function () {
                            searchSchemaParams['SchemaType'] = 'Search';
                            searchSchemaParams['getlookups'] = '1';
                            Yunique.Http.get(settings.endpoint + '/Schema', searchSchemaParams).then(function (searchSchemaResp) {

                                //gridDatasource = objectToArray(dataSourceResp.YuniqueAPI[settings.datatable]);
                                gridLookups = dataSourceResp.YuniqueAPI.Lookups;

                                gridColumnsPreparation(schemaResp);

                                gridDatasource = new kendo.data.DataSource({
                                    transport: {
                                        read: function (options) {
                                            var params, args = {};
                                            /*Pagination*/
                                            if(settings.serverPaging){
                                                args['pagesize'] = options.data.pageSize;
                                                args['PageNumber'] = options.data.page;
                                            }
                                            else{
                                                args['pagesize'] = '999999';/*Get all data from server(Bad practice)*/
                                            }

                                            /*Sorting*/
                                            if(options.data.sort && options.data.sort.length > 0){
                                                args['orderby'] = options.data.sort[0].field.toString()+ ' ' + options.data.sort[0].dir.toString();
                                            }

                                            if(options.data.group && options.data.group.length > 0){
                                                args['orderby']=[];
                                                for(var i=0;i<options.data.group.length;i++){
                                                    args['orderby'][i] = options.data.group[i].field.toString()+ ' ' + options.data.group[i].dir.toString();

                                                }
                                            }

                                            /*/!!!PROPERLY TEST IT!!!/*/
                                            if (!options.data.filter) {
                                                params = searchSchemaParams;
                                            } else {
                                                params = options.data.filter.filters[0]
                                            }

                                            Yunique.Http.get(settings.endpoint, params, args)
                                                .then(function (_dataSourceResp) {
                                                    dataSourceResp=_dataSourceResp;
                                                    var ygridDatasource = objectToArray(_dataSourceResp.YuniqueAPI[settings.datatable]);
                                                    options.success(ygridDatasource);
                                                })

                                        }
                                    },
                                    pageSize: 5,
                                    serverPaging: settings.serverPaging,
                                    serverFiltering: settings.serverPaging,

                                    serverSorting: settings.serverPaging,
                                    //serverGrouping: false,
                                    schema: {
                                        model: gridDataSchema.model,
                                        // total: function (response) {
                                            // /*DON'T FORGET TO FIX THIS HARDCODE*/
                                            // return 67;//response.total;
                                        // }
                                    }


                                });
                                /*Search Form*/

                                if (settings.searchable) {
                                    if (!searchSchemaResp.YuniqueAPI.Errors) {
                                        var headerSchema = {},
                                            headerObj = {};
                                        var headerData = dataSourceResp.YuniqueAPI;
                                        for (var prop in searchSchemaResp.YuniqueAPI) {
                                            if (prop.indexOf('.xml') !== -1) {
                                                headerSchema = JSON.parse(searchSchemaResp.YuniqueAPI[prop].SchemaFile);
                                                break;
                                            }
                                        }
                                        headerObj = Yunique.Data.schemaParse('form', headerSchema, {}, headerData.Lookups);
                                        var colCnt = function () {
                                            var ar = [];
                                            for (var i = 1; i <= headerObj.columns; i++) {
                                                ar[i - 1] = i;
                                            }
                                            return ar;
                                        }();

                                        var tblWidth = wrapper.width() || 1000;
                                    }
                                }

                                window.datasource = gridDatasource;

                                var ViewModel = function () {
                                    /*Grid initialization*/
                                    this.datasource = gridDatasource;
                                    this.dataOfDataSource = gridDatasource.data(),
//                                        this.datasource = ko.observableArray(gridDatasource);
                                    this.columns = gridColumns;
                                    this.gridname = settings.gridname;
                                    this.pagesize = settings.pagesize;
                                    this.pageable = settings.pageable;
                                    this.editable = settings.editable;
                                    this.sortable = settings.sortable;
                                    this.resizable = settings.resizable;
                                    this.reorderable = settings.reorderable;
                                    this.groupable = settings.groupable;
                                    this.filterable = settings.filterable;
                                    this.columnmenu = settings.columnmenu;
                                    this.scrollable = settings.scrollable;
                                    this.searchable = settings.searchable;
                                    this.gridschema = gridSchema


                                    /*\Grid initialization*/

                                    /*Search Form initialization*/
                                    if (settings.searchable) {
                                        var _this = this;
                                        this.searchGridForm = settings.gridname + '_searchForm';
                                        this.tblWidth = tblWidth;
                                        this.data = ko.observableArray(headerObj.data);
                                        console.log("headerObj.data",headerObj.data)

                                        this.observableVals = [];
                                        for (var i = 0, l = headerObj.data.length; i < l; i++) {
                                            this.observableVals.push(ko.observable(headerObj.data[i].value));
                                            this.observableVals[i].subscribe(function (newVal) {
                                                updatedData = [];
                                                for (var k = 0, j = this.observableVals.length; k < j; k++) {
                                                    updatedData.push(this.observableVals[k]());
                                                }
                                            }, this);
                                        }


                                        this.dropdown = ko.observable();

                                        this.searchcolumns = colCnt;
                                        this.pk = headerObj.pk;
                                        this.columnWidth = Math.round(100 / headerObj.columns) + '%';
                                        this.rootLink = function (addr) {
                                            return settings.appRoot + addr;
                                        };
                                        this.calendar = function (name, value) {
                                            return 'javascript:calendarpopup(\'txt' + name + '\',\'' + value + '\')';
                                        };

                                        this.elemIdent = function (name) {
                                            return settings.gridname + name;
                                        };


                                        this.onChange = function (root, data, index) {
                                            if (root.autopostback === 'true') {
                                                var rootName = root.name;
                                                var dataParams = $.extend(true, {}, JSON.parse(settings.parametrs));
                                                var searchSchemaParams = $.extend(true, {}, JSON.parse(settings.parametrs));
                                                var schemaParams = $.extend(true, {}, JSON.parse(settings.parametrs));
                                                searchSchemaParams[rootName] = root.lookups[index.sender.selectedIndex].key;
                                                schemaParams[rootName] = root.lookups[index.sender.selectedIndex].key;
                                                searchSchemaParams['SchemaType'] = 'Search';
                                                searchSchemaParams['getlookups'] = '1';
                                                dataParams[rootName] = root.lookups[index.sender.selectedIndex].key;

                                                Yunique.Http.get(settings.endpoint + '/Schema', searchSchemaParams).then(function (searchSchemaResp) {
                                                    buildGrid(schemaParams, searchSchemaParams);

                                                    var headSchema = {};
                                                    var headObj = {};
                                                    var headData = dataSourceResp.YuniqueAPI;
                                                    for (var prop in searchSchemaResp.YuniqueAPI) {
                                                        if (prop.indexOf('.xml') !== -1) {
                                                            headSchema = JSON.parse(searchSchemaResp.YuniqueAPI[prop].SchemaFile);
                                                            break;
                                                        }
                                                    }
                                                    headerObj = Yunique.Data.schemaParse('form', headSchema, headData[settings.datatable], headData.Lookups);
                                                    _this.data.removeAll();
                                                    _this.data(headerObj.data);
                                                    listGridSearch();
                                                });
                                            }
                                        };


                                        this.search = function () {
                                            listGridSearch();
                                        };
                                        function listGridSearch() {
                                            var filters = [], params;

                                            $(headerObj.data).each(function (i) {
                                                var key = headerObj.data[i].name;
                                                var value = updatedData[i] || "";
                                                filters[key] = value;
                                            });

                                            $.extend(filters, JSON.parse(settings.parametrs));
                                            params = $.extend({}, filters);

                                            gridDatasource.filter(params);
                                        }
                                    }
                                    /*\Search Form initialization*/

                                };

                                /*For User preference*/
                                if (settings.useUserPreference) {
                                    var columnsStorage = Yunique.Core.UIStateStorage.get(settings.gridname);
                                    if (columnsStorage && columnsStorage['columns']) {
                                        columnsStorage = columnsStorage.columns;
                                        if (columnsStorage && columnsStorage.length === gridColumns.length) {
                                            var match = 0;
                                            for (var i = 0, l = columnsStorage.length; i < l; i++) {
                                                for (var k = 0; k < l; k++) {
                                                    if (gridColumns[k].field === columnsStorage[i].field) {
                                                        match++;
                                                        break;
                                                    }
                                                }
                                            }
                                            if (match === columnsStorage.length) {
                                                var tmp_columns = gridColumns;
                                                gridColumns = columnsStorage;
                                                gridColumns.forEach(columnsValue)

                                                function columnsValue(element, index, array) {
                                                    for (var i = 0; i < tmp_columns.length; i++) {
                                                        if (element.field === tmp_columns[i].field) {
                                                            var hiden = gridColumns[index].hidden;
                                                            var width = gridColumns[index].width;
                                                            gridColumns[index] = tmp_columns[i];
                                                            //for width
                                                            if (gridColumns[index].width !== width) {
                                                                gridColumns[index].width = Number(width);
                                                            }
                                                            //for hidden
                                                            if (hiden === "true" || hiden === true) {
                                                                gridColumns[index].hidden = true;
                                                            }
                                                            else {
                                                                gridColumns[index].hidden = false;
                                                            }
                                                            break;
                                                        }
                                                    }
                                                }

                                            } else {
                                                uppdateStorage();
                                            }
                                        }
                                    }
                                    /*\For User preference*/
                                }
                                if (settings.searchable) {
                                    var searchform = $(
                                        '<!-- ko if:  searchable -->' +
                                            '<div data-bind="attr: { id: searchGridForm }" class="yunique-grid-search">' +
                                            '<table data-bind="attr: {id: elemIdent(\'_Form\')}" min-height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">' +
                                            '   <tr>' +
                                            '       <td data-bind="attr: {width: tblWidth}">' +

                                            '           <table data-bind="attr: {id: elemIdent(\'_Content\')}, foreach: searchcolumns" bgcolor="#ffffff" width="100%" border="0" cellspacing="1" cellpadding="0">' +
                                            '               <tr valign="top">' +
                                            '                   <td data-bind="attr: {width: $root.columnWidth}">' +
                                            '                       <table width="100%" border="0" cellspacing="0" cellpadding="1">' +
                                            '                       <tbody>' +
                                            '                           <tr data-bind="foreach: $root.data">' +
                                            '                       <!-- ko if: column == $parentContext.$index() + 1 -->' +
                                            '                               <td width="125" height="25" class="fontHead" nowrap>' +
                                            '                                   <span data-bind="text: alias"></span>' +
                                            '<br>' +
                                            '        <!-- ko if: type == \'textbox\' -->' +
                                            '                                   <input type="text" class="k-textbox" data-bind="attr: {id: $root.elemIdent(\'_txt\' + name), name: $root.elemIdent(\'_txt\' + name)}, style: {width: width}, value: $root.observableVals[$index()]">' +
                                            '                           <!-- /ko -->' +
                                            '                           <!-- ko if: type == \'label\' -->' +
                                            '                                   <span data-bind="attr: {id: $root.elemIdent(\'_txt\' + name)}, text: value"></span>' +
                                            '                           <!-- /ko -->' +
                                            '                           <!-- ko if: type == \'calendarbox\' -->' +
                                            '                                   <input data-bind="kendoDatePicker: {value: $root.observableVals[$index()]}" />' +
                                            '                           <!-- /ko -->' +
                                            '                           <!-- ko if: type == \'dropdownlist\' -->' +
                                            '                                   <input data-bind="kendoDropDownList: { data: $data.lookups, dataTextField: \'value\', dataValueField: \'key\', value: $root.observableVals[$index()], change: $root.onChange.bind($root, $data, $index()), widget: $root.dropdown }, kendoDropDownListWidth: width" />' +
                                            '                           <!-- /ko -->' +

                                            '                               </td>' +

                                            '                       <!-- /ko -->' +
                                            '                           </tr>' +
                                            '                       </tbody>' +
                                            '                       </table>' +
                                            '                   </td>' +
                                            '               </tr>' +
                                            '           </table>' +
                                            '       </td>' +
                                            '       <td valign="top" width="100%">' +
                                            '       <div><button id="btnFilter" data-bind="click: search">Search</button></div>' +
                                            '       </td>' +
                                            '   </tr>' +
                                            '<br>' +
                                            '</table>' +
                                            '</div>' +

                                            '<!-- /ko -->'
                                    );
                                }
                                var grid = $(
                                    '<div class="yunique-grid">' +
                                        '<div data-bind="attr: { id: gridname },kendoGrid: {' +
                                        'data:dataOfDataSource,' +
                                        'dataSource: datasource,' +
                                        'pageSize: pagesize,' +
                                        'pageable: { pageSizes: [5, 10, 20, 30, 40, 50, 100] },' +
                                        'editable: editable,' +
                                        'sortable: sortable,' +
                                        'resizable: resizable,' +
                                        'reorderable: reorderable,' +
                                        'groupable: groupable,' +
                                        'filterable: filterable,' +
                                        'columns: columns,' +
                                        'columnMenu: columnmenu,' +
                                        'scrollable: scrollable,' +
                                        '}">' + '</div>' +
                                        '</div>'
                                );


                                ko.bindingHandlers.kendoDropDownListWidth = {
                                    update: function (element, valueAccessor) {
                                        var dropdownlist = $(element).data("kendoDropDownList");
                                        dropdownlist.wrapper[0].style["width"] =
                                            ko.utils.unwrapObservable(valueAccessor());
                                    }
                                };

                                ko.applyBindings(new ViewModel(), grid[0]);

                                if (settings.searchable) {
                                    ko.applyBindings(new ViewModel(), searchform[1]);
                                    if (!$('#' + settings.gridname + '_searchForm').length > 0) {
                                        wrapper.append(searchform);
                                    }
                                }

                                $('#' + settings.identifier + '_ApiLoader').css('display', 'none');
                                wrapper.append(grid);


                                /*For User preference*/
                                if (settings.useUserPreference) {
                                    var dataSource = $(gridElement).data('kendoGrid').dataSource;
                                    var currentGrouping = JSON.stringify(dataSource.group());
                                    gridGrouping = Yunique.Core.UIStateStorage.get(settings.gridname);
                                    if (gridGrouping && gridGrouping['grouping']) {
                                        gridGrouping = gridGrouping['grouping'];
                                        if (currentGrouping != gridGrouping) {
                                            dataSource.group(gridGrouping);
                                            uppdateStorage('group');
                                        }
                                    }
                                }
                                /*\For User preference*/

                                $(gridElement).data('kendoGrid').refresh();

                                $(gridElement).data().kendoGrid.dataSource.bind('change', function (e) {
                                    if (e.action === "itemchange" && e.field.toLowerCase() != 'IsChecked'.toLowerCase()) {/*Filtering datasource changed it and we cath this event, but we need catch only 'itemchanged' event*/
                                        var itemToUpdate = JSON.parse(JSON.stringify(e.items[0]));

                                        if (updatedItems.length != 0) {
                                            var index;
                                            for (var i = 0; i < updatedItems.length; i++) {
                                                if (updatedItems[i][gridPK] === itemToUpdate[gridPK]) {
                                                    index = i;
                                                    break;
                                                }
                                            }
                                            if (index || index === 0) {
                                                updatedItems[index] = itemToUpdate;
                                            } else {
                                                updatedItems.push(itemToUpdate);
                                            }
                                        }
                                        else {
                                            updatedItems.push(itemToUpdate);
                                        }
                                        console.log("Updated items onchange:", updatedItems)
                                    }
                                });

                                $(gridElement).data('kendoGrid').bind("columnShow", function (e) {
                                    var width = $(gridElement).find('table').css('width');
                                    if (typeof width === "string") {
                                        width = Number(width.replace('px', ''));
                                    }
                                    uppdateStorage();
                                });

                                $(gridElement).data('kendoGrid').bind("columnHide", function (e) {
                                    var width = $(gridElement).find('table').css('width');
                                    if (typeof width === "string") {
                                        width = Number(width.replace('px', ''));
                                    }
                                    uppdateStorage();
                                });

                                $(gridElement).data('kendoGrid').bind("columnReorder", function (e) {
                                    $(gridElement).data('kendoGrid').refresh();
                                    uppdateStorage();
                                });
                                $(gridElement).data('kendoGrid').bind("columnResize", function (e) {
                                    uppdateStorage();
                                });

                                $(gridElement).data('kendoGrid').bind("dataBinding", function dataBoundKendo(e) {
                                    var dataSource = this.dataSource;
                                    var currentGrouping = JSON.stringify(dataSource.group());
                                    if (gridGrouping && gridGrouping['grouping']) {
                                        gridGrouping = JSON.stringify(Yunique.Core.UIStateStorage.get(settings.gridname));
                                        gridGrouping = gridGrouping['grouping'];
                                        if (currentGrouping != gridGrouping) {
                                            // the current gridGrouping configuration has changed
                                            gridGrouping = currentGrouping;
                                            gridGrouping = JSON.parse(gridGrouping);

                                            uppdateStorage('group');
                                        }
                                    }
                                    else {
                                        uppdateStorage('group')
                                    }

                                    $('#' + settings.gridname + ' input:checkbox.check-ygrid-all').prop('checked', false);
                                });

                                if(settings.checkBoxColumn){
                                    $('#' + settings.gridname + ' .k-header-column-menu').eq(0).hide()

                                    //$(gridElement).on('click', '.check-ygrid-row', function (e) {
                                        //var checked = $(this).is(':checked');
                                        //console.log("checked",checked)
//                                        var _grid = $(gridElement).data().kendoGrid;
//
//                                        var dataItem = _grid.dataItem($(this).closest('tr'));
//                                        console.log("dataItem",dataItem)
//                                        dataItem.set('IsChecked', 'true');
//                                    })

                                    $('#' + settings.gridname + ' input:checkbox.check-ygrid-all').change(function() {
                                        if(this.checked) {
                                            $('#' + settings.gridname + ' input:checkbox.check-ygrid-row').prop('checked', true);
                                        } else {
                                            $('#' + settings.gridname + ' input:checkbox.check-ygrid-row').prop('checked', false);
                                        }
                                    });

                                }

                            });
                        });
                    });
            }

            /*=============================END GRID INITIALIZATION==================================================*/

            function uppdateStorage(method) {
                if (settings.useUserPreference) {
                    setTimeout(function () {
                        var obj = {};

                        var columns = [];
                        var curColumns = $(gridElement).data('kendoGrid').columns;
                        curColumns.forEach(Column);

                        function Column(element, index, array) {
                            var objCol = {};
                            objCol['field'] = element.field;
                            objCol['hidden'] = element.hidden;
                            objCol['lockable'] = element.lockable;
                            objCol['locked'] = element.locked;
                            objCol['order'] = element.order;
                            objCol['title'] = element.title;
                            objCol['width'] = element.width;
                            if (element.type !== undefined) {
                                objCol['type'] = element.type;
                            }
                            columns.push(objCol);
                        }

                        obj['columns'] = columns;

                        if (method === 'group') {
                            var dataSource = $(gridElement).data('kendoGrid').dataSource;
                            obj['grouping'] = dataSource.group();
                        }
                        else {

                            var grouping = Yunique.Core.UIStateStorage.get(settings.gridname)
                            if (grouping && grouping['grouping']) {
                                obj['grouping'] = grouping['grouping'];
                            }

                        }

                        Yunique.Core.UIStateStorage.set(settings.gridname, obj)
                        saveUserPreferenceToServer(obj)
                    }, 0);
                }
            }

            function saveUserPreferenceToServer(obj) {
                var userPreference = [];
                var element = Yunique.Core.UIStateStorage.get(settings.gridname);


                var obj;
                var group = "";
                var columns = "";

                function printGroup(element, index, array) {
                    group = group + element.field + " " + element.dir + ",";
                }

                function printColumns(element, index, array) {
                    columns = columns + element.field + "," + element.title + "," + element.hidden + "," + element.locked + "," + element.width + ";"
                }

                for (var prop in element) {
                    if (element.hasOwnProperty(prop))
                        if (prop === 'grouping') {
                            var tmp_group = element['grouping'];
                            tmp_group.forEach(printGroup);
                            obj = {
                                TeamID: "203517C2-2BD4-4ED3-9EF7-AC37DE447321",
                                UserPreferenceKey: "GridGroupSort",
                                UserPreferenceValue: group,
                                UserPreferenceObjectName: settings.gridname,
                                UserPreferencePage: currentPage
                            };
                            userPreference.push(obj);
                        }
                        else if (prop === 'columns') {
                            var tmp_columns = element['columns'];
                            tmp_columns.forEach(printColumns);
                            obj = {
                                TeamID: "203517C2-2BD4-4ED3-9EF7-AC37DE447321",
                                UserPreferenceKey: "ColumnOrder",
                                UserPreferenceValue: columns,
                                UserPreferenceObjectName: settings.gridname,
                                UserPreferencePage: currentPage
                            };
                            userPreference.push(obj);
                        }

                }

                Yunique.Http.get('/User', {'UserName': 'administrator'})
                    .then(function (r) {
                        Yunique.Http.put('/userPreference', userPreference);

                    }, function (er) {
                        console.log(er);
                    });
            }

            /*/Load User Preference to local storage /*/
            function LoadUserPreferenceToLocalStorage() {
                if (settings.useUserPreference) {
                    Yunique.Http.get('/userPreference', {"TeamID": "203517C2-2BD4-4ED3-9EF7-AC37DE447321", "UserPreferenceObjectName": settings.gridname, "UserPreferencePage": currentPage}).then(function (userPreferenceResp) {
                        if (userPreferenceResp['YuniqueAPI']['uUserPreference']) {
                            var userPreferenceArray = objectToArray(userPreferenceResp['YuniqueAPI']['uUserPreference']);
                            userPreferenceArray.forEach(userPreferencePackaging);

                            function userPreferencePackaging(element, index, array) {
                                if (element.UserPreferenceKey === 'ColumnOrder') {
                                    var _columns = element.UserPreferenceValue;
                                    var _temp = _columns.split(';');
                                    var _arr = [];
                                    for (var k = 0; k < (_temp.length - 1); k++) {
                                        var _col = _temp[k].split(',');

                                        for (var i = 0; i < _col.length; i++) {
                                            var _column = {};
                                            _column['field'] = _col[i];
                                            i++;
                                            _column['title'] = _col[i];
                                            i++;
                                            _column['hidden'] = _col[i];
                                            i++;
                                            _column['locked'] = _col[i];
                                            i++;
                                            _column['width'] = _col[i];
                                            _arr.push(_column);
                                        }
                                    }
                                    var userPreference = {"columns": _arr};
                                    Yunique.Core.UIStateStorage.set(settings.gridname, userPreference);
                                }
                                else if (element.UserPreferenceKey === 'GridGroupSort') {
                                    var _arr = [];
                                    var _groupping = element.UserPreferenceValue;
                                    var _temp_group = _groupping.split(',');
                                    for (var k = 0; k < (_temp_group.length - 1); k++) {
                                        var _group = _temp_group[k].split(' ');
                                        for (var i = 0; i < _group.length; i++) {
                                            var _grouping = {};
                                            _grouping['field'] = _group[i];
                                            i++;
                                            _grouping['dir'] = _group[i];
                                            _arr.push(_grouping);
                                        }
                                    }

                                    var userPreference = {"grouping": _arr};
                                    Yunique.Core.UIStateStorage.set(settings.gridname, userPreference);

                                }
                            }
                        }
                    });
                }
            }

            /*/ Remove Grid With same ID if it exist/*/
            function removeGrid() {
                var gridId = $('#' + settings.gridname);

                if (gridId.length > 0) {
                    //gridId.data("kendoGrid").destroy();
                    gridId.parent().remove();
                }
            }

            function gridColumnsPreparation(schemaResp) {

                for (var prop in schemaResp.YuniqueAPI) {
                    if (prop.indexOf('.xml') !== -1) {
                        gridSchema = Yunique.Data.convertToProperties(schemaResp.YuniqueAPI[prop].SchemaFile);
                        break;
                    }
                }

                var schemaProperties = Yunique.Data.convertToProperties(gridSchema, false, "gridvisible");
                var props = [], curProp = null;

                $(schemaProperties).each(function (i) {
                    if (this.enabled === "false" && this.gridvisible.toLowerCase() === "false" || this.apivisible === "false") {
                        if (this.pk && (this.pk.toLowerCase() === "true" || this.pk === true)) {
                            gridPK = this.name;
                            settings.removeBy = settings.removeBy || this.name;
                        }

                        return true;
                    }

                    var _this = this,
                        gridOrder = parseInt(this.gridorder);

                    curProp = {
                        "field": this.name,
                        "title": this.alias,
                        "width": parseInt(this.gridwidth) || 100,
                        "order": (gridOrder || gridOrder == 0) ? gridOrder : 999,
                        "hidden": !(this.gridvisible === "true"),
                        "locked": (this.locked === "true"),
                        "lockable": (this.lockable === "true")
                    };
                    if (this.pk && (this.pk.toLowerCase() === "true" || this.pk === true)) {
                        curProp.hidden = true;
                        props.push(curProp);
                        return true;
                    }

                    if (this.type == "dropdownlist") {
                        var valuesData = (function () {
                            var values = [];
                            $(gridLookups).each(function (i) {
                                for (var lookupName in this) {
                                    if (lookupName == _this.name) {
                                        $(this[lookupName]).each(function () {
                                            values.push({ "value": this["key"], "text": this["value"] });
                                        });
                                        break;
                                    }
                                }
                            });
                            return values;
                        }());
                        curProp["values"] = valuesData;

                    } else if (this.type == "calendarbox" || this.datatype == "datetime") {
                        curProp["type"] = "date";
                        curProp["format"] = "{0:MM/dd/yyyy}";
                    } else if (this.type == "image") {
                        curProp["template"] = "<img class='ygridimage' src='#= " + this.name + " #'/>";
                    } else if (this.type == "label") {
                        curProp["editable"] = false
                    }

                    props.push(curProp);
                });

                gridColumns = props;
                gridColumns.sort(function (a, b) {
                    return a.order - b.order;
                });

                if(settings.checkBoxColumn){
                    gridColumns.unshift({
                        field: 'chb',
                        title: "<input class='check-ygrid-all' type='checkbox' />",
                        width: 35,
                        template: "<input class='check-ygrid-row' type='checkbox' />",
                        sortable: false,
                        locked: true,
                        lockable: false,
                        menu: false,
                        filterable: false,
                        columnMenu: false,
                        groupable: false,
                        resizable: false,
                        editable: false});
                }

                //closure
                //building schema of data
                gridDataSchema.model = {};
                gridDataSchema.model.fields = {};

                $(schemaProperties).each(function (i) {
                    if (this.pk && (this.pk.toLowerCase() === "true" || this.pk === true)) {
                        gridDataSchema.model.id = this.name;
                        gridDataSchema.model.fields[this.name] = {editable: false, nullable: true};
                        return true;
                    }
                    gridDataSchema.model.fields[this.name] = {type: (this.datatype == "datetime" ? "date" : "string")};
                    if (this.type == "image") {
                        gridDataSchema.model.fields[this.name]["editable"] = false;
                    }else if (this.type == "label") {
                        gridDataSchema.model.fields[this.name]["editable"] = false;
                    }
                    if(settings.checkBoxColumn){
                        gridDataSchema.model.fields.chb={};
                        gridDataSchema.model.fields.chb.editable = false;
                    }
                });
            }


            function objectToArray(object) {
                var _type = Object.prototype.toString.call(object);
                var _array = [];
                if (_type === "[object Array]") {
                    _array = object;
                } else if (_type === "[object Object]") {
                    _array[0] = object;
                }
                return _array
            }

        },

        save: function (successCB, errorCB) {
            if (updatedItems.length > 0) {
                console.log("updatedItems", updatedItems)
                Yunique.Http.put(settings.endpoint, updatedItems)
                    .then(function (res) {
                        console.log("resp", res)
                        if (!res.YuniqueAPI.Errors) {
                            if (successCB) successCB();
                        } else {
                            if (errorCB) errorCB();
                        }
                    }, function (err) {
                        if (errorCB) {
                            errorCB();
                            console.log('error', err);
                        }

                    }
                );
            }
            else {
                successCB();
            }
        },

        removeitem: function (successCB, errorCB) {
            var _grid = $('#'+settings.gridname).data().kendoGrid,
                checked = $('input:checkbox:checked.check-ygrid-row'),
                batchUpdatedData = [];
            if (checked.length > 0) {
                checked.each(function(index) {
                    batchUpdatedData[index] = {};
                    batchUpdatedData[index][settings.removeBy] = _grid.dataItem($(this).closest('tr'))[settings.removeBy];
                });

                Yunique.Http['delete'](settings.removeEndpoint, batchUpdatedData)
                    .then(function (res) {
                        console.log("resp", res)
                        if (!res.YuniqueAPI.Errors) {
                            if (successCB) successCB();
                        } else {
                            if (errorCB) errorCB();
                        }
                    }, function (err) {
                        if (errorCB) {
                            errorCB();
                            console.log('error', err);
                        }
                    }
                );
            } else {
                if (successCB) successCB();
            }
        },

        batchupdate: function(batchData, successCB, errorCB){
            var _grid = $('#'+settings.gridname).data().kendoGrid,
                checked = $('input:checkbox:checked.check-ygrid-row'),
                batchUpdatedData = [];
            if (checked.length > 0) {
                checked.each(function(index) {
                    batchUpdatedData[index] = {};
                    batchUpdatedData[index][gridPK] = _grid.dataItem($(this).closest('tr'))[gridPK];
                });
                for(var i = 0; i < checked.length; i++) {
                    $.extend(batchUpdatedData[i], batchData);
                }

                Yunique.Http.put(settings.endpoint, batchUpdatedData)
                    .then(function (res) {
                        console.log("resp", res)
                        if (!res.YuniqueAPI.Errors) {
                            if (successCB) successCB();
                        } else {
                            if (errorCB) errorCB();
                        }
                    }, function (err) {
                        if (errorCB) {
                            errorCB();
                            console.log('error', err);
                        }
                    }
                );
            } else {
                if (successCB) successCB();
            }
        }
    };

    $.fn.yuniqueGridControl = function (method) {
        method = (method && typeof method !== 'object') ? method.toLowerCase() : method;
        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        }
    };
})(jQuery);

