<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Material_List_Image.ascx.vb" Inherits="plmOnApp.Material_List_Image" %>
<%@ Register TagPrefix="ys001" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<asp:HiddenField ID="hdnCurrentIndex" Value="0" runat="server" />
<asp:HiddenField ID="hdnPageSize" Value="25" runat="server" />
<table class="TableHeader" id="Table2" height="20" cellspacing="0" cellpadding="0" width="100%"
	border="0">
	<tr class="fontHead">
		<td align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
		<td width="20" height="25">
			<div align="center"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></div>
		</td>
		<td width="20" height="25">
			<div align="center"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></div>
		</td>
		<td width="125" height="25">
			<div align="center"><asp:label id="lblCounts" Runat="server" CssClass="plaintable"></asp:label></div>
		</td>
		<td width="20" height="25">
			<div align="center"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></div>
		</td>
		<td width="20" height="25">
			<div align="center"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></div>
		</td>
		<td height="25">
			<div align="left"><b><asp:label id="lblRecordCount" Visible="False" Runat="server"></asp:label>&nbsp;<asp:Label
                    ID="RecordCount" runat="server" ></asp:Label></b></div>
			</B></td>
		<td height="25">
			<P align="right" style="margin:auto"><asp:dropdownlist id="ddlSortField" runat="server"></asp:dropdownlist>
				<asp:dropdownlist id="ddlSortBy" runat="server">
					
				</asp:dropdownlist>
				<asp:ImageButton id="btnSort" runat="server" ImageUrl="../System/Icons/icon_sort.gif"></asp:ImageButton></P>
		</td>
	</tr>
</table>

<table bordercolor="gainsboro" cellspacing="1" cellpadding="0" border="0">
	<tr>
		<td vAlign="top"><asp:datalist id="Datalist1" runat="server" DataKeyField="MaterialID" RepeatLayout="Table" RepeatColumns="1"
				RepeatDirection="Horizontal" EnableViewState="false">
				<ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="Gainsboro" VerticalAlign="Top" BackColor="White"></ItemStyle>
				<ItemTemplate>

				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left" ></HeaderStyle>
			</asp:datalist></td>
	</tr>
</table>

