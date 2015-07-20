
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Vendor_Folder_Main.aspx.vb" Inherits="plmOnApp.Vendor_Folder_Main" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Vendor_Folder_Contact" Src="Vendor_Folder_Contact.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Vendor_Folder_Address" Src="Vendor_Folder_Address.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>Trading Partner</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	<link href="../System/CSS/CheckListDropDown.css" type="text/css" rel="stylesheet"/>		
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <script language="javascript">
    
//            if (window.screen) {
//                var aw = screen.availWidth;
//                var ah = screen.availHeight;
//                window.moveTo(0, 0);
//                window.resizeTo(aw, ah);
//            }
//			
			function calendar(sTxtBoxName)
			{
			windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName,"dp","toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
			windowDatePicker.focus();
			}
    </script>

</head>
<body>
    <form id="Form1" method="post" runat="server">

    <telerik:RadScriptManager ID="RadScriptManager1" runat="server" >
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
        </Scripts>
        <CdnSettings TelerikCdn="Disabled" />
    </telerik:RadScriptManager>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" Runat="server">
        <StyleSheets>
            <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
        </StyleSheets>
        <CdnSettings TelerikCdn="Disabled" />
    </telerik:RadStyleSheetManager>
    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" />

    <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td width="100%">
                <cc2:ConfirmedImageButton ID="btnSave" runat="server"  Message="NONE" OnClientClick="ClearEventTarget();"></cc2:ConfirmedImageButton>
                <cc2:BWImageButton ID="btnPassword" runat="server"  ToolBar="False" Status="False" ScrollBars="False" Resizable="False" MenuBar="False" Location="False" WindowHeight="250px" WindowWidth="600px" WindowName="Vendor_Folder_Edit_Password" NavigateUrl="Vendor_Folder_Edit_Password.aspx"></cc2:BWImageButton>
                <cc2:BWImageButton ID="btnGoTo" runat="server" ToolTip="Go to vendor folder" CausesValidation="false" />
                <cc2:BWImageButton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;" />
                <cc2:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="window.top.close(); return false;"></cc2:ConfirmedImageButton>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top" bgcolor="#ffffff">
                <table height="100%" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td valign="top" colspan="2" height="50">
                            <asp:Label ID="lblTradeName" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                                ForeColor="#E0E0E0"></asp:Label>&nbsp;
                        </td>
                        <td valign="top" height="50">
                        </td>
                    </tr>
                </table>
                <table id="Table2" cellspacing="2" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td>
                            <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
                        </td>
                    </tr>
                </table>
                <br />
                <cc1:YSTabView ID="YSTabView1" runat="server"></cc1:YSTabView>
            </td>
        </tr>
    </table>
    <asp:Panel ID="pnlContact" runat="server">
        <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
            border="0">
            <tr>
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                </td>
                <td width="100%">
                    <cc2:BWImageButton ID="btnAddContact" runat="server" >
                    </cc2:BWImageButton>
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
        <asp:datagrid id="dgContacts" runat="server" AllowSorting="True" DataKeyField="TradePartnerContactID" EnableViewState="true">
				<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
				<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn ItemStyle-BorderWidth="1" ItemStyle-BorderColor="Gainsboro">
						<HeaderStyle></HeaderStyle>
						<ItemStyle></ItemStyle>
						<HeaderTemplate>
							<%--<asp:label id="lblEdit" runat="server" CssClass="fonthead"><%#GetSystemText("Edit")%></asp:label>--%>
						</HeaderTemplate>
						<ItemTemplate>
							<span style="width:25px"><cc2:confirmedimagebutton id="btnEdit" runat="server" Message="NONE" 
							    CommandName="Edit" ImageUrl="../System/Icons/icon_edit.gif" OnClientClick="setEventTarget_EDIT()"></cc2:confirmedimagebutton></span>
						</ItemTemplate>
						<EditItemTemplate>
						    <uc1:Vendor_Folder_Contact ID="Vendor_Folder_Contact1" runat="server" ContactID='<%# DataBinder.Eval(Container.DataItem, "TradePartnerContactID").ToString() %>'></uc1:Vendor_Folder_Contact>
                        </EditItemTemplate>
					</asp:TemplateColumn>
				</Columns>
				<PagerStyle Visible="False"></PagerStyle>
		</asp:datagrid><asp:label id="ContactSortOrder" runat="server" Visible="False"></asp:label>
    </asp:Panel>
    
    <asp:Panel ID="pnlAddress" runat="server">
        <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
            border="0">
            <tr>
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                </td>
                <td width="100%">
                    <cc2:BWImageButton ID="btnAddAddress" runat="server" >
                    </cc2:BWImageButton>
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
        <asp:datagrid id="dgAddress" runat="server" AllowSorting="True" DataKeyField="TradePartnerAddressID" EnableViewState="true">
				<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
				<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn ItemStyle-BorderWidth="1" ItemStyle-BorderColor="Gainsboro">
						<HeaderStyle></HeaderStyle>
						<ItemStyle></ItemStyle>
						<HeaderTemplate>
							<%--<asp:label id="lblEdit" runat="server" CssClass="fonthead"><%#GetSystemText("Edit")%></asp:label>--%>
						</HeaderTemplate>
						<ItemTemplate>
							<span style="width:25px"><cc2:confirmedimagebutton id="btnEdit" runat="server" Message="NONE" 
							    CommandName="Edit" ImageUrl="../System/Icons/icon_edit.gif" OnClientClick="setEventTarget_EDIT()"></cc2:confirmedimagebutton></span>
						</ItemTemplate>
						<EditItemTemplate>
						    <uc2:Vendor_Folder_Address ID="Vendor_Folder_Address1" runat="server" AddressID='<%# DataBinder.Eval(Container.DataItem, "TradePartnerAddressID").ToString() %>'></uc2:Vendor_Folder_Address>
                        </EditItemTemplate>
					</asp:TemplateColumn>
				</Columns>
				<PagerStyle Visible="False"></PagerStyle>
		</asp:datagrid><asp:label id="AddressSortOrder" runat="server" Visible="False"></asp:label>
    </asp:Panel>       
    </form>
</body>

<script language="javascript">

    function setEventTarget_EDIT() {
        document.getElementById("__EVENTTARGET").value = 'btnEdit';
    }

    function ClearEventTarget() {
        document.getElementById("__EVENTTARGET").value = '';
    }

</script>

</html>