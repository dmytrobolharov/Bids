<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_RequestSubmitColors.aspx.vb" Inherits="plmOnApp.Material_RequestSubmitColors" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc2" TagName="Material_Header" Src="Material_Header.ascx" %>
<%@ Register TagPrefix="uc2" TagName="TradePartner_Header" Src="MaterialRequest_Partner_Header.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
	<title>Material Colors</title>
    <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />		
    <link href="../System/CSS/Grid.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Tree.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />    
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
 <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="Form1" runat="server">
			<table class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" 
                height="25" border="0">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
					    <asp:ImageButton id="btnSave" runat="server"  />
						<cc1:BWImageButton ID="btnColorAdd" runat="server"  />
						<cc1:BWImageButton id="btnRemove" runat="server"  />
                         <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
						<asp:ImageButton id="btnClose" runat="server" OnClientClick="return btnClose_Click()"  CausesValidation="false"/>
					</td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="Gray">Material Request</asp:label></td>
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
			
			<asp:panel id="pnlAlert" runat="server" Visible="False">
				<TABLE borderColor="gold" height="75" cellSpacing="0" cellPadding="0" width="900" bgColor="#ffff99"
					border="1">
					<TR>
						<TD>
							<TABLE id="TB_MainMaterial" cellSpacing="0" cellPadding="0" width="600" border="0">
								<TR>
									<TD width="10" height="50">&nbsp;</TD>
									<TD width="50" height="50" rowSpan="2"><IMG src="../System/Icons/icon_warning_32.gif"></TD>
									<TD class="fontHead">
										<asp:Label id="lblAlert" runat="server" Font-Bold="True" CssClass="fontRed"></asp:Label></TD>
									<TD class="fontHead" height="50"></TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
				</TABLE>
				<br />
			</asp:panel>						
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

            <cc2:YSTabView ID="YSTabView1" runat="server" />
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
           
            
            					
            <asp:HiddenField ID="hdnXmlFiles" runat="server" />
           
            
            					
    </form>
    <script type="text/javascript">
            function btnClose_Click() {
                <%= strExitScript %>
                return false;
            }
    </script>
</body>
</html>
