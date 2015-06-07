<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_Request_Workflow_Wizard_ColorSelect.aspx.vb" Inherits="plmOnApp.Material_Request_Workflow_Wizard_ColorSelect" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc2" TagName="Material_Header" Src="Material_Header.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title>Material Colors</title>
    <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />		
    <link href="../System/CSS/Grid.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Tree.css" rel="stylesheet" type="text/css" />    
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
 <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server">
			<table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr class="TableHeader">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="20"><asp:imagebutton id="imbBtnExpand" runat="server" ImageUrl="../System/Icons/icon_Next.gif" ToolTip="Show Material Header..."></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif" ToolTip="Hide Material Header..." Visible="false"></asp:imagebutton></td>
					<td class="fontHead">&nbsp;
						<asp:label id="lblMaterialDetail" runat="server"></asp:label></td>
				</tr>
			</table>
			<asp:panel id="Panel1" runat="server" CssClass="font" BorderWidth="0" BackColor="#ffffff" Width="100%" Visible="false">
				<table height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
					<tr>
						<td width="900">
							<uc2:Material_Header id="Material_Header1" runat="server"></uc2:Material_Header></td>
						<td>&nbsp;</td>
					</tr>
				</table>
			</asp:panel>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" 
                            Font-Size="X-Large" ForeColor="Gray">Select Season and Color...</asp:label></td>
				</tr>
			</table>	
			<table  style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: gainsboro"
	            height="35" cellSpacing="0" cellPadding="0" width="100%" bgColor="gainsboro" border="0">
	            <TR>
		            <TD align="center" width="50">&nbsp;</TD>
		            <TD align="center" width="500">
			            <asp:imagebutton id="btnBack" runat="server"></asp:imagebutton>
			            <asp:imagebutton id="btnNext" runat="server" ></asp:imagebutton>
		            </TD>
		            <TD align="center">&nbsp;</TD>
	            </TR>
            </table>
			<table height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td><asp:Image runat="server" ID="imgSeason" ImageUrl="../System/icons/icon_season.gif" />&nbsp;&nbsp;<asp:Label 
			ID="lblSeasonYear" runat="server" CssClass="fontHead">Season & Year</asp:Label><asp:DropDownList 
			runat="server" ID="ddlSeasonYearID" AutoPostBack="true" ></asp:DropDownList></td>
				</tr>
			</table>			
            
                <asp:datagrid id="Datagrid1" runat="server"
                DataKeyField="MaterialColorSeasonYearID" AllowSorting="true" AutoGenerateColumns="False" BackColor="White" >
                <PagerStyle  Visible="false"/>
                <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
                <ItemStyle Height="20px" CssClass="font"></ItemStyle>
                <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                <Columns > 
                    <asp:TemplateColumn>
                        <HeaderTemplate>
                            <input type="checkbox" id="checkAll" onclick="CheckAll(this);" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox runat="server" ID="chkSelect" /><input type="hidden" id="hdnSizeID" runat="server" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
            </asp:datagrid>	
            
            <asp:Label runat ="server" ID="SortOrder" Visible="false" ></asp:Label>
                          		
            <br />
          

    </form>
    
		<script language="javascript">
		    var frm = document.form1;
		    function CheckAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chkSelect") != -1)
		                e.checked = actVar;
		        }
		    }
		</script>        
		
</body>
</html>
