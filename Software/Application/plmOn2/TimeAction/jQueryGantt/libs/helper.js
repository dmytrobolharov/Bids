/**
 * @ngdoc directive
 * @id UI.directive:y-grid
 *
 * @description y-grid directive is a part of YuniqueSDK UI components library which can be used for displaying data in grid format.
 *
 * ## Usage
 *
 * In order to start using y-grid component you need to provide ``Yunique.UI`` dependency into your module.
 *
 * ```js
 *  var app = angular.module("app", ["Yunique.UI"]);
 * ```
 *
 * The basic defenition of the y-grid component with all possible attributes:
 *
 * <pre>
 *     <y-grid
 *          datasource="{array}"
 *          schema="{object}"
 *          lookupdata="{object}"
 *          [filterable="{boolean}"]
 *          [selectable="{boolean}"]
 *          [selectiontype="{string}"]
 *          [rowdblclick="{fn}"]
 *          [rowclick="{fn}"]
 *          [databound="{fn}"]
 *          [editable="{boolean}"]
 *          [pageble="{boolean}"]
 *          [pagesize="{number}"]
 *          [pageinput="{boolean}"]
 *          [sortable="{boolean}"]
 *          [reorderable="{boolean}"]
 *          [resizable="{boolean}"]
 *          [columnmenu="{boolean}"]
 *          >
 *     </y-grid>
 * </pre>
 *
 * ## Attributes
 *
 * * datadource - {array} - Array with data for display in the grid
 * * schema - {object} - Schema for display columns
 * * lookupdata - {object} - Schema for display controls that using in the grid
 * * filterable*(optional)* - {boolean} - Using the grid filter menu
 * * selectable*(optional)* - {boolean} - Able to select grid rows
 * * selectiontype*(optional)* - {string} - Type of selection data in the grid: "row", "cell", "multiple, row", "multiple, cell"
 * * rowdblclick*(optional)* - {fn} - Function is called every time when double clicked to the row and receives data as ``Event``
 * * rowclick*(optional)* - {fn} - Function is called every time when single clicked to the row and receives data as ``Event``
 * * databound*(optional)* - {fn} - Function is called every time when datasource is loaded
 * * editable*(optional)* - {boolean} - Able to edit the data to which the grid is bound to
 * * pageble*(optional)* - {boolean} - the grid will display a pager
 * * pagesize*(optional)* - {number} - The number of data items which will be displayed in the grid
 * * pageinput*(optional)* - {boolean} - Display an input element which allows the user to type a specific page number
 * * sortable*(optional)* - {boolean} - Allow to sort column content manually
 * * reorderable*(optional)* - {boolean} - Allow to reorder columns manually by drag and drop
 * * resizable*(optional)* - {boolean} - Allow to change columns width manually
 * * columnmenu*(optional)* - {boolean} - Show available grid functionality in columns header in menu (sorting, filterinc etc)
 *
 * ## Nested components
 *
 * If you need use custom template for the row just place directive ``row-template`` with you HTML code inside ``y-grid``
 *
 * <pre>
 *     <y-grid ...>
 *         <row-template>
 *             <!-- Any HTML Code -->
 *         </row-template>
 *     </y-grid>
 * </pre>
 *
 *  You also can provide only source path to the template in your project structure using ``src={string}`` attribute
 *
 * <pre>
 *     <y-grid ...>
 *         <row-template [src="{string}"]>
 *             <!-- Any HTML Code -->
 *         </row-template>
 *     </y-grid>
 * </pre>
 *
 * If you need use custom templates in header toolbox just place directive ``y-grid-headermoduls`` with you custom directives inside ``y-grid``
 *
 * You can use ``y-grid-showcolumns`` directive from the box for show/hide grid columns you need (using checkbox)
 *
 * ## Attributes
 *
 * * column - {string/number} - Column name or number you need to show/hide
 * * alias - {string} - Checkbox alias
 *
 * <pre>
 *     <y-grid ...>
 *         <y-grid-headermoduls>
 *             <y-grid-showcolumns column="AnyColumn" alias="AnyAlias"></y-grid-showcolumns>
 *             <y-grid-showcolumns column="1" alias="AnyAlias"></y-grid-showcolumns>
 *         </y-grid-headermoduls>
 *     </y-grid>
 * </pre>
 *
 **/


