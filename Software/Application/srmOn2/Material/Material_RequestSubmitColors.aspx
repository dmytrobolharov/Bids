<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_RequestSubmitColors.aspx.vb" Inherits="srmOnApp.Material_RequestSubmitColors" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc2" TagName="Material_Header" Src="Material_Header.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<title runat="server" id="PageTitle">Material Colors</title>
    <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />		
    <link href="../System/CSS/Grid.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Tree.css" rel="stylesheet" type="text/css" />    
	<script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    
			<table class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" 
                height="25" border="0">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server" visible="true" Message="NONE"/>
					</td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Material Request</asp:label></td>
				</tr>
			</table>
			<table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr class="TableHeader">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="20"><asp:imagebutton id="imbBtnExpand" runat="server" ImageUrl="../System/Icons/icon_Next.gif" ToolTip="Show Material Header..."></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif" ToolTip="Hide Material Header..."></asp:imagebutton></td>
					<td class="fontHead">&nbsp;
						<asp:label id="lblMaterialDetail" runat="server"></asp:label></td>
				</tr>
			</table>
			<br />
            <cc2:YSTabView ID="YSTabView1" runat="server" />
			<asp:panel id="Panel1" runat="server" CssClass="font" BorderWidth="0" BackColor="#ffffff" Width="100%">
				<table height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
					<tr>
						<td width="900">
							<uc2:Material_Header id="Material_Header1" runat="server"></uc2:Material_Header></td>
					
					
						<td>&nbsp;</td>
					</tr>
				</table>
			</asp:panel>
			<asp:Panel ID="pnlColors" runat="server">
	        <table cellspacing="0" bgcolor="White" border="0" cellpadding="0" width="100%">
                <tr >
                    <td valign="top" bgcolor="White"  > 
                        <table cellSpacing="1" cellPadding="0" width="100%" border="0">
                            <tr>
                                <td class="fontHead"><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
                            </tr>
                        </table>
                   
                        <table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
                            <tr class="TableHeader">
                                <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                                <td class="fontHead">&nbsp;<asp:label id="lblSubmitGrid" runat="server"></asp:label></td>
                            </tr>
                        </table>
                        
                             <asp:datagrid id="dgMaterial" runat="server"
                                DataKeyField="MaterialTradePartnerColorID" AllowSorting="true" AutoGenerateColumns="False" BackColor="White" >
                                <PagerStyle />
                                <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
                                <ItemStyle Height="20px" CssClass="font"></ItemStyle>
                                <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                            </asp:datagrid>	
                                          			

                        <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
                    </td>
                </tr>
            </table>
             </asp:Panel> 
            <asp:Panel ID="pnlWorkflow" runat="server">                      
                <asp:datagrid id="dgMaterialRequest" runat="server" AllowSorting="true"
                    DataKeyField="MaterialTradePartnerColorID" AutoGenerateColumns="false" BackColor="White">
                    <PagerStyle />
                    <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="font"></ItemStyle>
                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                </asp:datagrid>
            </asp:Panel>            					
           
            
            					
    </form>
</body>
</html>
