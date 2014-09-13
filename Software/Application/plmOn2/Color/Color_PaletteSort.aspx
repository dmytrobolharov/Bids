<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Color_PaletteSort.aspx.vb" Inherits="plmOnApp.Color_PaletteSort" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
	<head runat="server">
		<title runat="server" id="PageTitle">Palette</title>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery.tablednd.js"></script>
         <script src="../System/Jscript/jquery-1.8.0.js"></script>
        <script src="../System/Jscript/jquery.ui.core.js"></script>
	    <script src="../System/Jscript/jquery.ui.widget.js"></script>
	    <script src="../System/Jscript/jquery.ui.mouse.js"></script>
	    <script src="../System/Jscript/jquery.ui.sortable.js"></script>
        <script src="../System/Jscript/jquery.ui.touch-punch.min.js"></script>
        <link href="../System/CSS/jquery-sortable.css" rel="stylesheet" />
         <style type="text/css">
            .dropimage
            {
            	background-image: url('../System/Icons/dragndrop.jpg');
            	background-repeat:no-repeat;
            	background-position:center;
            	width: 10px;
            }
            #DataGrid1 td
            {
            	z-index:2;
            }
            #DataGrid1 td span
            {
            	z-index:1;
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
            var hdnOldSort = draggingRow.find('input[name*="hdnort"]');
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

            var lastRowVal = parseInt(currentTable.find('li:last').find('input[name*="txtSort"]').val(), 10);
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
                        var txtCurrentSort = $(this).find('input[name*="txtSort"]');
                        var currentSort = parseInt($(txtCurrentSort).val(), 10);
                        if (isNaN(currentSort)) {
                            currentSort = 0;
                        }

                        if (currentSort == newSort && newSort == parseInt($(this).find('input[name*="hdnort"]').val(), 10)) {
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
                $(this).find('table').find('input[id*="txtSort"]').val(newSort);
                $(this).find('table').find('input[name*="hdnort"]').val(newSort);
                i++;
            });
            $(txtSort).focus();
        }

        $(window).load(function () {
            $('.ui-state-default').mousedown(function () { $(this).css('cursor', 'url(../System/Cursor/closedhand.cur)'); });

            $('.ui-state-default').mouseup(function () { $(this).css('cursor', 'url(../System/Cursor/openhand.cur)'); });





            //hide id field
            $('li').each(function () {
                $(this).find('table').find('input[id*="ColorPaletteID"]').closest('tr').hide();

                //$(this).find('table').find('input[id*="LineFolderItemSort"]').insertAfter('<input type="hidden" name="hdnsort" value="' + $(this).find('table').find('input[id*="LineFolderItemSort"]').val() + '"/>');
                $('<input type="hidden" name="hdnort" value="' + $(this).find('table').find('input[id*="txtSort"]').val() + '"/>').insertAfter($(this).find('table').find('input[id*="txtSort"]'));


            });

            $('li').each(function () {

                $(this).find('table').find('input[id*="txtSort"]').bind('blur', function () {
                    sortRows2(this);
                });
            });

            var it = 0;
            $('li').each(function () {
                //set new sort order for thumbnail view

                var newSort = "0000" + (it + 1).toString()
                newSort = newSort.substr(newSort.length - 4, 4);
                $(this).find('table').find('input[id*="txtSort"]').val(newSort);
                //$(this).find('table').find('input[id*="LineFolderItemSort"]').attr("width", "50px");
                $(this).find('table').find('input[id*="txtSort"]').css("width", "50px");

                /*  $(this).find('table').find('td').each(function () {
                $(this).css("white-space", "pre-wrap");

                });

                $(this).find('table').find('tr').each(function () {
                $(this).find('td:odd').css("width", "70px");

                });*/


                $(this).find('table').find('input[name*="hdnort"]').val(newSort);
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
                        $(this).find('table').find('input[id*="txtSort"]').val(newSort);
                        $(this).find('table').find('input[name*="hdnort"]').val(newSort);
                        i++;
                    });
                }
            });
            $("#sortable").disableSelection();


        });
        </script>
	</head>
	<body>
	    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
            <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
	            <tr>
		            <td align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td> 
		            <td width="50"><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
                    <td width="50"><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
		            <td width="50">&nbsp;</td>
		            <td align="right" width="75"><asp:label id="lblSortBy" Runat="server" CssClass="font"><b>&nbsp;Sort by:</b></asp:label></td>
                    <td width="50"><asp:dropdownlist id="ddlSortBy" Runat="server"></asp:dropdownlist></td>
                    <td width="50"><cc1:confirmedimagebutton id="btnSort" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
		            <td>&nbsp;</td>
	            </tr>
            </table>
          <!--  <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
	            <tr>
		            <td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		            <td class="fonthead" height="20"><asp:label id="lblHeader" runat="server" CssClass="fonthead" Text="Color List..."></asp:label></td>
	            </tr>
            </table>	-->		
			<!--<table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table height="45">
							<tr>
								<td>
									<asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>    -->        
            <table cellspacing="0" cellpadding="0" width="100%" border="0">
	            <tr valign="top">
		            <td>
			            
            			
			            <table width="100%" >
			            <tr>
			                <td>

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

                                <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
			                    <input type="hidden" runat="server" id="hiddenCurrentPage"  value="0"/>
			                </td>
			            </tr>
			            </table>
            			
		            </td>
	            </tr>
            </table>
	
			
		</form>
		
            

           
	</body>
</HTML>
