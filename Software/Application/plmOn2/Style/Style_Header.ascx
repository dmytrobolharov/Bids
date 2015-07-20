<%@ Control Language="vb" AutoEventWireup="false" Codebehind="Style_Header.ascx.vb" Inherits="plmOnApp.Style_Header" TargetSchema="http://schemas.microsoft.com/intellisense/ie5" %>
<link href="../System/CSS/Style.css" rel="stylesheet" type="text/css">
<table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
	<tr class='<%=GetTableHeaderClass() %>'>
		<td vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		<td width="20">
		    <img id="imgBtnExp" onclick="return ShowHeaderContent(this)" style="cursor:pointer"  src="../System/Icons/icon_Next.gif" />
		    <img id="imgBtnCol" onclick="return HideHeaderContent(this)" style="cursor:pointer" src="../System/Icons/icon_Down.gif" />
		</td>
		<td class="fontHead">
			<asp:label id="lblHeaderDetail" runat="server"></asp:label>
		</td>
	</tr>
</table>
<div id="divHeaderContent" style="display:none">
		
    <table id="Table1" cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="#ffffff">
	    <tr>
		    <td width="900">
			    <asp:placeholder id="plhStyleHeaderControl" runat="server"></asp:placeholder></td>
	    </tr>
    </table>


</div>
