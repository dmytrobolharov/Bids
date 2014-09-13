<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_BOM.aspx.vb" Inherits="plmOnApp.Sourcing_BOM" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title runat="server" id="PageTitle">Sourcing</title>
	<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
    <script language="javascript" src="../System/Jscript/Custom.js"></script>
</head>
<body>
    <form id="form1" runat="server">



			<TABLE class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="middle" height="25">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					id="btnAddColor" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					id="btnRemove" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:bwimagebutton 
					id="btnGoTo" runat="server" Message="NONE" ></cc1:bwimagebutton><cc1:bwimagebutton 
					id="btnPreview" runat="server" Message="NONE" ></cc1:bwimagebutton><cc1:confirmedimagebutton 
					id="btnClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton></TD>
					
                    <td class="FontHead" vAlign="middle" align="center" width="75"><asp:label ID="lblColorWay" runat="server" >Colorway</asp:label>&nbsp;</td>
		            <td width="40"><asp:dropdownlist id="dpColoways" runat="server" AutoPostBack="true" DataValueField="ID" DataTextField="Value" CssClass="font"></asp:dropdownlist></td>					
		            <td width="40">&nbsp;</td>
				</TR>
			</TABLE>
			  			
		   <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<TR>
					<TD>&nbsp;
						<asp:label id="lbHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="Silver">Bill of Materials</asp:label></TD>
				</TR>
			</table>
			<table id="Table1" cellSpacing="1" cellpadding="1" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td><asp:placeholder id="plhHeaderControl" runat="server"></asp:placeholder></td>
				</tr>
			</table>
            <asp:Panel ID="pnlSeasonYear"  runat="server" >
                <table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
                    border="0">
                    <tr valign="middle">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
                        <td width="20"><img src="../System/Icons/icon_season.gif" /></td>
                        <td nowrap="nowrap">
                            <asp:Label runat="server" ID="lblSeasonYearLabel" class="fontHead" ></asp:Label>&nbsp;
                            <asp:Label ID="lblStyleSeasonYear" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel> 	
    		<TABLE cellSpacing="1" cellPadding="1" width="100%" bgColor="#ffffff" border="0">
				<TR>
					<td width="900">
						<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder>
			            
					</td>
				    <td valign="top">
				        <asp:datagrid id="dgBomRollup" runat="server" ShowHeader="False" 
                            CssClass="fontHead">
                            <ItemStyle Height="25px" />
                        </asp:datagrid>
				    </td>
				</tr>
			</TABLE>	
			<asp:Panel ID="pnlSourcingItemHeader"  runat ="server" >
    		<table cellSpacing="1" cellPadding="1" width="100%" bgColor="#ffffff" border="0">
				<TR>
					<td width="900">
						<asp:placeholder id="plhControlsHolderItem" runat="server"></asp:placeholder>
					</td>
				</tr>
			</table>
			</asp:Panel>			
			
			<table cellpadding="0" cellspacing="0" border="0" bgcolor="White"  >		    
		    <tr>
		        <td><cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview></td>
            </tr>
            </table>        
       <asp:datagrid id="Datagrid1" runat="server"
            AutoGenerateColumns="False" 
             BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White"  ShowHeader="false" ShowFooter="false">
			<PagerStyle />
			<AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
			<ItemStyle Height="20px" CssClass="font"></ItemStyle>
			<Columns>
			<asp:TemplateColumn>
			    <ItemTemplate>
			    <table class="TableHeader"  runat="server" id="tbComponents" cellpadding="0" cellspacing="0">
			        <tr height="25">
			            <td ><asp:Label ID="lblComponentType" runat="server" ></asp:Label>
			                <input type="hidden" runat="server" id="hdnXMLFile" />
			            </td>
			        </tr>
			        <tr>
			            <td  align="left">
                           <asp:datagrid id="dgMaterial" runat="server" 
                                    DataKeyField="StyleSourcingItemID" AutoGenerateColumns="False" 
                                     BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White"  Width="100%">
				                    <PagerStyle />
				                    <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				                    <ItemStyle Height="20px" CssClass="font"></ItemStyle>
				                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
			               </asp:datagrid>			
			            </td>
			        </tr>
			    </table>
			    </ItemTemplate>
			</asp:TemplateColumn>
			</Columns>
		</asp:datagrid>			
     


    </form>
</body>
</html>
