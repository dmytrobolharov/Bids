<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_CostSheetItems_Compare.aspx.vb" Inherits="plmOnApp.Style.CostingEnhanced.Style_CostSheetItems_Compare" ResponseEncoding="UTF-8" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
	<head>
		<title>Compare Scenarios</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/CostingStyles.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/CostingScripts.js"></script>
        <!--link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" /-->
        <style type="text/css">
            .Underlined td
            {
            	border-bottom-style: Solid;
            	border-bottom-width: 2px;
            	border-bottom-color: #000;
            }

        </style>
	</head>
	<body>
     <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10" style="height: 28px"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="600" style="height: 28px">
                            <cc1:BWImageButton id="btnPreview" runat="server" />		
							<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" />
					</td>					
				</tr>
			</table>
            <br/>
            <uc2:style_header id="Style_Header1" runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>	
			<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>	
            <table id="CostGridHeader" runat="server" border="1" style="border-collapse:collapse; border-color:#E0E0E0" cellspacing="0"></table>
            <div id="GridArea" runat="server">

                    <!-- SQL-driven DataGrid. WARNING! DataKey for this grid is the name of the column in database -- thanks PIVOT for this -->
                    
                    <asp:DataGrid ID="UnitsCosting" runat="server" BorderColor="#E0E0E0" 
                        BorderStyle="Solid" BorderWidth="2px" AutoGenerateColumns="true">
                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
						<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
						<HeaderStyle Height="0px"></HeaderStyle>
                        <Columns>
                        </Columns>
                    </asp:DataGrid>
                    <asp:HiddenField runat="server" ID="hdnCountScenarios" Value="0" />

            <!-- Here we gone.-->
            </div>
			<table id="Table3" height="24" cellspacing="0" cellpadding="0" width="100%" border="0"
			runat="server">
			    <tr valign="middle">
				    <td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></td>
				    <td class="TableBar" valign="middle" align="center" width="20"><IMG src="../System/icons/icon_changeobject.gif"></td>
				    <td class="TableBar"><asp:label id="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:label>&nbsp;/
					    <asp:label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:label></td>
				    <td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></td>
			    </tr>
		    </table>
		</form>
        <script type='text/javascript'>

            // Insert empty row after every row, marked as GridGroupEnd, for creating visual spaces
            var countScenarios = document.getElementById("hdnCountScenarios").value;
            countScenarios = parseInt(countScenarios,10) + 1
            var blankRow = '<TR style="HEIGHT: 10px"><TD colspan = "' + countScenarios + '">&nbsp;</TD></TR>';
            $(".GridGroupEnd").after(blankRow);

            /*** Processing the scroll area for grids -- fitting it's height ***/
            resizeGridScrollArea();
            $(window).resize(function () { resizeGridScrollArea(); });

        </script>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
