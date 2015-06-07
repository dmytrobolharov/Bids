<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_Costing_Version.aspx.vb" Inherits="plmOnApp.Sourcing_Costing_Version" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title runat="server" id="PageTitle">Sourcing</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" /> 
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
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
				<td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
			</TR>
		</TABLE>
		
		    <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<TR>
					<TD>&nbsp;
						<asp:label id="lbHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="Silver">Quote</asp:label></TD>
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
		<br />
		<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>
			
			<asp:DataList runat="server" ID="dlCosting" DataKeyField="StyleColorID" >
			<ItemTemplate>
			<table cellpadding="0" class="TableHeader" cellspacing="0"  border="0" width="100%">
			    <tr vAlign="middle" height="25">
	                <td width="20">
	                    <asp:imagebutton id="imgBtnExp" runat="server" ImageUrl="../System/Icons/icon_Next.gif"></asp:imagebutton>
	                </td>
	                <td><asp:Label ID="lblColorway" runat="server"></asp:Label></td>
			    </tr>
			    <tr runat="server" id="trNewVersion" >
			        <td width="20"></td> 
			        <td>
			            <asp:CheckBox runat="server" ID="chkNewVersion"  Checked ="false" CssClass="fontHead"/><%#GetSystemText("New Version")%>
			        </td>
			    </tr>
			    <tr>
			        <td width="20"></td> 
			        <td Width="100%">
                        <asp:datagrid id="DataGrid1" runat="server" BackColor="White"  DataKeyField="StyleQuoteItemID" Visible="false"
			                BorderColor="#E0E0E0" PageSize="100" AllowSorting="True" Width="100%">
			                <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
			                <ItemStyle CssClass="ItemTemplate"></ItemStyle>
			                <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
			                <PagerStyle Visible="False"></PagerStyle>
		                </asp:datagrid>		
        		        
		                <asp:datagrid id="DataGrid2" runat="server" BackColor="White"  DataKeyField="StyleQuoteItemVersionID" Visible="false"
			                BorderColor="#E0E0E0" PageSize="100" AllowSorting="false" Width="100%">
			                <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
			                <ItemStyle CssClass="ItemTemplate"></ItemStyle>
			                <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
			                <PagerStyle Visible="False"></PagerStyle>
			                <Columns>
			                    <asp:TemplateColumn >
			                        <ItemStyle Width="20" HorizontalAlign="Center" />
			                        <HeaderTemplate>
			                            <asp:Label ID="lblHdrVersion" runat="server" >Version</asp:Label>
			                        </HeaderTemplate>
			                        <ItemTemplate>
			                            <asp:label runat="server"  ID="lblVersion" ></asp:label>
			                        </ItemTemplate>
			                    </asp:TemplateColumn>
			                </Columns>
		                </asp:datagrid>	 
			        </td>
			    </tr>
			    </table>
			    <br />
			</ItemTemplate>
			</asp:DataList>
				
		
        <asp:PlaceHolder runat="server" id="phDataGrids" ></asp:PlaceHolder>		
        <asp:HiddenField ID="hdnXmlFile" runat="server" />
    </form>
</body>
</html>
