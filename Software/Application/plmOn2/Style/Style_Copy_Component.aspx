<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Copy_Component.aspx.vb" Inherits="plmOnApp.Style_Copy_Component" %>
<%@ Register TagPrefix="uc1" TagName="Style_Copy_Workflow" Src="Style_Copy_Workflow.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="Style_Header.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>Material Summary</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton 
					    id="btnCopy" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					    id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<uc1:Style_Copy_Workflow id="Style_Copy_Workflow1" runat="server"></uc1:Style_Copy_Workflow>
			<uc1:Style_Header id="Style_Header1" runat="server"></uc1:Style_Header>
			<br>
			<table cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblMaterialHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Copy Material</asp:label></td>
				</tr>
			</table>
			<table class="TableHeader" cellspacing="0" cellpadding="0" width="30%" border="0">
                <tr>
                    <td class="FontHead" align="right" width="50%">
                        &nbsp;<%=GetSystemText("Select Set")%>:
                    </td>
                    <td align="left">
                        <asp:DropDownList ID="dpStyleSet" runat="server" CssClass="font" DataTextField="Value"
                            DataValueField="ID" AutoPostBack="true">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
			<asp:datagrid id="DataGrid1" runat="server" AutoGenerateColumns="False" PageSize="100"
				BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver" DataKeyField="StyleMaterialID">
				<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<input id="checkAll" onclick="CheckAll(this);" type="checkbox" name="checkAll" runat="server" />
						</HeaderTemplate>
						<ItemTemplate>
							<asp:CheckBox id="chkSelect" runat="server" />
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid></form>
			
		<script type="text/javascript" language="javascript">
		    var frm = document.Form1;
		    function CheckAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chkSelect") != -1)
		                e.checked = actVar;
		        }
		    }
		</script>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
