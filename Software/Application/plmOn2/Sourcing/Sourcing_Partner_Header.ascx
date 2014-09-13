<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_Partner_Header.ascx.vb" Inherits="plmOnApp.Sourcing_Partner_Header" %>
<link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />
<table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
    <tr class="TableHeader">
        <td valign="middle" align="center" width="10">
            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
        </td>
        <td width="20">
            <asp:ImageButton ID="imgBtnExp" OnClientClick="return ShowPartnerHeaderContent(this)" runat="server" ImageUrl="../System/Icons/icon_Next.gif">
            </asp:ImageButton>
            <asp:ImageButton ID="imgBtnCol" OnClientClick="return HidePartnerHeaderContent(this)" runat="server" ImageUrl="../System/Icons/icon_Down.gif">
            </asp:ImageButton>
        </td>
        <td class="fontHead">
            <asp:Label ID="lblHeaderDetail" runat="server"></asp:Label>
        </td>
    </tr>
</table>
<div id="divPartnerHeaderContent" style="display: none">
    <table id="Table1" cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="#ffffff">
        <tr>
            <td width="33%">
                <asp:Panel ID="pnlAgent" runat="server">
                    <div>
                        <span style="display:inline-block; color: #e0e0e0; font-family: Tahoma,Verdana; font-size: x-large; width:125px;"><%= GetSystemText("Agent")%></span>
                        <asp:CheckBox ID="ShareAgent" OnClick="AgentCheck()" runat="server" style="color:Red; font-family: Tahoma,Verdana; font-weight:bold;" />
                    </div>
                    <asp:PlaceHolder ID="plhAgent" runat="server"></asp:PlaceHolder>
                </asp:Panel>
            </td>
            <td width="33%">
                <asp:Panel ID="pnlVendor" runat="server">
                    <div>
                        <span style="display:inline-block; color: #e0e0e0; font-family: Tahoma,Verdana; font-size: x-large; width:125px;"><%= GetSystemText("Vendor")%></span>
                        <asp:CheckBox ID="ShareVendor" OnClick="VendorCheck()" runat="server" style="color:Red; font-family: Tahoma,Verdana; font-weight:bold;" />
                    </div>
                    <asp:PlaceHolder ID="plhVendor" runat="server"></asp:PlaceHolder>
                </asp:Panel>
            </td>
            <td width="33%">
                <asp:Panel ID="pnlFactory" runat="server">
                    <div>
                        <span style="display:inline-block; color: #e0e0e0; font-family: Tahoma,Verdana; font-size: x-large; width:125px;"><%= GetSystemText("Factory")%></span>
                        <asp:CheckBox ID="ShareFactory" OnClick="FactoryCheck()" runat="server" style="color:Red; font-family: Tahoma,Verdana; font-weight:bold;" />
                    </div>
                    <asp:PlaceHolder ID="plhFactory" runat="server"></asp:PlaceHolder>
                </asp:Panel>
            </td>
        </tr>
    </table>
</div>

<SCRIPT language="javascript">
    function FactoryCheck() {
        if ($("#<%=ShareFactory.ClientID %>")[0].checked == true) {
	        if ($("#<%=ShareAgent.ClientID %>")[0]) { $("#<%=ShareAgent.ClientID %>")[0].checked = true; }
	        if ($("#<%=ShareVendor.ClientID %>")[0]) { $("#<%=ShareVendor.ClientID %>")[0].checked = true; }
        }
	}
	function VendorCheck() {
	    if ($("#<%=ShareVendor.ClientID %>")[0].checked == true) {
	        if ($("#<%=ShareAgent.ClientID %>")[0]) { $("#<%=ShareAgent.ClientID %>")[0].checked = true; }
	    } else {
	        if ($("#<%=ShareFactory.ClientID %>")[0]) { $("#<%=ShareFactory.ClientID %>")[0].checked = false; }
	    }
	}
	function AgentCheck() {
	    if ($("#<%=ShareAgent.ClientID %>")[0].checked == false) {
	        if ($("#<%=ShareFactory.ClientID %>")[0]) { $("#<%=ShareFactory.ClientID %>")[0].checked = false; }
	        if ($("#<%=ShareVendor.ClientID %>")[0]) { $("#<%=ShareVendor.ClientID %>")[0].checked = false; }
        }
	}	
</SCRIPT>
