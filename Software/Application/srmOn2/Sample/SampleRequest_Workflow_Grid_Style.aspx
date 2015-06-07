<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls" Assembly="YSDataCalendar" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Grid_Style.aspx.vb" Inherits="srmOnApp.SampleRequest_Workflow_Grid_Style" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title runat="server" id="PageTitle">Sample Request</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
		<meta content="JavaScript" name="vs_defaultClientScript" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="XX-Large" ForeColor="#E0E0E0">Sample Request</asp:label></td>
				</tr>
			</table>
			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top"></td>
				</tr>
			</table>
			<table id="tbSearch" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0"
				runat="server">
				<tr>
					<td width="10" style="HEIGHT: 19px">&nbsp;</td>
					<td style="HEIGHT: 19px"><asp:label id="lblVendor" runat="server" CssClass="fontHead"></asp:label></td>
					<td style="HEIGHT: 19px"></td>
					<td style="HEIGHT: 19px">&nbsp;</td>
					<td style="HEIGHT: 19px"></td>
					<td style="HEIGHT: 19px"></td>
				</tr>
				<tr>
					<td width="10" height="25"></td>
					<td width="125" height="25"><asp:dropdownlist id="ddlVendor" runat="server" Width="150px"></asp:dropdownlist></td>
					<td height="25"><asp:button id="btnSearch" runat="server" CssClass="fontHead"></asp:button></td>
					<td height="25"></td>
					<td height="25"></td>
					<td height="25"></td>
				</tr>
			</table>

           	 <table id="tbXMLSearch" runat="server" height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhControlSearchHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td valign="top" width="100%">
						<table height="45">
							<tr>
								<td><asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
            <br />
			
			<asp:datagrid id="dgSampleWorkflow" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
				AutoGenerateColumns="false"  DataKeyField="SampleRequestTradeID" >
				<AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
				<Columns > 
   
                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <ItemTemplate>
                            <cc1:BWImageButton runat="server" ID="imgRedirect" ImageUrl="../System/icons/icon_search.gif" />
                         </ItemTemplate>
                    </asp:TemplateColumn>                 

				</Columns>
				
			</asp:datagrid>			
			
		</form>
	</body>
</html>
