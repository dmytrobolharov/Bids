<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_ColorPalette_Colors.aspx.vb" Inherits="plmOnApp.Material_ColorPalette_Colors" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register assembly="YSTab" namespace="Yunique.WebControls.YSTab" tagprefix="cc2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title>Palette</title>
    <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />		
    <link href="../System/CSS/Grid.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Tree.css" rel="stylesheet" type="text/css" />  
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    	<TABLE class="TableHeader" id="TABLE1" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
			<TR vAlign="middle">
				<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
				<td valign="top">
				    <asp:imagebutton id="btnInvSearch" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton>
				    <asp:imagebutton id="btnBack" runat="server" ></asp:imagebutton>
				    <asp:imagebutton ID="btnClose" runat="server"   OnClientClick="return btnClose_Click()"/>
                </td>
				<td width="75">&nbsp;</td>
				<td align="right"></td>
			</TR>
		</TABLE>    	     
        <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr><td><asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td></tr>
		</table>
	    <cc2:YSTabView ID="YSTabView1" runat="server" />
        <TABLE class="TableHeader TableFloatHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
			<TR vAlign="middle">
				<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
				<td valign="top">
				    <asp:imagebutton id="btnAdd" runat="server" ></asp:imagebutton>
					<asp:imagebutton id="btnAddColor" runat="server" ></asp:imagebutton>
                    <cc1:ConfirmedImageButton ID="btnDelete" runat="server"  />
                </td>
				<td width="75">&nbsp;</td>
				<td align="right"></td>
			</TR>
		</TABLE>    	     
		<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
			<tr>
				<td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
				<td width="100%" valign="top">
					<table id="Table3" height="45">
						<TR><TD><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></TD></TR>
					</table>
				</td>
			</tr>
		</table>    
        <table id="Table2" border="0" cellpadding="0" cellspacing="0" class="TableHeader" height="20" width="100%" style="background-position:center;">
            <tr class="fontHead">
                <td align="center" height="25" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
                <td height="25" width="20">
                    <div align="center"><asp:imagebutton id="btnImgFirstRecord" runat="server" ImageUrl="../System/Icons/icon_first.gif" style="width: 16px"></asp:imagebutton></div>
                </td>
                <td height="25" width="20">
                    <div align="center"><asp:imagebutton id="btnImgPreviousRecord" runat="server" ImageUrl="../System/Icons/icon_Previous.gif" ></asp:imagebutton></div>
                </td>
                <td height="25" width="125">
                    <div align="center"><asp:Label ID="lblCounts" Runat="server" CssClass="plaintable"></asp:Label></div>
                </td>
                <td height="25" width="20">
                    <div align="center"><asp:imagebutton id="btnImgNextRecord" runat="server" ImageUrl="../System/Icons/icon_next.gif" ></asp:imagebutton></div>
                </td>
                <td height="25" width="20">
                    <div align="center"><asp:imagebutton id="btnImgLastRecord" runat="server" ImageUrl="../System/Icons/icon_last.gif" ></asp:imagebutton></div>
                </td>
                <td height="25">
                    <div align="left"><b><asp:Label ID="lblRecordCount" Runat="server" Visible="true"></asp:Label>
                    &nbsp;<asp:Label ID="lblRecordsFound" runat="server" Text="Records Found"></asp:Label></b></div>
                </td>
                <td height="25">
                    <p align="right">
                        <asp:DropDownList ID="ddlSortField" runat="server"></asp:DropDownList>
                        <asp:DropDownList ID="ddlSortBy" runat="server">
                            <asp:ListItem Value="ASC">ASC</asp:ListItem>
                            <asp:ListItem Value="DESC">DESC</asp:ListItem>
                        </asp:DropDownList>
                        <asp:ImageButton ID="btnSort" runat="server" ImageUrl="../System/Icons/icon_sort.gif" />
                    </p>
                </td>
            </tr>
        </table>
        <table class="TableHeader" cellpadding="0" cellspacing="0" width="100%" id="tablechk" runat="server" >
            <tr>
                <td align="center" height="25" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
                <td valign="top" align="left">
                    <asp:Checkbox onclick="SelectAll(this)" id="chkSelectAll" runat="server" />
                    <asp:Label ID="lblcheck" runat="server">Check all Colors</asp:Label>
                </td>
            </tr>
        </table>
        
        <asp:HiddenField ID="hdnCurrentIndex" Value="0" runat="server" />
        <asp:HiddenField ID="hdnPageSize" Value="50" runat="server" />
        <table border="0" bordercolor="gainsboro" cellpadding="0" cellspacing="1">
            <tr><td valign="top">
                <asp:DataList ID="Datalist1" runat="server" EnableViewState="False" RepeatColumns="1"
                BorderColor="Gray" BorderWidth="1px" CellPadding="2" GridLines="Both" DataKeyField="ColorPaletteID">
                    <ItemStyle BackColor="White" BorderColor="Gainsboro" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" VerticalAlign="Top" />
                    <ItemTemplate><div onclick="CheckColor(this)"></div></ItemTemplate>
                </asp:DataList>
                </td>
                <td valign="top">
                    <asp:datagrid id="dgSeasonYear" runat="server"  EnableViewState="False" DataKeyField="SeasonYearID">
                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                        <headerStyle Height="20px" CssClass="TableHeader"></headerStyle>
                        <PagerStyle Visible="False"></PagerStyle>
                        <Columns>
                            <asp:TemplateColumn><ItemTemplate><asp:CheckBox runat="server" ID="chkSelect" /></ItemTemplate></asp:TemplateColumn>
                        </Columns>
                    </asp:datagrid>
                </td>                    
            </tr>
        </table>

		<script language="javascript" type="text/javascript">
		    var frm = document.form1;
		    function SelectAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];		            
		            if (e.type == 'checkbox' && e.name.indexOf("chkColorSelect") != -1)
		                e.checked = actVar;
		        }
		    }

		    $(":checkbox[id$='chkColorSelect']").closest('table').click(function (e) {
		        var chkColorSelect = $(this).find(":checkbox[id$='chkColorSelect']").get(0);
		        if (chkColorSelect && e.target.id != chkColorSelect.id) chkColorSelect.checked = !chkColorSelect.checked;
		    })
            function btnClose_Click() {
                        <%= strExitScript %>
                        return false;
                    }
		</script>	            
            				
    </form>
</body>
</html>
