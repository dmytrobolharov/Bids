<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_BOL_Template_Subcategory_Edit.aspx.vb" Inherits="plmOnApp.Control_BOL_Template_Subcategory_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Template Subcategories</title>
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
        <asp:Panel ID="pnlAddSave" runat="server">
		 <table class="TableHeader" id="toolbar1" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3"><asp:ImageButton ID="btnInvSearch"
                        runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" TabIndex="0" />
                </td><td>
                <cc1:ConfirmedImageButton ID="btnNewType" runat="server" 
                    Message="NONE" CausesValidation="True"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnSaveSubcategory" runat="server" 
                    Message="NONE" CausesValidation="True"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnAddNewType" runat="server" 
                    Message="NONE" CausesValidation="True"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnClose" runat="server" 
                    Message="NONE" CausesValidation="False"></cc1:ConfirmedImageButton>
                    <cc1:ConfirmedImageButton ID="btnDeleteSubcat" runat="server" 
                    Message="NONE" CausesValidation="False"></cc1:ConfirmedImageButton>
	            </td>
                
                <td align="right" width="75"></td>
                <td width="40"></td>
                <td></td>
			</tr>
		</table>
		
		</asp:Panel>
		
		
		<asp:Panel ID="pnlNewType" runat="server">
		    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
            height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
                <tr>
                    <td align="left" style="width:50%"><B class="fonthead">&nbsp;
                        <asp:Label  ID="lblNewType" runat="server"></asp:Label>
                        <asp:TextBox  Width="200px" ID="txtNewType" runat="server" CssClass="font" MaxLength="60"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="CategoryNameValidator" runat="server" ControlToValidate="txtNewType"
                        ErrorMessage="*" Display="Dynamic" CssClass="fontHead" ToolTip ="Category Required"></asp:RequiredFieldValidator>
                    </td>                  
                </tr>
            </table>			
		</asp:Panel>			
        
        <asp:Panel ID="pnlSubcategory" runat="server">
        <table ID="tblHeader" runat="server" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
		    height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
		    <tr>
			    <td>&nbsp;<asp:label id="lblHeader1" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
		    </tr>
		</table>    
                    
        <table bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0"  ID="tblEd" runat="server"
            style="border-bottom: orange thin solid; border-left-style: none; background-color: white" 
            width="100%">           

            <tr>
                 <td align="left">
                     <table bgcolor="#FFFFFF" border="0" cellpadding="0" cellspacing="1" 
                        width="100%">
                        <tr valign="top" width="100%">  
                            <td align="left" width="100%">
                                <asp:Label ID="lblEditSubcategory" runat="server"></asp:Label>
                                <asp:TextBox Width="200px" ID="txtSubcategory" runat="server" CssClass="fontHead" MaxLength="60"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtSubcategory"
                                ErrorMessage="*" Display="Dynamic" CssClass="fontHead" ToolTip ="Category Required"></asp:RequiredFieldValidator>
                            </td>
                        </tr>
                    </table>
                   </td>                  
            </tr>
            <tr>                    
                <td align="left">                        
                    <asp:CheckBox ID="chkActive" runat="server" Checked="" />
                    <asp:Label ID="lblActiveS" runat="server"></asp:Label>
                </td>
                <td align="right" class="style8">
                    <asp:Label ID="lblLastModifiedLabel" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>

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
							<td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
							<td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
							<td noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
							<td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
							<td width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></td>
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
							<td width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead" ></asp:button></td>
						</td>
					</TABLE>
					<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
						<tr>
							<td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
							<td vAlign="top" width="100%">
								<table height="45">
									<tr>
										<td><asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					<asp:datagrid id="DataGrid1" runat="server" AllowSorting="true" >
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
</html>