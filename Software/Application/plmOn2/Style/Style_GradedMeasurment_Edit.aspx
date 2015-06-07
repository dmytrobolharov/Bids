<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_GradedMeasurment_Edit.aspx.vb"
    Inherits="plmOnApp.Style.GradedSpec.Style_GradedMeasurment_Edit" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Workflow_Edit" Src="Style_Workflow_Edit.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
<head>
    <title>Style</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
<div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td width="400">
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton><cc1:ConfirmedImageButton
                    ID="btnSamplesize" runat="server" Message="Are you sure you want to change sample size?"
                    Visible="False" ToolTip="Change Sample Size..." OnClientClick="btnSampleSize_Click()"></cc1:ConfirmedImageButton>
                <!-- ac issue 4004 -->
                <cc1:ConfirmedImageButton ID="btnUpdateSize" runat="server" Message="Are you sure you want to update Grade Rules ?" Visible="true"
                    ToolTip="Change Sample Size..."></cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
                <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
            </td>
            <td class="FontHead" align="right" width="75">
                &nbsp;<asp:Label ID="lblSelectSet" runat="server" CssClass="fontHead">Select Set:</asp:Label>
            </td>
            <td width="40">
                <asp:DropDownList ID="dpStyleSet" runat="server" AutoPostBack="true" DataValueField="ID"
                    DataTextField="Value" CssClass="font">
                </asp:DropDownList>
            </td>
            <td>
                <asp:ImageButton ID="imgBtnGo" runat="server" ImageUrl="../System/Icons/icon_go.gif">
                </asp:ImageButton>
            </td>
        </tr>
    </table>
    <uc2:Style_Workflow_Edit ID="Style_Workflow_Edit1" runat="server"></uc2:Style_Workflow_Edit>
    <asp:Panel ID="pnlChange" runat="server">
        <uc1:Style_Change_Alert ID="Style_Change_Alert1" runat="server"></uc1:Style_Change_Alert>
    </asp:Panel>
    <uc2:Style_Header ID="Style_Header1" runat="server" StyleId='<%Request("SID")%>'>
    </uc2:Style_Header>
    <table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td height="20">
                <uc1:Style_Comment ID="Style_Comment1" runat="server"></uc1:Style_Comment>
            </td>
        </tr>
    </table>
    <br>
    <cc2:YSTabView ID="YSTabView2" runat="server"></cc2:YSTabView>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top" width="300">
                <asp:DataGrid ID="DataGrid1" runat="server" BorderColor="Silver" BorderStyle="Solid"
                    BorderWidth="1px" PageSize="100" AutoGenerateColumns="False" OnItemDataBound="ItemDataBoundEventHandler"
                    Width="100%">
                    <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                    <Columns>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblLink" runat="server" CssClass="fontHead">L</asp:Label></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Image ID="imgLink" runat="server" ImageUrl="../System/Icons/icon_link.gif">
                                </asp:Image>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblCritical" runat="server" CssClass="fontHead">C</asp:Label></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Image ID="imgCritical" runat="server" ImageUrl="../System/Icons/icon_warning.gif">
                                </asp:Image>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblHowTo" runat="server" CssClass="fontHead">H</asp:Label></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <cc1:BWImageButton ID="imgBtnHowTo" runat="server" ImageUrl="../System/Icons/icon_howto.gif"
                                    WindowName="POMLibrary"></cc1:BWImageButton>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div style="text-align: center">
                                    <asp:Label ID="lblHeaderPOM" runat="server">POM</asp:Label>
                                </div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div style="text-align: center">
                                    <asp:Label ID="txtPOM" Width="50px" runat="Server" />
                                    <asp:TextBox ID="txtSpec" runat="server" Width="16px" Visible="False"></asp:TextBox>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <asp:Label ID="lblHeaderPointMeasur" Width="200px" runat="server">Point of Measurement</asp:Label>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:Label ID="txtPointMeasur" runat="Server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderStyle CssClass="TableHeaderRed"></HeaderStyle>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblHeaderTOL" runat="server" CssClass="fontRed" Text="TOL"><b>TOL</b></asp:Label></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div align="center">
                                    <asp:TextBox ID="txtTOL" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid"
                                        BorderWidth="1px" ForeColor="#C00000" Columns="5" MaxLength="10"></asp:TextBox></div>
                                        <asp:HiddenField ID="hdnTOL" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderStyle CssClass="TableHeaderRed"></HeaderStyle>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblHeaderTOLN" runat="server" ForeColor="Red">TOL</asp:Label><font
                                        style="font-weight: normal; font-size: xx-small; color: red; font-family: Arial"><asp:Label
                                            ID="lblHeaderTOLNNonWash" runat="server" ForeColor="Red">(NONWASH)</asp:Label></font></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div align="center">
                                    <asp:TextBox ID="txtTOLN" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid"
                                        BorderWidth="1px" ForeColor="#C00000" Columns="5" MaxLength="10"></asp:TextBox></div>
                                    <asp:HiddenField ID="hdnTOLN" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblSize0" runat="server" /></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div align="center">
                                    <asp:TextBox ID="txtSpec0" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
                                        MaxLength="10" Columns="5"></asp:TextBox></div>
                                        <asp:HiddenField ID="hdnSpec0" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblSize1" runat="server" /></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div align="center">
                                    <asp:TextBox ID="txtSpec1" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
                                        MaxLength="10" Columns="5"></asp:TextBox></div>
                                        <asp:HiddenField ID="hdnSpec1" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblSize2" runat="server" /></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div align="center">
                                    <asp:TextBox ID="txtSpec2" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
                                        MaxLength="10" Columns="5"></asp:TextBox></div>
                                        <asp:HiddenField ID="hdnSpec2" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblSize3" runat="server" /></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div align="center">
                                    <asp:TextBox ID="txtSpec3" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
                                        MaxLength="10" Columns="5"></asp:TextBox></div>
                                        <asp:HiddenField ID="hdnSpec3" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblSize4" runat="server" /></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div align="center">
                                    <asp:TextBox ID="txtSpec4" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
                                        MaxLength="10" Columns="5"></asp:TextBox></div>
                                        <asp:HiddenField ID="hdnSpec4" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblSize5" runat="server" /></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div align="center">
                                    <asp:TextBox ID="txtSpec5" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
                                        MaxLength="10" Columns="5"></asp:TextBox></div>
                                        <asp:HiddenField ID="hdnSpec5" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblSize6" runat="server" /></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div align="center">
                                    <asp:TextBox ID="txtSpec6" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
                                        MaxLength="10" Columns="5"></asp:TextBox></div>
                                        <asp:HiddenField ID="hdnSpec6" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblSize7" runat="server" /></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div align="center">
                                    <asp:TextBox ID="txtSpec7" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
                                        MaxLength="10" Columns="5"></asp:TextBox></div>
                                        <asp:HiddenField ID="hdnSpec7" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblSize8" runat="server" /></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div align="center">
                                    <asp:TextBox ID="txtSpec8" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
                                        MaxLength="10" Columns="5"></asp:TextBox></div>
                                        <asp:HiddenField ID="hdnSpec8" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblSize9" runat="server" /></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div align="center">
                                    <asp:TextBox ID="txtSpec9" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
                                        MaxLength="10" Columns="5"></asp:TextBox></div>
                                        <asp:HiddenField ID="hdnSpec9" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblSize10" runat="server" /></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div align="center">
                                    <asp:TextBox ID="txtSpec10" runat="Server" BorderWidth="1px" BorderStyle="Solid"
                                        BorderColor="#E0E0E0" MaxLength="10" Columns="5"></asp:TextBox></div>
                                        <asp:HiddenField ID="hdnSpec10" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblSize11" runat="server" /></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div align="center">
                                    <asp:TextBox ID="txtSpec11" runat="Server" BorderWidth="1px" BorderStyle="Solid"
                                        BorderColor="#E0E0E0" MaxLength="10" Columns="5"></asp:TextBox></div>
                                        <asp:HiddenField ID="hdnSpec11" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblSize12" runat="server" /></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div align="center">
                                    <asp:TextBox ID="txtSpec12" runat="Server" BorderWidth="1px" BorderStyle="Solid"
                                        BorderColor="#E0E0E0" MaxLength="10" Columns="5"></asp:TextBox></div>
                                        <asp:HiddenField ID="hdnSpec12" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblSize13" runat="server" /></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div align="center">
                                    <asp:TextBox ID="txtSpec13" runat="Server" BorderWidth="1px" BorderStyle="Solid"
                                        BorderColor="#E0E0E0" MaxLength="10" Columns="5"></asp:TextBox></div>
                                        <asp:HiddenField ID="hdnSpec13" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblSize14" runat="server" /></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div align="center">
                                    <asp:TextBox ID="txtSpec14" runat="Server" BorderWidth="1px" BorderStyle="Solid"
                                        BorderColor="#E0E0E0" MaxLength="10" Columns="5"></asp:TextBox></div>
                                        <asp:HiddenField ID="hdnSpec14" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblSize15" runat="server" /></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div align="center">
                                    <asp:TextBox ID="txtSpec15" runat="Server" BorderWidth="1px" BorderStyle="Solid"
                                        BorderColor="#E0E0E0" MaxLength="10" Columns="5"></asp:TextBox></div>
                                        <asp:HiddenField ID="hdnSpec15" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblSize16" runat="server" /></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div align="center">
                                    <asp:TextBox ID="txtSpec16" runat="Server" BorderWidth="1px" BorderStyle="Solid"
                                        BorderColor="#E0E0E0" MaxLength="10" Columns="5"></asp:TextBox></div>
                                        <asp:HiddenField ID="hdnSpec16" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblSize17" runat="server" /></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div align="center">
                                    <asp:TextBox ID="txtSpec17" runat="Server" BorderWidth="1px" BorderStyle="Solid"
                                        BorderColor="#E0E0E0" MaxLength="10" Columns="5"></asp:TextBox></div>
                                        <asp:HiddenField ID="hdnSpec17" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblSize18" runat="server" /></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div align="center">
                                    <asp:TextBox ID="txtSpec18" runat="Server" BorderWidth="1px" BorderStyle="Solid"
                                        BorderColor="#E0E0E0" MaxLength="10" Columns="5"></asp:TextBox></div>
                                        <asp:HiddenField ID="hdnSpec18" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <div align="center">
                                    <asp:Label ID="lblSize19" runat="server" /></div>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <div align="center">
                                    <asp:TextBox ID="txtSpec19" runat="Server" BorderWidth="1px" BorderStyle="Solid"
                                        BorderColor="#E0E0E0" MaxLength="10" Columns="5"></asp:TextBox></div>
                                        <asp:HiddenField ID="hdnSpec19" runat="server" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid>
            </td>
        </tr>
    </table>
    </form>

    <script language="javascript">
        var frm = document.Form1;
        function CheckAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
                    e.checked = actVar;
            }
        }
    </script>

    <table id="Table5" height="24" cellspacing="0" cellpadding="0" width="100%" border="0"
        runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="7">
                <img src="../System/Images/table_bar_left.gif">
            </td>
            <td class="TableBar" valign="middle" align="center" width="20">
                <img src="../System/icons/icon_changeobject.gif">
            </td>
            <td class="TableBar">
                <asp:Label ID="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:Label>&nbsp;/
                <asp:Label ID="lblModifiedBy" runat="server" CssClass="fontHead"></asp:Label>
            </td>
            <td valign="middle" align="center" width="7">
                <img src="../System/Images/table_bar_right.gif">
            </td>
        </tr>
    </table>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
	    function btnSampleSize_Click() {
		    <%= strSamplesize %>
            return false;
        }     
    </script>
</body>
</html>
