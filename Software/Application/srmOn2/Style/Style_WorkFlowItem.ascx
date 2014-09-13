
<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Style_WorkFlowItem.ascx.vb" Inherits="srmOnApp.Style_WorkFlowItem" %>
<table class="TableHeader" height="27" cellSpacing="0" cellpadding="0" width="100%" border="0">
	<tr valign="middle">
		<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
        <td>
            <table>
                <tr>
		            <td class="fontHead" valign="middle" align="right">
		                &nbsp;
		            </td>
		            <td align="left" >
		                <asp:Label CssClass="font" ID="lblWorkflowTypeValue" runat="server" />
				     </td>
				     <td class="font">&nbsp;:&nbsp;</td>
		            <td align="right">
		                <asp:dropdownlist id="dpWokflowItem" runat="server" AutoPostBack="true" DataValueField="ID" DataTextField="Value" CssClass="font"></asp:dropdownlist>
				    </td> 
				    <td align="right">
		               <asp:imagebutton id="imgLinkItem" visible="false" backcolor="Red" style='border-width:1px;' Width="20px" runat="server" ImageUrl="../System/Icons/icon_link.gif"></asp:imagebutton>
				    </td>         
                </tr>
            </table>
        </td>
	</tr>
</table>