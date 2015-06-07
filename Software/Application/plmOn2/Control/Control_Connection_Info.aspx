<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_Connection_Info.aspx.vb"
    Inherits="plmOnApp.Control_Connection_Info" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Control</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="Form1" method="post" runat="server">
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large"
                    Font-Names="Tahoma,Verdana"></asp:Label>
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr valign="top">
            <td>
                <cc2:YSTabView ID="YSTabView1" runat="server"></cc2:YSTabView>
                <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
                    border="0" runat="server">
                    <tr valign="middle">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
                        <td>
                             <cc1:ConfirmedImageButton ID="btnEdit" Visible="true" runat="server" Message="NONE" CausesValidation="False"></cc1:ConfirmedImageButton>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
                <table cellspacing="2" cellpadding="0" width="100%" border="0">
				<tr>
					<td>
                        <asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder>

                        <asp:Panel ID="pnlInfo" runat="server">
                            <table bgcolor='#FFFFFF' width='100%' border='0' cellspacing='1' cellpadding='0'>
					            <tr valign='top'>
						            <td width='50%'>
							            <table width='100%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
								            <tr>
									            <td width='125' height='25' class='fontHead' nowrap="nowrap">
										            <asp:label id="lblSetting1" runat="server">Setting1</asp:label>
									            </td>
									            <td class='font'>
										            <asp:label id="txtSetting1" runat="server"></asp:label>
                                                </td>
								            </tr>
								            <tr>
									            <td width='125' height='25' class='fontHead' nowrap="nowrap">
										            <asp:label id="lblSetting2" runat="server">Setting2</asp:label>
									            </td>
									            <td class='font'>
										            <asp:label id="txtSetting2" runat="server"></asp:label>
                                                </td>
								            </tr>
								            <tr>
									            <td width='125' height='25' class='fontHead' nowrap="nowrap">
										            <asp:label id="lblSetting3" runat="server">Setting3</asp:label>
									            </td>
									            <td class='font'>
										            <asp:label id="txtSetting3" runat="server"></asp:label>
									            </td>
								            </tr>
								            <tr>
									            <td width='125' height='25' class='fontHead' nowrap="nowrap">
										            <asp:label id="lblSetting4" runat="server">Setting4</asp:label>
									            </td>
									            <td class='font'>
										            <asp:label id="txtSetting4" runat="server"></asp:label>
									            </td>
								            </tr>
								            <tr>
									            <td width='125' height='25' class='fontHead' nowrap="nowrap">
										            <asp:label id="lblSetting5" runat="server">Setting5</asp:label>
									            </td>
									            <td class='font'>
										            <asp:label id="txtSetting5" runat="server"></asp:label>
									            </td>
								            </tr>
								            <tr>
									            <td width='125' height='25' class='fontHead' nowrap="nowrap">
										            <asp:label id="lblSetting6" runat="server">Setting6</asp:label>
									            </td>
									            <td class='font'>
										            <asp:label id="txtSetting6" runat="server"></asp:label>
									            </td>
								            </tr>
							            </table>
						            </td>
						            <td width='50%'>
						            </td>
					            </tr>
				            </table>
                        </asp:Panel>

                        <asp:Panel ID="pnlAbout" runat="server">
                            YuniquePLM version: <asp:Label ID="lblYniquePLMVersion" runat="server"><%= GetYuniuePLMVersion()%></asp:Label>
                            <asp:datagrid id="dgThirdPartyLibs" runat="server" AllowSorting="false" AutoGenerateColumns="false" AllowPaging="false">
							    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							    <PagerStyle Visible="False"></PagerStyle>
						    </asp:datagrid>
                        </asp:Panel>
                    </td>
				</tr>
			</table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
