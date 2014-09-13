<%@ Register TagPrefix="uc1" TagName="Style_Costing_Material" Src="../Style/Style_Costing_Material.ascx" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="QuoteItem_EditCost.aspx.vb"
    Inherits="srmOnApp.QuoteItem_EditCost" %>

<%@ Register TagPrefix="uc1" TagName="QuoteItem_Document" Src="QuoteItem_Document.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="../Style/Style_Header.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc2" TagName="Quote_Comment" Src="Quote_Comment.ascx" %>
<%@ Register TagPrefix="uc3" TagName="Sourcing_Partner_Header" Src="../Sourcing/Sourcing_Partner_Header.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
    <title runat="server" id="PageTitle">Quotation</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR"/>
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE"/>
    <meta content="JavaScript" name="vs_defaultClientScript"/>
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"/>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet"/>
    <link href="../System/CSS/RadGrid.YPLM.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/RadComboBox.YPLM.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet"/>
    <script language="javascript" type="text/javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
    <script type="text/javascript"  language="javascript">
//        function calendar(sTxtBoxName) {
//            windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName, "dp", "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
//            windowDatePicker.focus();
//        }
//        function customwindow(strWindowUrl) {
//            windowCustom = window.open("../System/Control/" + strWindowUrl + "", "Custom", "toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=800,height=600,left=50,top=50");
//            windowCustom.focus();
//        }
//    </script>
</head>
<body>
    <form id="Form1" method="post" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" />
    <table class="TableHeader" id="toolbar" height="24" cellspacing="0" cellpadding="0"
        width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnSaveStyle" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                 <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"></cc1:confirmedimagebutton>
            </td>
        </tr>
    </table>
   <!-- <asp:PlaceHolder ID="phSeasonYearColor" runat="server"></asp:PlaceHolder>-->
    <uc3:Sourcing_Partner_Header runat="server" ID="Sourcing_Partner_Header1" Visible='<%# NewPartnerManagement %>' />
    <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tbody>
            <tr>
                <td align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td class="fontHead" width="25">
                    <div align="center">
                        <asp:Image ID="imgQuoteStatus" runat="server" ImageUrl="../System/Icons/icon_ball_gray.gif">
                        </asp:Image></div>
                </td>
                <td class="fontHead" valign="middle">
                    <asp:Label ID="lbCostType" runat="server"></asp:Label>&nbsp;<asp:Label ID="lblQuoteStatus"
                        runat="server"></asp:Label>&nbsp;
                    <cc1:ConfirmedLinkButton ID="hl_Status" runat="server" Message='<%#GetSystemText("Are you sure you want to edit status?")%>'></cc1:ConfirmedLinkButton>
                </td>
                <td class="fontHead" valign="middle" align="center" width="25">
                </td>
            </tr>
        </tbody>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">        
        <tr>        
            <td width="850">
                <uc1:Style_Header ID="Style_Header1" runat="server"></uc1:Style_Header>
            </td>
            <td>
                <cc1:BWImageButton ID="imgDesign" runat="server"></cc1:BWImageButton>
            </td>
        </tr>
    </table>
    <br />
    <br />
    <table cellpadding="0" cellspacing="0" width="100%" bgcolor="#ffffff" border="0"
        bordercolor="red">
        <tr>
            <td width="50%">
                <table>
                <tr>
                    <asp:Panel ID="pnlVendorInfo" runat="server">
                        <td>
                            <table height="21" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td>
                                        &nbsp;
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                                <tr>
                                    <td valign="top" width="300">
                                        <table height="30" cellspacing="0" cellpadding="0" width="100%" border="0">
                                            <tr class="TableHeaderYellow">
                                                <td valign="middle" align="center" width="10">
                                                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                                                </td>
                                                <td class="fontHead">
                                                    &nbsp;<asp:Label ID="lblVendor" runat="server">Vendor</asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                        <table id="Table3" bordercolor="#ffffff" cellspacing="2" cellpadding="2" border="3">
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lbVendorName" runat="server" CssClass="fonthead"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lbVendorAddress1" runat="server" CssClass="font"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lbVendorAddress2" runat="server" CssClass="font"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lbVendorCityState" runat="server" CssClass="font"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td valign="top">
                                        <table height="30" cellspacing="0" cellpadding="0" width="100%" border="0">
                                            <tr class="TableHeader">
                                                <td valign="middle" align="center" width="10">
                                                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                                </td>
                                                <td class="fontHead">
                                                    &nbsp;
                                                    <asp:Label ID="lbHeaderTradePartner" runat="server" Text='<%# Yunique.Core.Library.ConfigHandler.GetAppSettings(Yunique.Core.Library.ConfigHandler.AppSettings("TRADEPARTNER"))("TradePartnerAgent") %>'
                                                        CssClass="fonthead">
                                                    </asp:Label>&nbsp;(<asp:Label ID="lblTradePartnerClass" runat="server" CssClass="fontHead"></asp:Label>)
                                                </td>
                                            </tr>
                                        </table>
                                        <table bordercolor="#ffffff" cellspacing="2" cellpadding="2" border="3">
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lbTradePartnerName" runat="server" CssClass="fonthead"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lbAddress1" runat="server" CssClass="font"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lbAddress2" runat="server" CssClass="font"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lbCityState" runat="server" CssClass="font"></asp:Label>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </asp:Panel>
                    <td>
                    <asp:Panel Visible="False" runat="server">
                    <table cellspacing="1" cellpadding="1" width="100%" bgcolor="#ffffff" border="0">
                    <tr valign="top">
                        <td width="100%">
                            <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr class="TableHeaderYellow">
                                    <td valign="middle" align="center" width="10">
                                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                    </td>
                                    <td class="fontHead">
                                        &nbsp;
                                        <asp:Label ID="lblVendorQuote" runat="server" Text="Vendor Quote" CssClass="fonthead"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <asp:PlaceHolder ID="plhVendorQuote" runat="server"></asp:PlaceHolder>
                        </td>
                        <asp:Panel runat="server" Visible='false' ID='pnladdcost'>
                            <td valign="top">
                                <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%"
                                    border="0">
                                    <tr height="25">
                                        <td valign="middle" align="center" width="5px">
                                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                                        </td>
                                        <td class="fontHead" align="left" width="100%">
                                            <asp:Label ID="lblAdditionalCost" runat="server">Additional Cost</asp:Label>
                                        </td>
                                    </tr>
                                    <tr id="trAdditionalCost">
                                        <td colspan="2" valign="top" width="100%">
                                            <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                                <tr>
                                                    <td>
                                                        <table cellspacing="0" cellpadding="0" width="100%" border="0">
                                                            <tr>
                                                                <td>
                                                                    <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
                                                                        <tr>
                                                                            <td align="center" width="3">
                                                                                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                                                                            </td>
                                                                            <td class="fontHead" width="100">
                                                                                <asp:Label ID="lblMaterialSizeType" runat="server"></asp:Label>
                                                                            </td>
                                                                            <td height="30">
                                                                                <table id="TbTrim" cellspacing="0" cellpadding="0" width="250" border="0" runat="server">
                                                                                    <tr class="fontHead">
                                                                                        <td>
                                                                                            &nbsp;
                                                                                        </td>
                                                                                        <td nowrap width="85">
                                                                                            <asp:Label ID="lblNoofRow" runat="server" Text="No. of Row(s):"></asp:Label>
                                                                                        </td>
                                                                                        <td width="35">
                                                                                            <asp:DropDownList ID="dpNewRow" runat="server" CssClass="fontHead">
                                                                                                <asp:ListItem Value="1" Selected="True">1</asp:ListItem>
                                                                                                <asp:ListItem Value="2">2</asp:ListItem>
                                                                                                <asp:ListItem Value="3">3</asp:ListItem>
                                                                                                <asp:ListItem Value="4">4</asp:ListItem>
                                                                                                <asp:ListItem Value="5">5</asp:ListItem>
                                                                                                <asp:ListItem Value="10">10</asp:ListItem>
                                                                                                <asp:ListItem Value="15">15</asp:ListItem>
                                                                                                <asp:ListItem Value="20">20</asp:ListItem>
                                                                                            </asp:DropDownList>
                                                                                        </td>
                                                                                        <td>
                                                                                            <cc1:ConfirmedImageButton ID="imgBtnAdd" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
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
                                                                    <table id="TD_ImgFolder" cellspacing="1" cellpadding="0" border="0" runat="server">
                                                                        <tr bgcolor="#ffffff">
                                                                            <td>
                                                                                <cc1:ConfirmedImageButton ID="btnDelete" runat="server" visible="false" Message="NONE"></cc1:ConfirmedImageButton>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:DataGrid ID="Datagrid1" runat="server" OnItemDataBound="Datagrid1_ItemEventHandler"
                                                                        DataKeyField="SourcingAdditionalCostID" Width="250" AutoGenerateColumns="False"
                                                                        PageSize="1000" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0">
                                                                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
                                                                        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
                                                                        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                                                                        <FooterStyle></FooterStyle>
                                                                        <Columns>
                                                                            <asp:TemplateColumn>
                                                                                <HeaderTemplate>
                                                                                    <input type="checkbox" id="checkAll" onclick="CheckAll(this);" runat="server" name="checkAll" />
                                                                                </HeaderTemplate>
                                                                                <ItemTemplate>
                                                                                    <asp:CheckBox ID="chkDelete" runat="server"></asp:CheckBox>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateColumn>
                                                                            <asp:TemplateColumn>
                                                                                <HeaderTemplate>
                                                                                    <asp:Label ID="lblDescription" runat="server"></asp:Label>
                                                                                </HeaderTemplate>
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtDescription" runat="server" BorderWidth="1px" BorderStyle="Solid"
                                                                                        BorderColor="#E0E0E0" MaxLength="100" Columns="30"></asp:TextBox>
                                                                                    <asp:HiddenField ID="hdnDescription" runat="server" />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateColumn>
                                                                            <asp:TemplateColumn>
                                                                                <HeaderTemplate>
                                                                                    <div align="center">
                                                                                        <asp:Label ID="lblAmount" runat="server"></asp:Label>
                                                                                    </div>
                                                                                </HeaderTemplate>
                                                                                <ItemTemplate>
                                                                                    <asp:TextBox ID="txtAmount" runat="Server" BorderWidth="1px" BorderStyle="Solid"
                                                                                        BorderColor="#E0E0E0" MaxLength="5" Columns="5"></asp:TextBox>
                                                                                    <asp:HiddenField ID="hdnAmount" runat="server" />
                                                                                </ItemTemplate>
                                                                            </asp:TemplateColumn>
                                                                        </Columns>
                                                                    </asp:DataGrid>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </asp:Panel>
                    </tr>
                </table>
                </td>
                <td valign="top" width="50%">
                    
                </td>
                </tr>
                </table>

                <asp:Panel ID="MainMaterial" runat="server">
                    <table class="TableHeader" id="Table1" height="25" cellspacing="0" cellpadding="0"
                        width="100%" border="0" runat="server">
                        <tr valign="middle">
                            <td valign="middle" align="center" width="10">
                                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                            </td>
                            <td>
                                &nbsp;<asp:Label ID="lblMainMaterial" runat="server">Main Material</asp:Label>
                            </td>
                        </tr>
                    </table>
                    <table id="Table2" cellspacing="0" cellpadding="0" width="100%" border="0">
                        <tr>
                            <td valign="top" width="900" bgcolor="#ffffff">
                                <asp:PlaceHolder ID="phStyleMaterial" runat="server"></asp:PlaceHolder>
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
                <asp:Panel ID="DimInfo" runat="server">
                    <table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%"
                        border="0">
                        <tr>
                            <td valign="middle" align="center" width="10">
                                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                            </td>
                            <td width="100%">
                                <asp:Label ID="lblQuotationDetails" runat="server">Quotation Details</asp:Label>
                            </td>
                        </tr>
                    </table>
                    
                </asp:Panel>
                </asp:Panel>


                <cc2:YSTabView ID="YSTabView1" runat="server"></cc2:YSTabView>
                    <asp:Panel ID="pnlComments" runat="server">
                        <uc2:Quote_Comment ID="Quote_Comment1" runat="server"></uc2:Quote_Comment>
                    </asp:Panel>
                    <asp:Panel ID="pnlAttachment" runat="server">
                        <uc1:QuoteItem_Document ID="QuoteItem_Document1" runat="server"></uc1:QuoteItem_Document>
                    </asp:Panel>
                    <br /><br />


                    
                <asp:Panel ID="pnlBOMOptions" runat="server">
            <table class="TableHeader CollapsibleHeader" height="30" cellspacing="0" cellpadding="0" width="100%" border="0">
                <tr>
                    <td>
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td valign="middle" align="center" width="10">
                                    <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                                </td>
                                <td width="20">
                                    <asp:ImageButton ID="imgBtnToggleOption" OnClientClick="return toggleSectionVisibility(this);" runat="server"
                                        ImageUrl="../System/Icons/icon_Down.gif"></asp:ImageButton>
                                </td>
                                <td valign="middle" align="center" class="fonthead" style="padding: 0 10px;">
                                    <asp:Label ID="lblBOMOptions" runat="server" ><%= GetSystemText("Cost by Quantity Options")%> </asp:Label>
                                </td>
                                <td>
                                    <asp:ImageButton ID="btnOptionAdd" runat="server" />
                                   <!-- <asp:ImageButton ID="btnOptionSave" runat="server" />-->
                                </td>
                                <td valign="middle" class="fonthead" style="padding: 0 10px;">
                                <table cellspacing="0" cellpadding="0">
            <tr>
             <td class="fonthead">  <asp:Label id="lblMinQNT" runat="server" Text=""><%= GetSystemText("Minimum Quantity")%></asp:Label>:&nbsp;&nbsp;</td>
             <td>  <asp:TextBox ID="txtMinQNT" runat="server" Width="40"></asp:TextBox>&nbsp;&nbsp;</td>
            
             <td>  <cc1:confirmedimagebutton id="btnMinQNT" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
               </tr>
               </table>
               </td>
               <td valign="middle" class="fonthead" style="padding: 0 10px;">
                  <table cellspacing="0" cellpadding="0">
            <tr>
             <td class="fonthead">  <asp:Label id="lblMaxQNT" runat="server" text=""><%= GetSystemText("Maximum Quantity")%></asp:Label>:&nbsp;&nbsp;</td>
             <td>  <asp:TextBox ID="txtMaxQNT" runat="server" Width="40"></asp:TextBox>&nbsp;&nbsp;</td>
            
             <td>  <cc1:confirmedimagebutton id="btnMaxQNT" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
               </tr>
               </table>
               </td>

               <td valign="middle" class="fonthead" style="padding: 0 10px;">
                  <table cellspacing="0" cellpadding="0">
            <tr>
             <td class="fonthead">  <asp:Label id="lblCostQNT" runat="server" Text=""><%= GetSystemText("Partner Cost/Quantity")%></asp:Label>:&nbsp;&nbsp;</td>
             <td>  <asp:TextBox ID="txtCostQNT" runat="server" Width="40"></asp:TextBox>&nbsp;&nbsp;</td>
            
             <td>  <cc1:confirmedimagebutton id="btnCostQNT" runat="server"  Message="NONE"></cc1:confirmedimagebutton></td>
               </tr>
               </table>


                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            

            <asp:Panel ID="hideBOMs" runat="server">
            <div id="divBOMOptionContent" class="Collapsible">
            <asp:Panel ID="CostDetail" runat="server">
                <cc2:YSTabView ID="YSTabView2" runat="server" />
                   
                    <asp:PlaceHolder ID="plhOptionEdit" runat="server"></asp:PlaceHolder>
                    
                <asp:DataGrid ID="DataGrid2" runat="server" DataKeyField="SourcingCostOptionDetailID"
                        AllowSorting="False" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                        AutoGenerateColumns="False">
                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
                        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
                        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                       <Columns>
                       <asp:TemplateColumn>
                        <HeaderTemplate>
                          <input type="checkbox" onclick="SelectAll(this)" id="chkSelectAll"></>  
                        </HeaderTemplate>
                         <ItemTemplate>
                        <asp:CheckBox id="chkSelect"  runat="server"></asp:checkbox>
                        </ItemTemplate>

                       </asp:TemplateColumn>
                       </Columns>
                    </asp:DataGrid>

                <asp:PlaceHolder ID="PlaceHolderSummary" runat="server"></asp:PlaceHolder>
                 </asp:Panel>
            </div>
           
        </asp:Panel>
        </asp:Panel>
            </td>

        </tr>
    </table>
    <br>
    </form>
