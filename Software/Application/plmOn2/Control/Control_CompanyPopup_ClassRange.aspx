<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_CompanyPopup_ClassRange.aspx.vb" Inherits="plmOnApp.Control_CompanyPopup_ClassRange" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<HEAD>
		<title runat="server" id="PageTitle">Size Class</title>
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	</HEAD>
<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="TableHeader" cellSpacing="0" cellPadding="0" width="100%"
				border="0" runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><cc1:confirmedimagebutton id="imgBtnsave" runat="server" ToolTip="Save..." 
							Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server" ToolTip=""
							 Message="NONE"></cc1:confirmedimagebutton></TD>
				</TR>
			</TABLE>
			<TABLE style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<TBODY>
					<tr><td valign="middle">&nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label>
                     </td></tr>
				</TBODY>
			</TABLE>
			<table class="TableHeader" height="20" cellspacing="0" cellpadding="0" width="100%"  border="0">
                <tr class="fontHead">
                    <td align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                    <td class="fontHead" width="50"><div align="right"><asp:Label ID="lblSearch" runat="server"></asp:Label></div></td>
                    <td width="75"><asp:TextBox ID="txtSearch" runat="server" CssClass="font"></asp:TextBox></td>
                    <td width="10"><asp:ImageButton ID="btnImgSearch" runat="server" ImageUrl="../System/Icons/icon_search.gif" CausesValidation="False"></asp:ImageButton></td>
                    <td><div align="left">&nbsp;<asp:Label ID="lblCurrentIndex" Text="0" Visible="False" runat="server"></asp:Label><asp:Label
                                ID="lblPageSize" Text="24" Visible="False" runat="server"></asp:Label></div>
                    </td>
                    <td width="10"><div align="center"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></div>
                    </td>
                    <td width="10"><div align="center"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></div>
                    </td>
                    <td width="150"><div align="center"><asp:Label ID="lblCounts" runat="server" CssClass="plaintable"></asp:Label></div></td>
                    <td width="10"><div align="center"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></div>
                    </td>
                    <td width="10"><div align="center"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></div>
                    </td>
                    <td><div align="left"><b><asp:Label ID="lblRecordCount" runat="server" Visible="true"></asp:Label>&nbsp;<asp:Label
                        ID="lblRecCount" runat="server" Visible="true">Records Found</asp:Label></b></div></B>
                    </td>
                </tr>
            </table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td><asp:datagrid id="DataGrid1" runat="server" DataKeyField="SizeClassGuidID" OnItemDataBound="DataGrid1_ItemEventArgs"
							AutoGenerateColumns="false" Width="100%">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							
							<Columns>
								<asp:TemplateColumn HeaderStyle-Width="50">
									<HeaderTemplate>
										<input type="checkbox" id="checkAll" onclick="CheckAll(this);" runat="server" NAME="checkAll">
									</HeaderTemplate>
									<ItemTemplate>
										<asp:CheckBox id="chkSelect" runat="server"></asp:CheckBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn HeaderStyle-Width="75">
									<HeaderTemplate>										
									</HeaderTemplate>
									<ItemTemplate>
										<asp:Label ID="txtSizeClass" Runat="server"><%#Container.DataItem("SizeClass")%></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>						
						</asp:datagrid></td>
				</tr>
			</table>
			
		</form>
		<script language="javascript">
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
</body>
</html>
