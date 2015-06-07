<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_Sample.aspx.vb" Inherits="plmOnApp.Sourcing_Sample" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title runat="server" id="PageTitle">Sourcing</title>
	<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">

			<TABLE class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="middle" height="25">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><cc1:confirmedimagebutton id="btnNew" runat="server"  
					Message="NONE"></cc1:confirmedimagebutton></TD>
				</TR>
			</TABLE>
		   <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<TR>
					<TD>&nbsp;
						<asp:label id="lbHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Sample</asp:label></TD>
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
						<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder><BR>
					</td>
				</TR>
			</TABLE>
			
            <asp:datagrid id="dgSampleRequest" runat="server" BorderStyle="NotSet" AllowSorting="true"
                DataKeyField="SampleRequestTradeID" AutoGenerateColumns="false" 
                 BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" 
                CellSpacing="0">
				<PagerStyle />
				<AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
			    <Columns > 
                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <ItemTemplate>
                            <cc1:BWImageButton runat="server" ID="imgRedirect" ImageUrl="../System/icons/icon_search.gif" />
                         </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
			</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>



    </form>
</body>
</html>