</body>
    <script language="javascript" type="text/javascript">
        function toggleSectionVisibility(sender) {
		        var collapsibleDiv = $(sender).closest(".CollapsibleHeader").nextAll(".Collapsible")[0];
		        var hdnCollapsibleStatus = $(sender).siblings("input[id*='hdnIsExpanded']");

		        if (collapsibleDiv != null) {
                    // Saving status of collapsed section to hidden field
		            if ($(collapsibleDiv).is(":visible")) {
		                $(collapsibleDiv).hide();
		                sender.src = '../System/Icons/icon_Next.gif'
		                if ($(hdnCollapsibleStatus)[0] != null) {
		                    hdnCollapsibleStatus.val("false");
		                }
		            } else {
		                $(collapsibleDiv).show();
		                sender.src = '../System/Icons/icon_Down.gif'
		                if ($(hdnCollapsibleStatus)[0] != null) {
		                    hdnCollapsibleStatus.val("true");
		                }
		            }
		        }

		        return false;
		    }

		    // For toggling the expandable items to state, in which they were before postback
		    $("input[id*='hdnIsExpanded']").each(function () {
		        var collapsibleDiv = $(this).closest(".CollapsibleHeader").nextAll(".Collapsible")[0];
		        var btnToggle = $(this).siblings("input[id*='BtnToggle']");
		        if (collapsibleDiv != null && $(btnToggle)[0] != null) {
		            if (($(this).val() == 'false' && $(collapsibleDiv).is(":visible")) ||
                        ($(this).val() == 'true' && !$(collapsibleDiv).is(":visible"))
                        ) {
		                btnToggle.click();
		            }
		        }
		    });
    </script>
    <script type="text/javascript" language="javascript">
        var frm = document.forms['Form1'];
        function SelectAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkSelect") != -1)
                    e.checked = actVar;
            }
        }

	    
	    
	</script>   
</html>
