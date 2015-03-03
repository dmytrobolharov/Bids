<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_DetailGrid_Custom_Delete.aspx.vb" Inherits="plmOnApp.Control_DetailGrid_Custom_Delete" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Delete</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
			<TABLE class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TBODY>
					<TR vAlign="middle">
						<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
						<TD vAlign="middle" align="left" width="400"><cc1:confirmedimagebutton id="btnDelete" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></TD>
						<TD></TD>
					</TR>
				</TBODY>
			</TABLE>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>
			<br />
			<asp:CheckBox runat="server"  ID="chbDeleteAll"    CssClass="fontRed"  Font-Bold="true" />
			<br /><br />
			<asp:datagrid id="DataGrid1" runat="server" Width="300px" BorderColor="#E0E0E0" BorderStyle="Solid"
				BorderWidth="1px" PageSize="100" AutoGenerateColumns="False" DataKeyField="TemplateDetailGridItemId">
				<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderStyle CssClass="TableHeaderRed" Width="20"></HeaderStyle>
						<ItemStyle BackColor="Pink"></ItemStyle>
						<HeaderTemplate>
							<input id="checkAll1" onclick="CheckAll(this);" type="checkbox" >
						</HeaderTemplate>
						<ItemTemplate>
							<asp:CheckBox id="chkDelete" runat="server" ToolTip='<%#GetSystemText("Remove item") %>...'></asp:CheckBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<asp:Label id="lblSize" runat="server"></asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<%#DataBinder.Eval(Container.DataItem,"TemplateDetailCustom1").tostring%>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid>

		    <script language="javascript">
		        var frm = document.form1 ;
		        function CheckAll( checkAllBox ) 	{
			        var actVar = checkAllBox.checked ;
			        for(i=0;i< frm.length;i++)	{
				        e=frm.elements[i];
				        if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
					        e.checked= actVar ;
			        }
		        }
		    </script>
			
			
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
