<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_RequestSubmit.aspx.vb" Inherits="plmOnApp.Material_RequestSubmit" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc2" TagName="Material_Header" Src="Material_Header.ascx" %>
<%@ Register TagPrefix="uc2" TagName="TradePartner_Header" Src="MaterialRequest_Partner_Header.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title>Material Request</title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />		
    <link href="../System/CSS/Grid.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Tree.css" rel="stylesheet" type="text/css" />    
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	<script type="text/javascript">
	    function userselect(sValueUsr, sValueDate) {
	    
	        var hiddenControl = '<%= hd_SessionName.ClientID %>';
	        var hiddenControlFlag = '<%= hd_SessionDate.ClientID %>';
	        
	        document.form1[sValueUsr].value = document.getElementById(hiddenControl).value
	        document.form1[sValueDate].value = document.getElementById(hiddenControlFlag).value	  
	    }
				
</script>
</head>
<body>
 <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server">
    <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" height="25"
        border="0">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:BWImageButton ID="btnGoTo" runat="server" ></cc1:BWImageButton>
                <cc1:ConfirmedImageButton ID="btnRemove" runat="server" ></cc1:ConfirmedImageButton>
                <cc1:BWImageButton ID="btnPreview" runat="server" ></cc1:BWImageButton>
                <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:ConfirmedImageButton>
            </td>
            <td>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                    ForeColor="#999999">Material Submit</asp:Label>
            </td>
        </tr>
    </table>
    <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr class="TableHeader">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td width="20">
                <asp:ImageButton ID="imbBtnExpand" runat="server" ImageUrl="../System/Icons/icon_Next.gif"
                    ></asp:ImageButton><asp:ImageButton ID="imgBtnCollapse"
                        runat="server" ImageUrl="../System/Icons/icon_Down.gif" >
                    </asp:ImageButton>
            </td>
            <td class="fontHead" width="400">
                &nbsp;
                <asp:Label ID="lblMaterialDetail" runat="server"></asp:Label>
            </td>
            <td valign="middle" align="left" width="125">
                <asp:Label ID="lblSelectColorSize" runat="server"></asp:Label>
            </td>
            <td>
                <asp:DropDownList ID="ddlMaterialTradeColor" runat="server" AutoPostBack="True">
                </asp:DropDownList>
            </td>
            <td align="left" valign="middle">
                &nbsp;
            </td>
        </tr>
    </table>
    <asp:Panel ID="Panel1" runat="server" CssClass="font" BorderWidth="0" BackColor="#ffffff"
        Width="100%">
        <table height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff"
            border="0">
            <tr>
                <td width="900">
                    <uc2:Material_Header ID="Material_Header1" runat="server"></uc2:Material_Header>
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
    </asp:Panel>
    <uc2:TradePartner_Header ID="TradePartner_Header1" runat="server"></uc2:TradePartner_Header>
    <table cellspacing="0" bgcolor="White" border="0" cellpadding="0" width="100%">
        <tr>
            <td>
                <table cellspacing="2" cellpadding="0">
                    <tr>
                        <td valign="top" bgcolor="White">
                            <table height="26" cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="White">
                                <tr>
                                    <td valign="bottom">
                                        <cc2:YSTabView ID="tabSubmit" runat="server"></cc2:YSTabView>
                                    </td>
                                </tr>
                            </table>

                                    <table cellspacing="0" width="400" cellpadding="0" style="border: 1px solid #F0F0F0; background-color: #FFFFFF;">
                                        <tr>
                                            <td>
                                                <table cellspacing="1" cellpadding="0" width="100%" border="0">
                                                    <tr>
                                                        <td class="fontHead">
                                                            <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
                                                    <tr class="TableHeader">
                                                        <td valign="middle" align="center" width="10">
                                                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                                        </td>
                                                        <td class="fontHead">
                                                            &nbsp;<asp:Label ID="lblSubmitGrid" runat="server">
                                                            </asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table id="tblTemplate" height="24" cellspacing="0" cellpadding="0" width="100%"
                                                    border="0" runat="server">
                                                    <tr valign="middle">
                                                        <td valign="middle" align="center" width="7">
                                                            <img src="../System/Images/table_bar_left.gif">
                                                        </td>
                                                        <td class="TableBar" valign="middle" align="center" width="20">
                                                            <img src="../System/icons/icon_template.gif">
                                                        </td>
                                                        <td class="TableBar">
                                                            <asp:Label ID="lnkTemplate" runat="server" Text=""></asp:Label>
                                                        </td>
                                                        <td valign="middle" align="center" width="7">
                                                            <img src="../System/Images/table_bar_right.gif">
                                                        </td>
                                                    </tr>
                                                </table>
                                                <table id="tbTemplate" cellspacing="0" cellpadding="0" border="0" style="height: 28px; width: 100%" runat="server" >
                                                    <tr class="TableHeader">
                                                        <td valign="middle" align="center" width="10">
                                                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                                        </td>
                                                        <td width="300">
                                                            <cc1:BWImageButton ID="btnTemplateSelect" runat="server"  />
                                                            <cc1:BWImageButton ID="btnTemplateAdd" runat="server"/>
                                                            <cc1:BWImageButton ID="btnTemplateRemove" runat="server" />
                                                        </td>
                                                        <td>
                                                            <table border="0" cellpadding="0" cellspacing="0">
                                                                <tr>
                                                                    <td width="75" align="right"> <asp:label id="lblSortBy" Runat="server" CssClass="font"><b>&nbsp;Sort by:&nbsp;</b></asp:label></td>
                                                                    <td><asp:dropdownlist id="ddlSortBy" Runat="server" /></td>
                                                                    <td>
                                                                        <cc1:ConfirmedImageButton ID="btnSort" runat="server" Message="NONE" />
                                                                    </td>                                                            
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td></td>
                                                    </tr>
                                                </table>
                                                <asp:DataGrid ID="dgMaterial" runat="server" DataKeyField="MaterialRequestSubmitItemID"
                                                    AutoGenerateColumns="False" BorderWidth="1px" BorderColor="#CCCCCC" CellPadding="1"
                                                    BackColor="White">
                                                    <PagerStyle />
                                                    <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
                                                    <ItemStyle Height="20px" CssClass="font"></ItemStyle>
                                                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                                                </asp:DataGrid>
                                                <table cellspacing="0" cellpadding="0" border="0" style="height: 28px; width: 100%">
                                                    <tr class="TableHeader">
                                                        <td valign="middle" align="center" width="10">
                                                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                                        </td>
                                                        <td width="50" align="right">
                                                            <asp:DropDownList ID="ddlSubmitAdd" runat="server" CssClass="fontHead">
                                                                <asp:ListItem Text="0" Value="0">
                                                                </asp:ListItem>
                                                                <asp:ListItem Text="1" Value="1" Selected="True">
                                                                </asp:ListItem>
                                                                <asp:ListItem Text="5" Value="5">
                                                                </asp:ListItem>
                                                                <asp:ListItem Text="10" Value="10">
                                                                </asp:ListItem>
                                                                <asp:ListItem Text="15" Value="15">
                                                                </asp:ListItem>
                                                                <asp:ListItem Text="20" Value="20">
                                                                </asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td width="50">
                                                            <cc1:ConfirmedImageButton ID="btnSubmitAdd" runat="server" Message="NONE" />
                                                        </td>
                                                        <td></td>
                                                                            

                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>

                        </td>
                        <td valign="top">
                            <table height="26" cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="White">
                                <tr>
                                    <td valign="bottom" bgcolor="White">
                                        <cc2:YSTabView ID="tabComment" runat="server"></cc2:YSTabView>
                                    </td>
                                </tr>
                            </table>
                            <asp:Panel ID="pnlSubmitComment" runat="server">
                                <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
                                    <tr class="TableHeader">
                                        <td valign="middle" align="center" width="20">
                                        </td>
                                        <td class="fontHead">
                                            <asp:Label ID="lblComment" runat="server">Comments</asp:Label>
                                        </td>
                                    </tr>
                                </table>
                                <table cellspacing="0" width="450" cellpadding="0" style="border: 1px solid #F0F0F0;
                                    background-color: #FFFFFF;">
                                    <tr>
                                        <td height="400" align="left" valign="top">
                                            <asp:TextBox ID="txtSubmitComment" runat="server" Height="400px" Width="445px" TextMode="MultiLine"></asp:TextBox>
                                            <asp:HiddenField runat="server" ID="hdnSubmitComment" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <asp:Panel ID="pnlComment" runat="server">
                                <table cellspacing="0" width="450" cellpadding="0" style="border: 1px solid #F0F0F0;
                                    background-color: #FFFFFF;">
                                    <tr>
                                        <td height="400" align="left" valign="top">
                                            <asp:PlaceHolder ID="plhComments" runat="server"></asp:PlaceHolder>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <asp:Panel ID="pnlAttachment" runat="server">
                                <table cellspacing="0" width="450" cellpadding="0" style="border: 1px solid #F0F0F0;
                                    background-color: #FFFFFF;">
                                    <tr>
                                        <td height="400" align="left" valign="top">
                                            <asp:PlaceHolder ID="plhAttachment" runat="server"></asp:PlaceHolder>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table id="Table1" height="24" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
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
    <asp:HiddenField ID="hd_SessionName" runat="server" />
    <asp:HiddenField ID="hd_SessionDate" runat="server" />
    <asp:HiddenField ID="hdnXmlFiles" runat="server" />
    
    <!--    
    <div id="google_translate_element"></div><script>
                                                 function googleTranslateElementInit() {
                                                     new google.translate.TranslateElement({
                                                         pageLanguage: 'en',
                                                         includedLanguages: 'zh-CN,zh-TW,es,vi'
                                                     }, 'google_translate_element');
                                                 }
    </script><script src="http://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
    -->
    
    
    </form>
    <script type="text/javascript">
        for (var i = 0, len = Page_Validators.length; i < len; i++) {
            Page_Validators[i].display = "Dynamic";
            Page_Validators[i].style.visibility = "visible";
        }

        Page_ClientValidate();
    </script>
    <script language="javascript">
            function btnClose_Click() {
                <%= strExitScript %>
                return false;
            }
        </script>
</body>
</html>
