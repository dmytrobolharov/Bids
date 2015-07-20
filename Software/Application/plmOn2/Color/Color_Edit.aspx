<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Color_Edit.aspx.vb" Inherits="plmOnApp.Color_Edit" %>

<%@ OutputCache Duration="60" Location="Server" VaryByParam="*" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Color_Edit</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />

    <script src="../System/jscript/color.js" type="text/javascript"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>

    <script>
        function btnClose_Click() {
            <%= strExitScript %>
            return false;
        }
        function DisableEnterKey() {
            //alert(window.event.keyCode)
            if (window.event.keyCode == 13)
                window.event.keyCode = 0;

        } 
    </script>

    <form id="Form1" method="post" enctype="multipart/form-data" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <asp:ImageButton ID="hndButton" runat="server" ImageUrl="../System/Images/bbTbSCnr.gif"
                    Width="3px" Height="15px" EnableTheming="False" EnableViewState="False" />
            </td>
            <td width="80">
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click();"></cc1:ConfirmedImageButton>
            </td>
            <td width="75">
                &nbsp;
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table height="10" cellspacing="0" cellpadding="0" width="100%" bgcolor="#cddeee"
        border="0">
        <tr>
            <td>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblColorHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                    ForeColor="#E0E0E0"></asp:Label>
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="1" width="100%" border="0">
        <tr>
            <td valign="top" width="1%">
                <table class="ToolbarShort" height="25" cellspacing="0" cellpadding="0" width="100%"
                    border="0">
                    <tr>
                        <td align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
                        <td width="75">
                            &nbsp;<span class="fontHead"><asp:Label ID="lblSaturation" runat="server"></asp:Label></span>
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" Height="18px"
                                Width="75px">
                                <asp:ListItem Value="100%">100%</asp:ListItem>
                                <asp:ListItem Value="90%">90%</asp:ListItem>
                                <asp:ListItem Value="80">80%</asp:ListItem>
                                <asp:ListItem Value="70%" Selected="True">70%</asp:ListItem>
                                <asp:ListItem Value="60%">60%</asp:ListItem>
                                <asp:ListItem Value="50%">50%</asp:ListItem>
                                <asp:ListItem Value="40%">40%</asp:ListItem>
                                <asp:ListItem Value="30%">30%</asp:ListItem>
                                <asp:ListItem Value="20%">20%</asp:ListItem>
                                <asp:ListItem Value="10%">10%</asp:ListItem>
                                <asp:ListItem Value="0%">0%</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
                <table id="Table1" bordercolor="#000000" cellspacing="1" cellpadding="1" border="0"
                    runat="server">
                </table>
            </td>
            <td valign="top" align="left" width="1%">
                <table class="ToolbarShort" height="25" cellspacing="0" cellpadding="0" width="100%"
                    border="0">
                    <tr>
                        <td align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
                        <td class="fontHead">
                            <%= strColor & " Library..."%>
                        </td>
                    </tr>
                </table>
                <table height="25" cellspacing="0" cellpadding="0" width="525" bgcolor="#e6e6e6"
                    border="0">
                    <tr>
                        <td align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
                        <td width="100">
                            &nbsp;<span class="fontHead"><%= "Search " & strColor  & ":" %></span>
                        </td>
                        <td width="25">
                            <asp:DropDownList ID="ddlColorType" runat="server">
                            </asp:DropDownList>
                        </td>
                        <td width="25">
                            <asp:TextBox ID="txtSearchColor" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:ImageButton ID="imgBtnSearch" runat="server" ImageUrl="../System/Icons/icon_search.gif">
                            </asp:ImageButton>
                        </td>
                    </tr>
                </table>
                <asp:DataList ID="DataList1" runat="server" DataKeyField="ID" CssClass="font" GridLines="Both"
                    RepeatDirection="Horizontal" RepeatColumns="7" BackColor="White" BorderColor="Silver"
                    BorderStyle="Solid" BorderWidth="1px" OnItemCommand="DataList1_ItemCommand">
                    <ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="Gainsboro" VerticalAlign="Top">
                    </ItemStyle>
                    <ItemTemplate>
                        <table height="65" width="65">
                            <tr height="50" width="65">
                                <td bgcolor='#<%#DataBinder.Eval(Container.DataItem,"Hex").tostring%>'>
                                    <asp:ImageButton ID="imgBtnLib" runat="server" ImageUrl="../System/Images/65x50.gif"
                                        CommandName="ColorChip" ImageAlign="Middle" Visible="true"></asp:ImageButton>
                                </td>
                            </tr>
                            <tr height="10" width="65">
                                <td bgcolor='<%#bgColor%>'>
                                    &nbsp;
                                    <input id="rgb" type="hidden" runat="server" value='<%#DataBinder.Eval(Container.DataItem,"Hex")%>'
                                        name="rgb">
                                    <input id="h" type="hidden" runat="server" value='<%#DataBinder.Eval(Container.DataItem,"h").tostring%>' />
                                    <input id="s" type="hidden" runat="server" value='<%#DataBinder.Eval(Container.DataItem,"s").tostring%>' />
                                    <input id="l" type="hidden" runat="server" value='<%#DataBinder.Eval(Container.DataItem,"l").tostring%>' />
                                    <input id="r" type="hidden" runat="server" value='<%#DataBinder.Eval(Container.DataItem,"r").tostring%>' />
                                    <input id="g" type="hidden" runat="server" value='<%#DataBinder.Eval(Container.DataItem,"g").tostring%>' />
                                    <input id="b" type="hidden" runat="server" value='<%#DataBinder.Eval(Container.DataItem,"b").tostring%>' />
                                    <input id="LAB_L" type="hidden" runat="server" value='<%# Convert.toString (DataBinder.Eval(Container.DataItem,"LAB_L"))%>' />
                                    <input id="LAB_A" type="hidden" runat="server" value='<%# Convert.toString (DataBinder.Eval(Container.DataItem,"LAB_A"))%>' />
                                    <input id="LAB_B" type="hidden" runat="server" value='<%# Convert.toString (DataBinder.Eval(Container.DataItem,"LAB_b"))%>' />
                                    <input id="ColorCode" type="hidden" runat="server" value='<%#(Container.DataItem("PantoneNumber").ToString)%>' />
                                    <input id="ColorName" type="hidden" runat="server" value='<%#(Container.DataItem("PantoneName").ToString)%>' />
                                    <input id="ColorSource" type="hidden" runat="server" value='<%#(Container.DataItem("ColorSource").ToString)%>' />
                                </td>
                            </tr>
                            <tr>
                                <td bgcolor="#ffffff">
                                    <font color="#000000" size="1">
                                        <%#(Container.DataItem("PantoneNumber").ToString)%></font>
                                </td>
                            </tr>
                            <tr>
                                <td bgcolor="#ffffff">
                                    <font color="#000000" size="1">
                                        <%#(Container.DataItem("PantoneName").ToString)%></font>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>
            </td>
            <td valign="top" align="left">
                <table class="ToolbarShort" height="25" cellspacing="0" cellpadding="0" width="100%"
                    border="0">
                    <tr>
                        <td align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
                        <td class="fontHead" width="237">
                            <%= "Selected " & strColor & "..."%>
                        </td>
                    </tr>
                </table>
                <table cellspacing="1" cellpadding="1" width="300" border="0" bgcolor="#ffffff">
                    <tr>
                        <td bgcolor="#ffffff" colspan="2" height="110">
                            <table cellspacing="1" cellpadding="1" width="100%" border="0">
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                    <td align="left">
                                        <table id="ColorChip" bordercolor="#cccccc" height="100" cellspacing="0" cellpadding="0"
                                            width="100" align="left" border="1" runat="server">
                                            <tr>
                                                <td bordercolor="#cccccc">
                                                    <input id="Selected_R" type="hidden" name="Selected_R" runat="server">
                                                    <input id="Selected_G" type="hidden" name="Selected_G" runat="server">
                                                    <input id="Selected_B" type="hidden" name="Selected_B" runat="server">
                                                    <input id="Selected_HEX" type="hidden" name="Text4" runat="server">
                                                    <input id="Selected_H" type="hidden" name="Selected_H" runat="server">
                                                    <input id="Selected_S" type="hidden" name="Selected_S" runat="server">
                                                    <input id="Selected_L" type="hidden" name="Selected_L" runat="server">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table cellspacing="0" cellpadding="0" border="0">
                                <tr>
                                    <td bgcolor="#ffffff">
                                        <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                            <tr>
                                                <td>
                                                    <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                                        <tr>
                                                            <td class="fontHead">
                                                                <div align="center">
                                                                    <%= strColorNo %>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <div align="center">
                                                                    <asp:TextBox ID="txtColorCode" runat="server" onKeyPress="DisableEnterKey()">0</asp:TextBox></div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <asp:Label ID="lblDuplicateColor" runat="server" ForeColor="Red" CssClass="fontHead"
                                                        BackColor="Transparent" Visible="False">Duplicate Color #. Please select another number.</asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="#ffffff">
                                        <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                            <tr>
                                                <td class="fontHead">
                                                    <div align="center">
                                                        <%= strColorName%></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div align="center">
                                                        <asp:TextBox ID="txtColorName" runat="server" onKeyPress="DisableEnterKey()">0</asp:TextBox></div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="#ffffff">
                                        <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                            <tr>
                                                <td class="fontHead">
                                                    <div align="center">
                                                        <%= strColorSource %></div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <div align="center">
                                                        <asp:TextBox ID="txtColorSource" runat="server" onKeyPress="DisableEnterKey()"></asp:TextBox></div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="fontHead" bgcolor="#ffffff">
                                        <div align="center">
                                            <%= strColorNotes %></div>
                                    </td>
                                </tr>
                                <tr>
                                    <td bgcolor="#ffffff">
                                        <div align="center">
                                            <asp:TextBox ID="txtColorNotes" runat="server" Rows="4" TextMode="MultiLine"></asp:TextBox></div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td valign="top" bgcolor="#ffffff">
                            <asp:Panel ID="pnlRGBInfo" runat="server">
                                <table cellspacing="0" cellpadding="0" border="0">
                                    <tr>
                                        <td>
                                            <table cellspacing="0" cellpadding="0" width="100%" align="center" border="0">
                                                <tr>
                                                    <td class="fontHead" align="right" width="25">
                                                        &nbsp;
                                                    </td>
                                                    <td class="fontHead" align="right" width="25">
                                                    </td>
                                                    <td width="75">
                                                        &nbsp;
                                                    </td>
                                                    <td class="fontHead" style="width: 15px">
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="fontHead" align="right" width="25">
                                                    </td>
                                                    <td class="fontHead" align="right" width="25">
                                                        L:
                                                    </td>
                                                    <td width="75">
                                                        <input class="InputBox" id="ll" maxlength="3" size="5" name="ll" runat="server" onkeypress="DisableEnterKey()">
                                                    </td>
                                                    <td class="fontHead" style="width: 15px">
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="fontHead" align="right" width="25">
                                                    </td>
                                                    <td class="fontHead" align="right" width="25">
                                                        A:
                                                    </td>
                                                    <td width="75">
                                                        <input class="InputBox" id="la" maxlength="3" size="5" name="la" runat="server" onkeypress="DisableEnterKey()">
                                                    </td>
                                                    <td class="fontHead" style="width: 15px">
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="fontHead" align="right" width="25">
                                                    </td>
                                                    <td class="fontHead" align="right" width="25">
                                                        B:
                                                    </td>
                                                    <td width="75">
                                                        <input class="InputBox" id="lb" maxlength="3" size="5" name="lb" runat="server" onkeypress="DisableEnterKey()">
                                                    </td>
                                                    <td class="fontHead" style="width: 15px">
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="fontHead" align="right" width="25">
                                                    </td>
                                                    <td class="fontHead" align="right" width="25">
                                                    </td>
                                                    <td width="75">
                                                        &nbsp;
                                                    </td>
                                                    <td class="fontHead" style="width: 15px">
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="fontHead" align="right" width="25">
                                                    </td>
                                                    <td class="fontHead" align="right" width="25">
                                                        <div align="right">
                                                            <b>R:</b></div>
                                                    </td>
                                                    <td width="75">
                                                        <input class="InputBox" id="txtR" maxlength="3" size="5" name="r" runat="server"
                                                            onkeypress="DisableEnterKey()">
                                                    </td>
                                                    <td class="fontHead" style="width: 15px">
                                                        <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtB"
                                                            CssClass="fontHead" Display="Dynamic" ErrorMessage="*" MaximumValue="255" MinimumValue="0"
                                                            SetFocusOnError="True"  Type="Integer"></asp:RangeValidator>
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="fontHead" align="right" width="25">
                                                    </td>
                                                    <td class="fontHead" align="right" width="25">
                                                        <div align="right">
                                                            <b>G:</b></div>
                                                    </td>
                                                    <td width="75">
                                                        <input class="InputBox" id="txtG" maxlength="3" size="5" name="g" runat="server"
                                                            onkeypress="DisableEnterKey()">
                                                    </td>
                                                    <td class="fontHead" style="width: 15px">
                                                        <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="txtR"
                                                            CssClass="fontHead" Display="Dynamic" ErrorMessage="*" MaximumValue="255" MinimumValue="0"
                                                            SetFocusOnError="True"  Type="Integer"></asp:RangeValidator>
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="fontHead" align="right" width="25">
                                                    </td>
                                                    <td class="fontHead" align="right" width="25">
                                                        <div align="right">
                                                            <b>B:</b></div>
                                                    </td>
                                                    <td width="75">
                                                        <input class="InputBox" id="txtB" maxlength="3" size="5" name="b" runat="server"
                                                            onkeypress="DisableEnterKey()">&nbsp;
                                                    </td>
                                                    <td class="fontHead" style="width: 15px">
                                                        <asp:RangeValidator ID="RangeValidator3" runat="server" ControlToValidate="txtR"
                                                            CssClass="fontHead" Display="Dynamic" ErrorMessage="*" MaximumValue="255" MinimumValue="0"
                                                            SetFocusOnError="True"  Type="Integer"></asp:RangeValidator>
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" width="25">
                                                    </td>
                                                    <td align="right" width="25">
                                                        <div align="right">
                                                            <b>
                                                                <input id="txtHEX" type="hidden" name="h" runat="server"></b></div>
                                                    </td>
                                                    <td width="75">
                                                        <input class="button" id="btnSetRGB" type="button" value="Set RGB" name="btnSetRGB"
                                                            runat="server">
                                                    </td>
                                                    <td style="width: 15px">
                                                        &nbsp;
                                                    </td>
                                                    <td>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <asp:CheckBox ID="chkColorImage" AutoPostBack="True" CssClass="fontHead" runat="server">
                            </asp:CheckBox>
                            <asp:Panel ID="pnlUpload" runat="server" Visible="true">
                                <span class="fontHead">
                                    <asp:Label ID="lblUploadH" runat="server"></asp:Label></span>
                                <br>
                                <input id="File1" type="file" name="file1" runat="server">
                            </asp:Panel>
                        </td>
                    </tr>
                    <tr height="35">
                        <td bgcolor="#ffffff" colspan="2">
                            <div align="center">
                                <cc1:ConfirmedImageButton ID="btnAddColor" runat="server" Message="NONE"></cc1:ConfirmedImageButton></div>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" bgcolor="#ffffff" colspan="2">
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" CssClass="fontHead"
                                ControlToValidate="txtColorCode"></asp:RequiredFieldValidator><asp:RequiredFieldValidator
                                    ID="RequiredFieldValidator2" runat="server" CssClass="fontHead" ControlToValidate="txtColorName"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                </table>
                <table class="ToolbarShort" height="25" cellspacing="0" cellpadding="0" width="100%"
                    border="0">
                    <tr>
                        <td width="10">
                            &nbsp;
                        </td>
                        <td class="fontHead">
                            <%=strColor%><asp:Label ID="lblPaleteH" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td>
                            <asp:DataGrid ID="DataGrid1" runat="server" DataKeyField="ColorPaletteID" BorderColor="#E0E0E0"
                                BorderStyle="Solid" BorderWidth="1px" AutoGenerateColumns="False" PageSize="1000"
                                Width="350px">
                                <AlternatingItemStyle Height="20px" Width="300px" BackColor="AliceBlue"></AlternatingItemStyle>
                                <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
                                <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                                <PagerStyle Visible="false" />
                            </asp:DataGrid>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
