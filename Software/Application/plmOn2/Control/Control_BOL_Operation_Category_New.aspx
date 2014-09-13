<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_BOL_Operation_Category_New.aspx.vb" Inherits="plmOnApp.Control_BOL_Operation_Category_New" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Operation Categories</title>
    <meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
    <meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
    <meta content="JavaScript" name="vs_defaultClientScript">
    <meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		
    <style type="text/css">
        .style4
        {
            width: 252px;
        }
        .style7
        {
            width: 1131px;
        }
        .style8
        {
            FONT-FAMILY: Tahoma, Geneva, Arial, Helvetica, sans-serif;
            FONT-WEIGHT: bold;
            FONT-SIZE: 11px;
            COLOR: Black;
            width: 414px;
        }
        .style9
        {
            FONT-FAMILY: Tahoma, Geneva, Arial, Helvetica, sans-serif;
            FONT-WEIGHT: bold;
            FONT-SIZE: 11px;
            COLOR: Black;
            width: 52px;
        }
        .style11
        {
            width: 924px;
        }
        .style12
        {
            width: 98px;
        }
        .style15
        {
            width: 27%;
        }
        .style16
        {
            width: 97px;
        }
        .style17
        {
            FONT-FAMILY: Tahoma, Geneva, Arial, Helvetica, sans-serif;
            FONT-WEIGHT: normal;
            FONT-SIZE: 11px;
            COLOR: Black;
            width: 52px;
        }
        .style18
        {
            width: 52px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <wc1:Color_Wait ID="Color_Wait" runat="server" />
        <asp:Panel ID="pnlAddSave" runat="server">
		 <table class="TableHeader" id="toolbar1" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3"><asp:ImageButton ID="btnInvSearch"
                        runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" TabIndex="0" />
                </td><td>
  
                    <cc1:ConfirmedImageButton ID="btnAddNewCategory" runat="server" 
                    Message="NONE" CausesValidation="True"></cc1:ConfirmedImageButton>
	            </td>
                <td align="right" width="75"></td>
                <td width="40"></td>
                <td></td>
			</tr>
		</table>
		
		</asp:Panel>
		
		
		<asp:Panel ID="pnlNewCategory" runat="server">
		    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
            height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                <tr>
                    <td align="left" style="width:50%">
                        <B class="fonthead">&nbsp;<asp:Label  ID="lblNewCategory" runat="server"></asp:Label></B>
                        <asp:TextBox  Width="200px" ID="txtNewCategory" runat="server" CssClass="font" MaxLength="60"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="CategoryNameValidator" runat="server" ControlToValidate="txtNewCategory" 
                        ErrorMessage="*" Display="Dynamic" CssClass="fontHead" ToolTip ="Category Required" SetFocusOnError="True" InitialValue="">
                        </asp:RequiredFieldValidator>
                    </td>                  
                </tr>
            </table>			
		</asp:Panel>			
        
      
	<br>
	 <div id="DataHolder1" runat="server">

        <asp:PlaceHolder ID="plhLanguage" runat="server"></asp:PlaceHolder>
		<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
			runat="server">
			<tr vAlign="middle">
				<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				<td>
					<asp:imagebutton id="Imagebutton1" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px"
						Height="0px" />
					<cc1:confirmedimagebutton id="btnNew" runat="server" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
				</td>
				<td>&nbsp;</td>
			</tr>
		</table>    
		
		<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
			height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr>
				<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
			</tr>
		</table>

        <table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr vAlign="top">
				<td>
					<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
						border="0">
						<tr vAlign="middle">
							<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
							<td width="20"><asp:imagebutton id="btnImgFirst" runat="server" CausesValidation="false"></asp:imagebutton></td>
							<td width="20"><asp:imagebutton id="btnImgPrevious" runat="server" CausesValidation="false"></asp:imagebutton></td>
							<td noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
							<td width="20"><asp:imagebutton id="btnImgNext" runat="server" CausesValidation="false"></asp:imagebutton></td>
							<td width="20"><asp:imagebutton id="btnImgLast" runat="server" CausesValidation="false"></asp:imagebutton></td>
							<td width="10">&nbsp;</td>
							<td noWrap><asp:label id="RecordCount" runat="server" CssClass="fontHead"></asp:label></td>
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
							<td width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" CausesValidation="False"></asp:button></td>
						</td>
					</TABLE>
					<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
						<tr>
							<td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
							<td vAlign="top" width="100%">
								<table height="45">
									<tr>
										<td><asp:imagebutton id="imgBtnSearch" runat="server" CausesValidation="false"></asp:imagebutton></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					<asp:datagrid id="DataGrid1" runat="server" AllowSorting="True" >
						<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
						<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
						<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
						<PagerStyle Visible="False"></PagerStyle>
					</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
			    </td>
			</tr>
		</TABLE>
				
    </div>
	
	 </form>
</body>