<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_StylePage_NewQuotationsQuickLibrary.aspx.vb" Inherits="plmOnApp.Sourcing_StylePage_NewQuotationsQuickLibrary" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<%@ Register src="Sourcing_Header.ascx" tagname="Sourcing_Header" tagprefix="hc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
		<title runat="server" id="pgTitle">Quick Quote</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	</HEAD>
	<body MS_POSITIONING="GridLayout">
		<form id="Form1" method="post" runat="server">
         <wc1:Color_Wait ID="Color_Wait" runat="server" />
       
 <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
            border="0" runat="server">
        <tr>
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td width="100%">
                <cc1:confirmedimagebutton id="btnGenerate" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                <cc1:confirmedimagebutton id="btnShare" runat="server" Message="NONE" CausesValidation="true" ValidationGroup="TechPack"></cc1:confirmedimagebutton>
                <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="false" OnClientClick="return btnClose_Click();"></cc1:confirmedimagebutton>
            </td>
            <td>
                &nbsp;
            </td>
        </tr>
        </table>
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr>
            <td valign="top" bgcolor="#ffffff">
                <table height="100%" cellspacing="0" cellpadding="0" width="100%"  style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="25"
        cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                    <tr>
                        <td valign="top" colspan="2" height="30">
                            <asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                                ForeColor="#E0E0E0"></asp:Label>&nbsp;
                        </td>
                        <td valign="top" height="30">
                        </td>
                    </tr>
                </table>

            </td>
        </tr>
        </table>

    <hc1:Sourcing_Header id="Sourcing_Header" runat="server" ></hc1:Sourcing_Header>

    <table border="0" cellpadding="0" cellspacing="0" style="height:900px;width:100%">
<tr>
<td style="width:48%" align="left" valign="top">

<table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
        border="0">
        <tr>
            <td valign="middle" align="center" width="10">
                <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
            </td>
            <td width="100%">
               <asp:Label id="lblBOM" runat="server">Select Styles</asp:Label>
               
            </td>

        </tr>
        </table>

			<table height="15" cellSpacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table id="Table3" height="45">
							<tr>
								<td>
									<asp:imagebutton id="imgBtnSearch" runat="server" CausesValidation="false"></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<asp:PlaceHolder id="phStyleGrid" runat="server"></asp:PlaceHolder>
</td>

<td style="width: 2px;height:900px" valign="top"><img alt="" src="../System/Images/Login_Bar.gif" style="width: 2px; height: 900px;" />&nbsp;</td>


<td align="left" valign="top">
        <table class="TableHeader" height="27" cellspacing="0" cellpadding="0" width="100%"
        border="0">
            <tr>
                <td valign="middle" align="center" width="10">
                    <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                </td>
                <td width="100%">
                   <asp:Label id="Label1" runat="server">Select Agent Vendor</asp:Label>
               
                </td>

            </tr>
        </table>

        <table height="15" cellSpacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder2" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table id="Table1" height="45">
							<tr>
								<td>
									<asp:imagebutton id="imgBtnSearch2" runat="server" ></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
            <table cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="top">
					<td>
						<table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
							border="0">
							<tr valign="middle">
								<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td width="16"></td>
								<td class="fontHead" width="100">
                                    <asp:Label ID="lblThumbnail" runat="server" ></asp:Label></td>
								<td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
								<td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
								<td noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
								<td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
								<td width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></td>
								<td width="10">&nbsp;</td>
								<td noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>
								<td class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></td>
								<td width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
										<asp:ListItem Value="5">5</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="20">20</asp:ListItem>
										<asp:ListItem Value="25">25</asp:ListItem>
										<asp:ListItem Value="30">30</asp:ListItem>
										<asp:ListItem Value="40">40</asp:ListItem>
										<asp:ListItem Value="50" Selected="True">50</asp:ListItem>
									</asp:dropdownlist></td>
								<td width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" ></asp:button></td>
							</tr>
						</table>    
						<asp:datagrid id="DataGrid1" runat="server" DataKeyField="SourcingTradePartnerID" BorderStyle="Solid" BorderWidth="1px">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
							<Columns>
							    <asp:TemplateColumn>
							        <HeaderTemplate>
							            <input type="checkbox" id="checkAll" onClick="CheckAllV(this);" runat="server" name="checkAll">
							        </HeaderTemplate>
									<ItemTemplate>
										<asp:CheckBox id="chkSelected" runat="server"></asp:CheckBox>
									</ItemTemplate>							        
							    </asp:TemplateColumn>
							    							
                            </Columns>
						</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label></td>
				</tr>
			</table>
<input id="hiddenCurrentPage2" type="hidden" value="0" name="hiddenCurrentPage2" runat="server">&nbsp;&nbsp;



</td>
</tr>
</table>

    </form>
    <script type="text/javascript" language="javascript">
        var frm = document.forms['Form1'];
        function CheckAllV(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkSelected") != -1)
                    e.checked = actVar;
            }
        }
        
        function btnClose_Click() {
            <%= strExitScript %>
            return false;
        }
	</script>
</body>
</html>
