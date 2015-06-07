<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Planning_Folder_ViewSearch.ascx.vb" Inherits="plmOnApp.Planning_Folder_ViewSearch" %>

<!--<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
	runat="server">
	<tr vAlign="middle">
		<td vAlign="middle" align="center" width="10" height="25"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
		<td></td>
	</tr>
</table>-->
<table height="15" cellSpacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
	<tr>
		<td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
		<td width="100%" valign="top">
			<table id="Table3" height="45">
				<tr>
					<td>
						<asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton>
                    </td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<asp:placeholder id="phStyle" runat="server"></asp:placeholder>