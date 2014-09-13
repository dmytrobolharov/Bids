<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Planning_Folder_FlashEdit_Style.ascx.vb" Inherits="plmOnApp.Planning_Folder_FlashEdit_Style" %>
<%@ Register src="Planning_Folder_ViewStyle2Flash.ascx" TagName="Plan" tagprefix="lc1" %>

<table height="15" cellSpacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
	<tr>
		<td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
		<td width="100%" valign="top">
			<table id="Table3" height="45">
				<tr>
					<td>
						<asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<lc1:Plan id="ctrPlanning" runat="server" ></lc1:Plan>