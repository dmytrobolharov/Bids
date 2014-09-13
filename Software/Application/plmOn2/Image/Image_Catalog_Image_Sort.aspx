<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Image_Catalog_Item_Sort.aspx.vb" Inherits="plmOnApp.Image_Catalog_Item_Sort" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		            <title runat="server" id="PageTitle"></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
             
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
    <link rel="stylesheet" href="../System/CSS/jquery.ui.core.css" />
	<link rel="stylesheet" href="../System/CSS/jquery.ui.theme.css" />

        <script src="../System/Jscript/jquery-1.8.0.js"></script>
        <script src="../System/Jscript/jquery.ui.core.js"></script>
	    <script src="../System/Jscript/jquery.ui.widget.js"></script>
	    <script src="../System/Jscript/jquery.ui.mouse.js"></script>
	    <script src="../System/Jscript/jquery.ui.sortable.js"></script>
        <link href="../System/CSS/jquery-sortable.css" rel="stylesheet" />
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery.tablednd.js"></script>
        <style type="text/css">
            .dropimage
            {
            	background-image: url('../System/Icons/dragndrop.jpg');
            	background-repeat:no-repeat;
            	background-position:center;
            	width: 10px;
            }
            
        </style>

   
    
   
	
    
    <style>
	    li {cursor:url(../System/Cursor/openhand.cur), pointer} 
	    #sortable { list-style-type: none; margin: 0; padding: 0; }
	    #sortable li { margin: 3px 3px 3px 0; padding: 1px; float: left; width: auto; height: auto; text-align: center; vertical-align:top; }
	</style>
	
	<script type="text/javascript">
	    /** Rearranges the rows after the manual change of sort in thumbnail view */
	    function sortRows2(txtSort) {
	        var draggingRow = $(txtSort).closest('li'); // Getting the current table row
	        var hdnOldSort = draggingRow.find('input[name*="hdnsort"]');
	        // Checking, if sort was changed
	        var strNewSort = $(txtSort).val();
	        var strOldSort = hdnOldSort.val();
	        if (parseInt(strNewSort, 10) == parseInt(strOldSort, 10)) {
	            $(txtSort).val(strOldSort);
	            return;
	        }
	        // If the sort was changed, begining replacing
	        var newSort = parseInt(strNewSort, 10); // Getting the changed row sort (as integer)
	        var currentTable = $(txtSort).closest('ul'); // Getting the current table
	        if (isNaN(newSort)) {
	            newSort = 0;
	        }
	        // Checking all the rows in the table
	        // var allRows = currentTable.get(0).rows;
	        var wasInserted = false;

	        var lastRowVal = parseInt(currentTable.find('li:last').find('input[name*="txtImageSort"]').val(), 10);
	        var lastRow = currentTable.find('li:last');

	        if (newSort == lastRowVal && draggingRow.html() != lastRow.html()) {
	            draggingRow.insertAfter(currentTable.find('li:last')); // And inserting our row before it
	            wasInserted = true;

	        }
	        if (newSort > lastRowVal && draggingRow.html() != lastRow.html()) {
	            draggingRow.insertAfter(currentTable.find('li:last')); // And inserting our row before it
	            wasInserted = true;

	        }
	        if (!wasInserted) {
	            // for (var i = 0, currentRow; currentRow = allRows[i]; i++) {
	            $('li.ui-state-default').each(function () {
	                if (!wasInserted) {
	                    // Getting the sort from row
	                    var txtCurrentSort = $(this).find('input[name*="txtImageSort"]');
	                    var currentSort = parseInt($(txtCurrentSort).val(), 10);
	                    if (isNaN(currentSort)) {
	                        currentSort = 0;
	                    }

	                    if (currentSort == newSort && newSort == parseInt($(this).find('input[name*="hdnsort"]').val(), 10)) {
	                        if (newSort > parseInt(strOldSort, 10)) {
	                            draggingRow.insertAfter($(this));
	                        }

	                        if (newSort < parseInt(strOldSort, 10)) {
	                            draggingRow.insertBefore($(this));
	                        }
	                        wasInserted = true;

	                    }
	                    // Searching for the row with the sort, bigger then entered by user
	                    if (currentSort > newSort) {
	                        draggingRow.insertBefore($(this)); // And inserting our row before it
	                        wasInserted = true;

	                    }
	                }
	            });
	        }


	        var lastRow = currentTable.find('li:last');
	        if (!wasInserted && draggingRow.html() != lastRow.html()) { // If edited item now has the bigger sort of all, we inserting it at the end of the table
	            var lastRow = currentTable.find('li:last');
	            draggingRow.insertAfter(lastRow);
	        }

	        // Setting the consistent value in the textbox
	        var strNewSort = "0000" + newSort.toString();
	        strNewSort = strNewSort.substr(strNewSort.length - 4, 4); // Rough implementation of RIGHT
	        $(txtSort).val(strNewSort);
	        // Changing the hidden value
	        hdnOldSort.val(strNewSort);
	        // Repainting the table
	        // repaintRows($("#DataGrid1").get(0), draggingRow);
	        // processRowDrop($("#DataGrid1").get(0), draggingRow);
	        // Centering the element on screen
	        var rowTop = draggingRow.offset().top;
	        var documentHeight = $(document).height();
	        var windowHeight = $(window).height();
	        if ((documentHeight - rowTop) < windowHeight / 2) {
	            $(document).scrollTop(draggingRow.offset().top);
	        } else {
	            $(document).scrollTop(draggingRow.offset().top - windowHeight / 2);
	        }
	        var i = 0;
	        $('li').each(function () {
	            //set new sort order for thumbnail view

	            var newSort = "0000" + (i + 1).toString()
	            newSort = newSort.substr(newSort.length - 4, 4);
	            $(this).find('table').find('input[id*="ImageSort"]').val(newSort);
	            $(this).find('table').find('input[name*="hdnsort"]').val(newSort);
	            i++;
	        });
	        $(txtSort).focus();
	    }

	    $(window).load(function () {
	        $('.ui-state-default').mousedown(function () { $(this).css('cursor', 'url(../System/Cursor/closedhand.cur)'); });

	        $('.ui-state-default').mouseup(function () { $(this).css('cursor', 'url(../System/Cursor/openhand.cur)'); });





	        //hide id field
	        $('li').each(function () {
	            $(this).find('table').find('input[id*="ImageCatalogItemID"]').closest('tr').hide();

	            //$(this).find('table').find('input[id*="LineFolderItemSort"]').insertAfter('<input type="hidden" name="hdnsort" value="' + $(this).find('table').find('input[id*="LineFolderItemSort"]').val() + '"/>');
	            $('<input type="hidden" name="hdnsort" value="' + $(this).find('table').find('input[id*="ImageSort"]').val() + '"/>').insertAfter($(this).find('table').find('input[id*="ImageSort"]'));


	        });

	        $('li').each(function () {

	            $(this).find('table').find('input[id*="ImageSort"]').bind('blur', function () {
	                sortRows2(this);
	            });
	        });

	        var it = 0;
	        $('li').each(function () {
	            //set new sort order for thumbnail view

	            var newSort = "0000" + (it + 1).toString()
	            newSort = newSort.substr(newSort.length - 4, 4);
	            $(this).find('table').find('input[id*="ImageSort"]').val(newSort);
	            //$(this).find('table').find('input[id*="LineFolderItemSort"]').attr("width", "50px");
	            $(this).find('table').find('input[id*="ImageSort"]').css("width", "50px");

	            /*  $(this).find('table').find('td').each(function () {
	            $(this).css("white-space", "pre-wrap");

	            });

	            $(this).find('table').find('tr').each(function () {
	            $(this).find('td:odd').css("width", "70px");

	            });*/


	            $(this).find('table').find('input[name*="hdnsort"]').val(newSort);
	            it++;
	        });

	        /*  var maxHeight = 0;
	        $('li').each(function () {
	        alert($(this).css("height"));
	        if (parseInt($(this).css("height").substring(0, $(this).css("height").length - 2)) > maxHeight) {
	        maxHeight = parseInt($(this).css("height").substring(0, $(this).css("height").length - 2));
	        }

	        });
	        alert("max:"+maxHeight);
	        $('li').each(function () {
	        $(this).attr("height", maxHeight +"px");

	        });*/
	    });

	    $(function () {
	        $("#sortable").sortable({
	            stop: function (event, ui) {
	                var s = /\[\]/g;
	                var sE = /=/g;
	                document.getElementById("hdnSortOrder").value = $(this).sortable('serialize').replace(/&/g, ',').replace(s, '').replace(sE, '_');
	                document.getElementById("hdnChanged").value = '1';

	                var i = 0;
	                $('li').each(function () {
	                    //set new sort order for thumbnail view

	                    var newSort = "0000" + (i + 1).toString()
	                    newSort = newSort.substr(newSort.length - 4, 4);
	                    $(this).find('table').find('input[id*="ImageSort"]').val(newSort);
	                    $(this).find('table').find('input[name*="hdnsort"]').val(newSort);
	                    i++;
	                });
	            }
	        });
	        $("#sortable").disableSelection();


	    });
        </script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TBODY>
					<TR vAlign="middle">
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD vAlign="middle" align="left" width="400"><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="Confirmedimagebutton1" runat="server" 
								Message="NONE"></cc1:confirmedimagebutton></TD>
						<TD></TD>
					</TR>
				</TBODY>
			</TABLE>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Sort Line List</asp:label></td>
				</tr>
			</table>
			<table cellpadding="0" cellspacing="0" border="0">
				<tr valign="middle">
					<td width="150"><asp:label id="lblSortBy" Runat="server" CssClass="font"><b>Sort by:</b></asp:label>&nbsp;<asp:dropdownlist id="ddlSortBy" Runat="server"></asp:dropdownlist></td>
					<td><cc1:confirmedimagebutton id="btnSort" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
            <TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
				border="0">
				<TR vAlign="middle">
					
					<TD><asp:checkbox id="cbThumbnail" AutoPostBack="True" runat="server" ></asp:checkbox> <asp:Label ID="lblQryThumbnail" runat="server" 
                            Text="Thumbnail?"></asp:Label></TD>
					
                    </TD>
                    </TR>
                    </TABLE>

                    <asp:Panel ID="usuallPanel" runat="server">
			<asp:datagrid id="DataGrid1" runat="server" Width="300px" BorderColor="#E0E0E0" BorderStyle="Solid"
				BorderWidth="1px" PageSize="100" AutoGenerateColumns="False" DataKeyField="ImageCatalogItemID">
				<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				<Columns>	
                <asp:TemplateColumn ItemStyle-CssClass="dropimage">
						<HeaderTemplate>
							
						</HeaderTemplate>
						<ItemTemplate>
                               
							 
						</ItemTemplate>
					</asp:TemplateColumn>
                    <asp:TemplateColumn HeaderText="Design Image">						
						<ItemTemplate>
                        <img src="../../plmOnImageServer/ImageStream.ashx?S=50&V= <%# DataBinder.Eval(Container.DataItem, "Version").ToString%>&IID=<%# DataBinder.Eval(Container.DataItem, "ImageID").ToString%>" />
							
						</ItemTemplate>
					</asp:TemplateColumn>
                    			
					<asp:TemplateColumn HeaderText="Style No">						
						<ItemTemplate>
							<%# DataBinder.Eval(Container.DataItem, "ImageNo").ToString%>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Description">						
						<ItemTemplate>
							<%# DataBinder.Eval(Container.DataItem, "ImageDescription").ToString%>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn HeaderText="Sort">						
						<ItemTemplate>
							<asp:TextBox Runat="server" ID="txtSort" Text='<%#DataBinder.Eval(Container.DataItem,"ImageSort").tostring%>' Width="40" MaxLength="4">
							</asp:TextBox>
                             <asp:HiddenField runat="server" ID="hdnSort" Value='<%#DataBinder.Eval(Container.DataItem,"ImageSort").tostring%>' />
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid>
            </asp:Panel>
            
            <asp:Panel ID="ThumbPanel" runat="server">
            <asp:Repeater runat="server" id="repeater1">
                <HeaderTemplate>
                    <div class="normal">
                        <ul  id="sortable">
                </HeaderTemplate> 
                <ItemTemplate>
                </ItemTemplate>
                <FooterTemplate>
                        </ul>
                        </div>
                 </FooterTemplate>
            </asp:Repeater>
            <input type="hidden" id="hdnChanged" name="hdnChanged" value="0" />
            <input type="hidden" id="hdnSortOrder" name="hdnSortOrder" />
            </asp:Panel>

		</form>

         <script type="text/javascript">

             $(".TableHeader").addClass("nodrag");
             $(".TableHeader").addClass("nodrop");
             $('input[name*="txtSort"]').bind('blur', function () {
                 sortRows(this);
             });

             $(document).ready(function () {
                 $("#DataGrid1").tableDnD({
                     onDrop: processRowDrop,
                     onCancel: repaintRows,
                     onDragClass: null,
                     onDragStyle: { "background-color": "#6495ED", "cursor": "url(../System/Cursor/closedhand.cur)" }
                 })
             });

             /** Changing the background color to make the table look consistent */
             function repaintRows(table, row) {
                 for (var i = 1, currentRow; currentRow = table.rows[i]; i++) {
                     if (i % 2 == 0) {
                         $(currentRow).css("background-color", "aliceblue");  // Alternating item style
                     } else {
                         $(currentRow).css("background-color", "white");  // Item style
                     }
                 }
             }

             function processRowDrop(table, row) {
                 repaintRows(table, row);
                 for (var i = 1, currentRow; currentRow = table.rows[i]; i++) {
                     /** Recalculating sorts */
                     var sortInput = $(currentRow).find('input[name*="txtSort"]'); // Getting the txtSort for current row
                     var hdnSort = $(currentRow).find('input[name*="hdnSort"]');
                     var newSort = "0000" + i.toString(); // Generating the new sort for it
                     newSort = newSort.substr(newSort.length - 4, 4); // Rough implementation of RIGHT
                     sortInput.val(newSort);
                     hdnSort.val(newSort);
                 }
             }

             /** Rearranges the rows after the manual change of sort */
             function sortRows(txtSort) {
                 var draggingRow = $(txtSort).closest('tr'); // Getting the current table row
                 var hdnOldSort = draggingRow.find('input[name*="hdnSort"]');
                 // Checking, if sort was changed
                 var strNewSort = $(txtSort).val();
                 var strOldSort = hdnOldSort.val();
                 if (parseInt(strNewSort, 10) == parseInt(strOldSort, 10)) {
                     $(txtSort).val(strOldSort);
                     return;
                 }
                 // If the sort was changed, begining replacing
                 var newSort = parseInt(strNewSort, 10); // Getting the changed row sort (as integer)
                 var currentTable = $(txtSort).closest('table'); // Getting the current table
                 if (isNaN(newSort)) {
                     newSort = 0;
                 }
                 // Checking all the rows in the table
                 var allRows = currentTable.get(0).rows;
                 var wasInserted = false;

                 var lastRowVal = parseInt(currentTable.find('tr:last').find('input[name*="txtSort"]').val(), 10);
                 var lastRow = currentTable.find('tr:last');

                 if (newSort == lastRowVal && draggingRow.html() != lastRow.html()) {
                     draggingRow.insertAfter(currentTable.find('tr:last')); // And inserting our row before it
                     wasInserted = true;

                 }
                 if (newSort > lastRowVal && draggingRow.html() != lastRow.html()) {
                     draggingRow.insertAfter(currentTable.find('tr:last')); // And inserting our row before it
                     wasInserted = true;

                 }
                 if (!wasInserted) {
                     for (var i = 0, currentRow; currentRow = allRows[i]; i++) {
                         // Getting the sort from row
                         var txtCurrentSort = $(currentRow).find('input[name*="txtSort"]');
                         var currentSort = parseInt($(txtCurrentSort).val(), 10);
                         if (isNaN(currentSort)) {
                             currentSort = 0;
                         }

                         if (currentSort == newSort && newSort == parseInt($(currentRow).find('input[name*="hdnSort"]').val(), 10)) {
                             if (newSort > parseInt(strOldSort, 10)) {
                                 draggingRow.insertAfter($(currentRow));
                             }

                             if (newSort < parseInt(strOldSort, 10)) {
                                 draggingRow.insertBefore($(currentRow));
                             }
                             wasInserted = true;
                             break;
                         }
                         // Searching for the row with the sort, bigger then entered by user
                         if (currentSort > newSort) {
                             draggingRow.insertBefore($(currentRow)); // And inserting our row before it
                             wasInserted = true;
                             break;
                         }
                     }
                 }

                 var lastRow = currentTable.find('tr:last');
                 if (!wasInserted && draggingRow.html() != lastRow.html()) { // If edited item now has the bigger sort of all, we inserting it at the end of the table
                     var lastRow = currentTable.find('tr:last');
                     draggingRow.insertAfter(lastRow);
                 }

                 // Setting the consistent value in the textbox
                 var strNewSort = "0000" + newSort.toString();
                 strNewSort = strNewSort.substr(strNewSort.length - 4, 4); // Rough implementation of RIGHT
                 $(txtSort).val(strNewSort);
                 // Changing the hidden value
                 hdnOldSort.val(strNewSort);
                 // Repainting the table
                 // repaintRows($("#DataGrid1").get(0), draggingRow);
                 processRowDrop($("#DataGrid1").get(0), draggingRow);
                 // Centering the element on screen
                 var rowTop = draggingRow.offset().top;
                 var documentHeight = $(document).height();
                 var windowHeight = $(window).height();
                 if ((documentHeight - rowTop) < windowHeight / 2) {
                     $(document).scrollTop(draggingRow.offset().top);
                 } else {
                     $(document).scrollTop(draggingRow.offset().top - windowHeight / 2);
                 }
                 $(txtSort).focus();
             }

            </script>
	</body>
</HTML>
