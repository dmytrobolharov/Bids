<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Style_WorkFlowItem.ascx.vb" Inherits="plmOnApp.Style_WorkFlowItem" %>
<link href="../System/CSS/jquery-ui.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.8.3.min.js"></script>
<script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>

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
				    <td align="right" style="white-space: nowrap;">
		               <cc1:BWImageButton id="imgLinkItem" visible="false" backcolor="Red" style='border-width:1px;' Width="20px" runat="server" />
                       <img id="imgMeasLink" alt="" visible="false" style="border: 0; cursor:pointer;" runat="server" src="../System/Icons/icon_link.gif" />
				    </td>         
                </tr>
            </table>
        </td>
	</tr>
</table>