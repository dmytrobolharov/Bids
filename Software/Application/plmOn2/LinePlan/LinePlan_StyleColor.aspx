<%@ Page Language="vb" AutoEventWireup="false" Codebehind="LinePlan_StyleColor.aspx.vb" Inherits="plmOnApp.LinePlan_StyleColor" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register src="../Style/Style_Header.ascx" tagname="Style_Header" tagprefix="uc1" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<HTML>
	<HEAD>
		<title>Color</title>
        <LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	    <LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>	
	    </HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="tableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
						<asp:ImageButton id="btnSaveStyle" runat="server" ></asp:ImageButton>
						<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton></td>
				</tr>
			</table>			
			<table height="100" cellSpacing="0" cellPadding="0" border="0" width="100%" bgcolor="White">
				<tr vAlign="top">
				    <td width="10">&nbsp;</td>
					<td width="900">
                        <uc1:Style_Header ID="Style_Header1" runat="server" />
                    </td>
					<td>&nbsp;</td>
				</tr>
			</table>
			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>	
			<br />
			<table cellSpacing="0" cellPadding="0" width="100%" border="0" bgcolor="White">
				<tr>
					<td width="20">&nbsp;</td>
	
				    <td width="150">
                      <table cellSpacing="1" cellPadding="1" border="0" 
                            style="border: thin #CCCCCC;" bgcolor="#CCCCCC">
                            <tr class="TableheaderGreen">
                                <td colspan="4" style="text-align: center" height="20">
                                    <%#GetSystemText("Delivery")%></td>
                            </tr>
                            <tr bgcolor="White">
                                <td class="fontHead" align="center" Width="50px">
                                    1</td>
                                <td class="fontHead" align="center" Width="50px">
                                    2</td>
                                <td class="fontHead" align="center" Width="50px">
                                    3</td>
                                <td class="fontHead" align="center" Width="50px">
                                    4</td>
                            </tr>
                            <tr bgcolor="White">
                                <td class="fontHead" align="center">
                                    <asp:CheckBox ID="cbLinePlanDel1" runat="server" Checked="True" 
                                        AutoPostBack="True" />
                                </td>
                                <td class="fontHead" align="center">
                                    <asp:CheckBox ID="cbLinePlandel2" runat="server" Checked="True" 
                                        AutoPostBack="True" />
                                </td>
                                <td class="fontHead" align="center">
                                    <asp:CheckBox ID="cbLinePlanDel3" runat="server" Checked="True" 
                                        AutoPostBack="True" />
                                </td>
                                <td class="fontHead" align="center">
                                    <asp:CheckBox ID="cbLinePlanDel4" runat="server" Checked="True" 
                                        AutoPostBack="True" /></td>
                            </tr>
                        </table>
                    </td>
					<td width="200">
                        <table cellSpacing="1" cellPadding="1" border="0" 
                            style="border: thin #CCCCCC;" bgcolor="#CCCCCC">
                            <tr class="TableheaderBlue">
                                <td colspan="4" style="text-align: center" height="20">
                                    <%#GetSystemText("Channel")%></td>
                            </tr>
                            <tr bgcolor="White">
                                <td class="fontHead" align="center" Width="50px">
                                    <%#GetSystemText("WHS")%></td>
                                <td class="fontHead" align="center" Width="50px">
                                    <%#GetSystemText("RTL")%></td>
                                <td class="fontHead" align="center" Width="50px">
                                    <%#GetSystemText("INT")%></td>
                                <td class="fontHead" align="center" Width="50px">
                                    <%#GetSystemText("CAT")%></td>
                            </tr>
                            <tr bgcolor="White">
                                <td class="fontHead" align="center">
                                    <asp:CheckBox ID="cbLinePlanCh1" runat="server" Checked="True" />
                                </td>
                                <td class="fontHead" align="center">
                                    <asp:CheckBox ID="cbLinePlanCh2" runat="server" Checked="True" />
                                </td>
                                <td class="fontHead" align="center">
                                    <asp:CheckBox ID="cbLinePlanCh3" runat="server" Checked="True" />
                                </td>
                                <td class="fontHead" align="center">
                                    <asp:CheckBox ID="cbLinePlanCh4" runat="server" Checked="True" />
                                </td>
                            </tr>
                        </table>
                    </td>
					<td width="20">&nbsp;</td>
				    <td>&nbsp;</td>
					
				</tr>
			</table>
            <br />
		    <asp:DataGrid ID="dgColor" runat="server" AutoGenerateColumns="False" 
                BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" CaptionAlign="Left" 
                DataKeyField="StyleColorID" PageSize="1000">
                <AlternatingItemStyle BackColor="AliceBlue" Height="20px" />
                <ItemStyle BackColor="White" CssClass="font" Height="20px" />
                <HeaderStyle CssClass="tableHeader" Height="20px" />
                <Columns>
                    <asp:TemplateColumn>
                        <HeaderTemplate>
                            <asp:Label ID="lblHeaderColor" runat="server"> <%#strColor%> </asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td height="16" width="16">
                                        <asp:Image ID="imgColor" runat="server" />
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderStyle-Width="125">
                        <HeaderTemplate>
                            <asp:Label ID="lblHeaderColorCode" runat="server"> <%#strColorName%> </asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label ID="txtColorCode" runat="Server"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn HeaderStyle-Width="100">
                        <HeaderTemplate>
                            <asp:Label ID="lblHeaderColorStatus" runat="server"> <%#strColor%> Status</asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlColorStatus" runat="server"></asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn>
                        <HeaderTemplate>
                            <asp:Label ID="lblHeaderDelivery" runat="server" ForeColor="#CC0000"><%#strColor%> 
                            Delivery </asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <table>
                                <tr bgcolor="White">
                                    <td align="center" class="fontHead">
                                        <asp:CheckBox ID="cbStyleColorDel1" runat="server" Checked="True" 
                                            Cssclass="fontHead" ForeColor="#CC0000" Text="D1" />
                                    </td>
                                    <td align="center" class="fontHead">
                                        <asp:CheckBox ID="cbStyleColorDel2" runat="server" Checked="True" 
                                            Cssclass="fontHead" ForeColor="#CC0000" Text="D2" />
                                    </td>
                                    <td align="center" class="fontHead">
                                        <asp:CheckBox ID="cbStyleColorDel3" runat="server" Checked="True" 
                                            Cssclass="fontHead" ForeColor="#CC0000" Text="D3" />
                                    </td>
                                    <td align="center" class="fontHead">
                                        <asp:CheckBox ID="cbStyleColorDel4" runat="server" Checked="True" 
                                            Cssclass="fontHead" ForeColor="#CC0000" Text="D4" />
                                    </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
            </asp:DataGrid>

		</form>
	</body>
</HTML>