Yunique.Angular.UI.directive('yGrid', function($rootScope) {
    var $ = jQuery;
    return {
        restrict: 'E',
        replace: true,
        transclude: true,
        scope: {
            datasource: '=',
            schema: '=',
            lookupdata: '=',
            filterable: '=',
            selectable: '=',
            selectiontype: '=',
            rowdblclick: '=',
            rowclick: '=',
            celldblclick: '=',
            cellclick: '=',
            databound: '=',
            editable: '=',
            pageble: '=',
            pagesize: '=',
            pageinput: '=',
            columnmenu: '=',
            sortable: '=',
            reorderable: '=',
            resizable: '='
        },
        template: '<div class="k-loading-image" ng-transclude></div>',
        controller: ['$scope', '$element', '$attrs', 'Schema', function($scope, $element, $attrs, Schema) {
            this.rowTemplate = null;
            this.Schema = Schema;
            this.isModuls = false;
            this.toolbarComponents = [];
        }],
        link: function(scope, element, attrs, ctrl) {
            function findMagicNumber() {
                var div = document.createElement('div');
                div.style.overflowY = 'scroll';
                div.style.width =  '50px';
                div.style.height = '50px';
                div.style.visibility = 'hidden';
                document.body.appendChild(div);
                var scrollWidth = div.offsetWidth - div.clientWidth;
                document.body.removeChild(div);
                return scrollWidth;
            }
            var dataschema, magicNumber = findMagicNumber();
            function init(schema, lookups) {
                var columns;
                var schemaProperties = ctrl.Schema.convertToProperties(schema, false, "gridvisible");

                //closure
                //building columns and editors for grid cells
                var props = [], curProp = null;

                $(schemaProperties).each(function (i) {
                    if (this.enabled === "false" && this.gridvisible === "false") {
                        return true;
                    }

                    var that = this,
                        gridOrder = parseInt(this.gridorder);

                    curProp = {
                        "field": this.name,
                        "title": this.alias,
                        "width": parseInt(this.gridwidth) || 100,
                        "order": (gridOrder || gridOrder == 0) ? gridOrder : 999,
                        "hidden": !(this.gridvisible === "true")
                    };
                    if(this.pk && (this.pk.toLowerCase() === "true" || this.pk === true)) {
                        curProp.hidden = true;
                        props.push(curProp);
                        return true;
                    }

                    if (this.type == "dropdownlist") {
//                        if (scope.editable) {
//                            var dropdownData =  (function () {
//                                var result = null;
//                                $(lookups).each(function (i) {
//                                    for (var lookupName in this) {
//                                        if(lookupName == that.name) {
//                                            result = this[lookupName];
//                                            break;
//                                        }
//                                    }
//                                });
//                                return result;
//                            } ());
//                            // making renderer for dropdown and filling it with lookup data
//                            curProp["editor"] = function (container, options) {
//                                $('<input required data-text-field="value" data-value-field="key" data-bind="value:' + options.field + '"/>')
//                                    .appendTo(container)
//                                    .kendoDropDownList({
//                                        autoBind: false,
//                                        datasource: {
//                                            type: "json",
//                                            data: dropdownData
//                                        }
//                                    });
//                            };
//                        }

                        var valuesData = (function () {
                            var values = [];
                            $(scope.lookupdata).each(function (i) {
                                for (var lookupName in this) {
                                    if(lookupName == that.name) {
                                        $(this[lookupName]).each(function () {
                                            values.push({ "value": this["key"], "text": this["value"] });
                                        });
                                        break;
                                    }
                                }
                            });
                            return values;
                        } ());
                        curProp["values"] = valuesData;

                    } else if (this.type == "calendarbox" || this.datatype == "datetime") {
                        curProp["type"] = "date";
                        curProp["format"] = "{0:MM/dd/yyyy}";
                    } else if(this.type == "image") {
                        curProp["template"] = "<img class='ygridimage' src='#= " + this.name + " #'/>";
                    }
                    props.push(curProp);
                });
                /*=====================================================================================================*/
                columns = props;
                columns.sort(function(a, b){
                    return a.order-b.order;
                });

                //closure
                //building schema of data
                var dataSchema = {};
                dataSchema.model = {};
                dataSchema.model.fields = {};

                $(schemaProperties).each(function(i) {
                    if(this.pk && (this.pk.toLowerCase() === "true" || this.pk === true)) {
                        dataSchema.model.id = this.name;
                        dataSchema.model.fields[this.name] = {editable: false, nullable: true};
                        return true;
                    }
                    dataSchema.model.fields[this.name] = {type: (this.datatype == "datetime" ? "date" : "string")};
                    if(this.type == "image") {
                        dataSchema.model.fields[this.name]["editable"] = false;
                    }
                });
                dataschema = dataSchema;

                var that;
                $(scope.datasource).each(function(){
                    that = this;
                    $(schemaProperties).each(function() {
                        if(!that.hasOwnProperty(this.name)) {
                            that[this.name] = "";
                        }
                    });
                });

                var toolbarHtml = '';
                if(ctrl.isModuls === true) {
                    for (var prop in ctrl.toolbarComponents) {
                        toolbarHtml += ctrl.toolbarComponents[prop];
                    }
                }

                var columnsStorage = Yunique.Core.UIStateStorage.get('_grid');
                if (columnsStorage && columnsStorage.length === columns.length) {
                    var match = 0;
                    for (var i = 0, l = columnsStorage.length; i < l; i++) {
                        for (var k = 0; k < l; k++) {
                            if (columns[k].field === columnsStorage[i].field) {
                                match++;
                                break;
                            }
                        }
                    }
                    if (match === columnsStorage.length) {
                        columns = columnsStorage;
                    } else {
                        Yunique.Core.UIStateStorage.set('_grid', columns);
                    }
                }

                var wrapperWidth = 0;
                for (var i = 0, l = columns.length; i < l; i++) {
                    if (!columns[i].hidden) {
                        wrapperWidth += columns[i].width;
                    }
                }
                if (typeof wrapperWidth === "string") {
                    wrapperWidth = Number(wrapperWidth.replace('px', ''));
                }
                if (wrapperWidth > $('#yspa').width()) {
                    wrapperWidth = $('#yspa').width();
                }

                if (wrapperWidth !== 0) {
                    $(element).css('width', wrapperWidth + magicNumber);
                }
                // Created Grid
                $(element).kendoGrid({
                    datasource: {
                        data: scope.datasource,
                        pageSize: scope.pagesize,
                        schema: dataschema
                    },
                    toolbar: toolbarHtml,
                    columns: columns,
                    pageable: (scope.pageble) ? {
                        input: scope.pageinput,
                        numeric: false
                    } : false,
                    editable: scope.editable,
                    filterable: scope.filterable,
                    rowTemplate: ctrl.rowTemplate,
                    selectable: (scope.selectable) ? scope.selectiontype || "row" : false,
                    sortable: scope.sortable,
                    reorderable: scope.reorderable,
//                    resizable: scope.resizable,
                    columnMenu: scope.columnmenu,
                    dataBound: function() {
                        if (scope.datasource) {
                            $(element).removeClass('k-loading-image');
                            if (scope.databound) {
                                scope.databound();
                            }
                        }
                    },
                    edit: function(e) {
                        scope.$apply(function() {
                            scope.datasource = $(element).data('kendoGrid').dataSource.data().toJSON();
                        });
                    }
                });

//               $rootScope.$on("yGridColumnAction", function (event,message,action) {
//                    if(action === 'hide'){
//                        $(element).data("kendoGrid").hideColumn(message);
//                    }
//                    if(action === 'show'){
//                        $(element).data("kendoGrid").showColumn(message);
//                    }
//                });


            }
            function uppdateStorage() {
                setTimeout(function() {
                    Yunique.Core.UIStateStorage.set('_grid', $(element).data('kendoGrid').columns)
                }, 0);
            }
            // Watched datasource
            scope.$watch('datasource', function() {
                setTimeout(function() {
                    if ($(element).data('kendoGrid')) {
                        var lastObj = scope.datasource[scope.datasource.length-1],
                            prevObj = scope.datasource[scope.datasource.length-2];
                        for (var prop in prevObj){
                            if (prop in lastObj){

                            } else {
                                lastObj[prop]=""
                            }
                        }
                        $(element).data('kendoGrid').setDataSource(new kendo.data.DataSource({
                            data: scope.datasource,
                            pageSize: scope.pagesize,
                            schema: dataschema
                        }));

                        $(element).data('kendoGrid').bind("columnShow", function(e){
                            var width = $(element).find('table').css('width');
                            if (typeof width === "string") {
                                width = Number(width.replace('px', ''));
                            }
                            if (width >= $('#yspa').width()) {
                                width = $('#yspa').width() - magicNumber;
                            }
                            $(element).css('width', width + magicNumber + 'px'); // 15 is a magic number, please don't change this number
                            uppdateStorage();
                        });

                        $(element).data('kendoGrid').bind("columnHide", function(e){
                            var width = $(element).find('table').css('width');
                            if (typeof width === "string") {
                                width = Number(width.replace('px', ''));
                            }
                            if (width >= $('#yspa').width()) {
                                width = $('#yspa').width() - magicNumber;
                            }
                            $(element).css('width', width + magicNumber + 'px'); // 15 is a magic number, please don't change this number
                            uppdateStorage();

                        });

                        $(element).data('kendoGrid').bind("columnReorder", function(e){
                            $(element).data('kendoGrid').refresh();
                            uppdateStorage();
                        });

                    } else {
                        initApply();
                    }
                }, 0);
            }, true);
            function initApply() {
                if (!_.isEmpty(scope.lookupdata) && !_.isEmpty(scope.datasource) && !_.isEmpty((typeof scope.schema === "string") ? JSON.parse(scope.schema) : scope.schema)) {
                    init(scope.schema, scope.lookupdata);
                }
            }
            // Watched Schema
            scope.$watch('lookupdata', initApply, true);
            scope.$watch('schema', function() {
                try {
                    $(element).data('kendoGrid').setDataSource(new kendo.data.DataSource({
                        data: scope.datasource,
                        pageSize: scope.pagesize,
                        schema: dataschema
                    }));
                } catch(e){}
            }, true);

            $(element).on('mousedown', function(e) {
                if (e.target.tagName === 'TD') {
                    if (scope.rowclick) {
                        scope.rowclick($(element).data('kendoGrid').dataItem(e.target.parentNode));
                    }
                }
            });

            $(element).on('dblclick', function(e) {
                if (e.target.tagName === 'TD') {
                    if (scope.rowdblclick) {
                        scope.$apply(function() {
                            scope.rowdblclick($(element).data('kendoGrid').dataItem(e.target.parentNode));
                        });
                    }
                }
            });
        }
    };
});
/*
 Yunique.Angular.UI.directive('yGridHeadermoduls', function() {
 return {
 restrict: 'E',
 require: '^yGrid',
 replace: true,
 template: '',
 link: function(scope, elem, attr, yGridCtrl) {
 var toolbarTemplate = elem.html().replace(/^\s+/, '').replace(/\s+$/, '');
 if (toolbarTemplate && toolbarTemplate.length !== 0) {
 yGridCtrl.isModuls = true;
 }
 elem.html('');
 }
 };
 });

 Yunique.Angular.UI.directive('yGridShowcolumns', function() {
 return {
 restrict: 'E',
 require: '^yGrid',
 replace: true,
 link: function(scope, elem, attrs, yGridCtrl) {
 if(attrs.column) {
 if(parseInt(attrs.column)) {
 attrs.column = parseInt(attrs.column);
 }

 var showcolumnsTemplate =
 '<div class="showcolumn_' + attrs.column + '">' +
 '<input type="checkbox"/><span> ' + attrs.alias + '</span>' +
 '</div>';

 yGridCtrl.toolbarComponents.push(showcolumnsTemplate);

 setTimeout( function () {
 $('.showcolumn_' + attrs.column).find('input').change(function() {
 if ($(this).is(':checked')) {
 $('.k-grid').data('kendoGrid').showColumn(attrs.column);
 } else {
 $('.k-grid').data('kendoGrid').hideColumn(attrs.column);
 }
 });
 $('.k-grid').data('kendoGrid').hideColumn(attrs.column);
 }, 0);
 }
 }
 }
 });*/

Yunique.Angular.UI.directive('yGridRowtemplate', function() {
    var $ = jQuery;
    return {
        restrict: 'E',
        require: '^yGrid',
        replace: true,
        transclude: true,
        template: '',
        scope: true,
        controller: ['$scope', '$element', '$transclude', function($scope, $element, $transclude) {
            $transclude(function(clone) {
                $scope.template = $(clone).find('tbody').html();
            });
        }],
        link: function(scope, elem, attr, yGridCtrl) {
            if (scope.template && scope.template.length !== 0) {
                yGridCtrl.rowTemplate = scope.template;
            } else if (attr.src && attr.src.length !== 0) {
                $.ajax({
                    async: false,
                    url: attr.src,
                    dataType: 'html',
                    success: function(data) {
                        yGridCtrl.rowTemplate = data;
                    }
                });
            }
        }
    };
});