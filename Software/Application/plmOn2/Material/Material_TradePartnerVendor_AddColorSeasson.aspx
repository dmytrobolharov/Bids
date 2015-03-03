<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_TradePartnerVendor_AddColorSeasson.aspx.vb"
    Inherits="plmOnApp.Material_TradePartnerVendor_AddColorSeasson" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <div id="fixed_icons">
        <a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help"
            target="_blank" id="yHelp"></a>
    </div>
    <form id="form1" runat="server" defaultbutton="imgBtnSearch">
    <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnAdd" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <asp:ImageButton ID="btnClose" runat="server" CausesValidation="false" />
            </td>
        </tr>
    </table>
    <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td class="fonthead" height="20">
                <%=strColor + " " + GetSystemText("List") + "..."%>
            </td>
        </tr>
    </table>
    <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
        <tr>
            <td>
                <asp:PlaceHolder ID="plhSearchControlsHolder" runat="server" EnableViewState="False">
                </asp:PlaceHolder>
            </td>
            <td width="100%" valign="top">
                <table height="45">
                    <tr>
                        <td>
                            <asp:ImageButton ID="imgBtnSearch" runat="server" CausesValidation="false"></asp:ImageButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr valign="top">
            <td>
                <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%"
                    bgcolor="#ffffff" border="0">
                    <tr valign="middle">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
                        <td class="fonthead" width="10">
                            &nbsp;
                        </td>
                        <td width="20">
                            <asp:ImageButton ID="btnImgFirst" runat="server" CausesValidation="false"></asp:ImageButton>
                        </td>
                        <td width="20">
                            <asp:ImageButton ID="btnImgPrevious" runat="server" CausesValidation="false"></asp:ImageButton>
                        </td>
                        <td nowrap align="center" width="125">
                            <asp:Label ID="lblPageCount" runat="server" CssClass="fonthead"></asp:Label>
                        </td>
                        <td width="20">
                            <asp:ImageButton ID="btnImgNext" runat="server" CausesValidation="false"></asp:ImageButton>
                        </td>
                        <td width="20">
                            <asp:ImageButton ID="btnImgLast" runat="server" CausesValidation="false"></asp:ImageButton>
                        </td>
                        <td width="10">
                            &nbsp;
                        </td>
                        <td width="100">
                            <asp:Label ID="RecordCount" runat="server" CssClass="font"></asp:Label>
                        </td>
                        <td class="fonthead" align="right" width="110">
                            <asp:Label ID="lblRecordsperPage" runat="server" Visible="true" Text="Records per Page:"></asp:Label>
                        </td>
                        <td width="25">
                            <asp:DropDownList ID="ps" runat="server" CssClass="fonthead">
                                <asp:ListItem Value="5">5</asp:ListItem>
                                <asp:ListItem Value="10">10</asp:ListItem>
                                <asp:ListItem Value="15">15</asp:ListItem>
                                <asp:ListItem Value="20">20</asp:ListItem>
                                <asp:ListItem Value="25">25</asp:ListItem>
                                <asp:ListItem Value="30">30</asp:ListItem>
                                <asp:ListItem Value="40">40</asp:ListItem>
                                <asp:ListItem Value="50" Selected="true">50</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td width="10">
                            <asp:Button ID="Button1" runat="server" CssClass="fonthead" Text="GO" CausesValidation="false">
                            </asp:Button>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
                <table width="100%">
                    <tr style="vertical-align: top">
                        <td width="400">
                            <asp:DataGrid ID="DataGrid1" runat="server" EnableViewState="true" DataKeyField="MaterialColorSeasonYearID">
                                <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                                <ItemStyle CssClass="ItemTemplate"></ItemStyle>
                                <HeaderStyle Height="25px" CssClass="tableheader"></HeaderStyle>
                                <PagerStyle Visible="False"></PagerStyle>
                                <Columns>
                                    <asp:TemplateColumn>
                                        <HeaderTemplate>
                                            <input type="checkbox" onclick="SelectAll(this)" id="chkSelectAll" />
                                        </HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox runat="server" ID="chkSelected" />
                                            <asp:HiddenField runat="server" ID="hdnMaterialSizeID" />
                                            <asp:HiddenField runat="server" ID="hdnMaterialColorSeasonYearID" />
                                            <input type="hidden" runat="server" id="hdnMaterialColorID" />
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                </Columns>
                            </asp:DataGrid>
                            <asp:HiddenField runat="server" ID="hdnMaterialColorSizeIDs" />
                            <asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
                        </td>
                        <td style="width: 2px; height: 900px" valign="top">
                            <img alt="" src="../System/Images/Login_Bar.gif" style="width: 2px; height: 900px;" />&nbsp;
                        </td>
                        <td>
                            <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                            <table cellspacing="1" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td class="fontHead">
                                        <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                            </table>
                            <asp:HiddenField runat="server" ID="hdnMaterialRequestGroupID" />
                            <asp:Panel ID="Panel1" runat="server">
                                <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                    <tr>
                                        <td class="fontHead" width="75">
                                            <asp:Label ID="lblScheduleBy" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:RadioButtonList ID="rbSubmitType" runat="server" CssClass="fontHead" RepeatDirection="Horizontal">
                                            </asp:RadioButtonList>
                                        </td>
                                    </tr>
                                </table>
                                <cc2:YSTabView ID="YSTabView1" runat="server"></cc2:YSTabView>
                                <asp:DataGrid ID="dgWorkflow" runat="server" DataKeyField="MaterialRequestTempWorkflowID"
                                    AllowSorting="false">
                                    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                                    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                                    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                                    <PagerStyle Visible="False"></PagerStyle>
                                    <Columns>
                                        <%--				    	                    <asp:TemplateColumn>
							                    <headerStyle Height="20px" Width="20px" CssClass="TableHeader"></headerStyle>
							                    <ItemTemplate>
								                    <%# string.Concat(DataBinder.Eval(Container.DataItem,"StatusUrl").tostring) %>								     
							                    </ItemTemplate>
						                    </asp:TemplateColumn>
                                        --%>
                                    </Columns>
                                </asp:DataGrid>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </form>
    <script language="javascript" type="text/javascript">
        var frm = document.form1;
        function SelectAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkSelected") != -1)
                    e.checked = actVar;
            }
        }
    </script>
</body>
</html>
