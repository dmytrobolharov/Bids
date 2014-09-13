<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_Partner_Header.ascx.vb" Inherits="srmOnApp.Sourcing_Partner_Header" %>
<link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />
<style type="text/css">
    .tp-add-label {
    	font-size: x-small; 
    	font-weight: bold; 
    	display:inline-block; 
    	margin-right: 50px;
    }
</style>
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
            <td width="33%" valign="top">                
                <div>
                    <span style="display:inline-block; color: #e0e0e0; font-family: Tahoma,Verdana; font-size: x-large; width:125px;"><%= GetSystemText("Agent")%></span>
                    <asp:CheckBox ID="ShareAgent" runat="server" Text="Share Quote with Agent" Style="color: Red; font-family: Tahoma,Verdana;
                        font-weight: bold; font-size: x-small;" Visible="false" />                        
                </div>
                <asp:PlaceHolder ID="plhAgent" runat="server"></asp:PlaceHolder>                
            </td>
            <td width="33%" valign="top">                
                <div>
                    <span style="display:inline-block; color: #e0e0e0; font-family: Tahoma,Verdana; font-size: x-large; width:125px;"><%= GetSystemText("Vendor")%></span>
                    <asp:CheckBox ID="ShareVendor" runat="server" Text="Share Quote with Vendor" Style="color: Red; font-family: Tahoma,Verdana;
                        font-weight: bold; font-size: x-small;" Visible="false" />

                    <asp:Panel ID="pnlVendorAdd" runat="server" Visible="false">
                        <span class="tp-add-label fontHead"><%= GetSystemText("Add Vendor")%></span> <asp:DropDownList ID="drlVendorAdd" runat="server" AutoPostBack="true" Width="100px"></asp:DropDownList>
                    </asp:Panel>
                </div>
                <asp:PlaceHolder ID="plhVendor" runat="server"></asp:PlaceHolder>                
            </td>
            <td width="33%" valign="top">                
                <div>
                    <span style="display:inline-block; color: #e0e0e0; font-family: Tahoma,Verdana; font-size: x-large; width:125px;"><%= GetSystemText("Factory")%></span>
                    <asp:CheckBox ID="ShareFactory" runat="server" Text="Share Quote with Factory" Style="color: Red; font-family: Tahoma,Verdana;
                        font-weight: bold; font-size: x-small;" Visible="false" />

                    <asp:Panel ID="pnlFactoryAdd" runat="server" Visible="false">                                                     
                            <span class="tp-add-label fontHead"><%= GetSystemText("Add Factory")%></span> <asp:DropDownList ID="drlFactoryAdd" runat="server" Width="100px" AutoPostBack="true"></asp:DropDownList>                            
                    </asp:Panel>
                </div>
                <asp:PlaceHolder ID="plhFactory" runat="server"></asp:PlaceHolder>                
            </td>
        </tr>
    </table>
</div>
