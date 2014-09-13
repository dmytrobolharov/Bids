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
                    
                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate>
                            <table border="0" cellpadding="0" cellspacing="0" width="100"><tr><td><asp:Label runat="server" ID="hAgent" 
                            CssClass="fontHead" ><%#GetSystemText("Agent")%></asp:Label></td></tr></table>
                        </HeaderTemplate>
                        <ItemTemplate><asp:Label runat="server" ID="lblAgent" CssClass="font" ><%# Convert.toString (DataBinder.Eval(Container.DataItem, "TradePartnerName"))  %></asp:Label></ItemTemplate>
                    </asp:TemplateColumn>

                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate >
                            <table border="0" cellpadding="0" cellspacing="0" width="50"><tr><td><asp:Label runat="server" ID="hVendor" 
                            CssClass="fontHead"  ><%#GetSystemText("Vendor")%></asp:Label></td></tr></table>
                        </HeaderTemplate>
                        <ItemTemplate><asp:Label runat="server" ID="lblVendor" CssClass="font" ><%# Convert.toString (DataBinder.Eval(Container.DataItem, "VendorName"))  %></asp:Label></ItemTemplate>
                    </asp:TemplateColumn>

                    <asp:TemplateColumn>
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate >
                            <table border="0" cellpadding="0" cellspacing="0" width="50"><tr><td><asp:Label runat="server" ID="hPartnerAgent" 
                            CssClass="fontHead"  ><%# GetSystemText("Agent")%></asp:Label></td></tr></table>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblPartnerAgent" CssClass="font" ><%# Convert.ToString(DataBinder.Eval(Container.DataItem, "NPM_AgentName"))%></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn>
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate >
                            <table border="0" cellpadding="0" cellspacing="0" width="50"><tr><td><asp:Label runat="server" ID="hPartnerVendor" 
                            CssClass="fontHead"  ><%# GetSystemText("Vendor")%></asp:Label></td></tr></table>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblPartnerVendor" CssClass="font" ><%# Convert.ToString(DataBinder.Eval(Container.DataItem, "NPM_VendorName"))%></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn>
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate >
                            <table border="0" cellpadding="0" cellspacing="0" width="50"><tr><td><asp:Label runat="server" ID="hPartnerFactory" 
                            CssClass="fontHead"  ><%#GetSystemText("Factory")%></asp:Label></td></tr></table>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblPartnerFactory" CssClass="font" ><%# Convert.ToString(DataBinder.Eval(Container.DataItem, "NPM_FactoryName"))%></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    
                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate>
                            <table border="0" cellpadding="0" cellspacing="0" width="50"><tr><td><asp:Label runat="server" ID="hStyleNo" CssClass="fontHead" ><%#GetSystemText("StyleNo")%></asp:Label></td></tr></table>
                        </HeaderTemplate>
                        <ItemTemplate><asp:Label runat="server" ID="lblStyleNo" CssClass="font" ><%# Convert.toString (DataBinder.Eval(Container.DataItem, "StyleNo"))  %></asp:Label></ItemTemplate>
                    </asp:TemplateColumn>

                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate>
                            <table border="0" cellpadding="0" cellspacing="0" width="100"><tr><td><asp:Label runat="server" ID="hDescription" 
                            CssClass="fontHead" ><%#GetSystemText("Description")%></asp:Label></td></tr></table>                        
                        </HeaderTemplate>
                        <ItemTemplate><asp:Label runat="server" ID="lblDescription" CssClass="font" ><%# Convert.toString (DataBinder.Eval(Container.DataItem, "Description"))  %></asp:Label></ItemTemplate>
                    </asp:TemplateColumn>

                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate>
                            <table border="0" cellpadding="0" cellspacing="0" width="50"><tr><td><asp:Label runat="server" ID="hSizeClass" CssClass="fontHead"  ><%#GetSystemText("SizeClass")%></asp:Label></td></tr></table>
                        </HeaderTemplate>
                        <ItemTemplate><asp:Label runat="server" ID="lblSizeClass" CssClass="font" ><%# Convert.toString (DataBinder.Eval(Container.DataItem, "SizeClass"))  %></asp:Label></ItemTemplate>
                    </asp:TemplateColumn>
                    
                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate><asp:Label runat="server" ID="hStyleSet" CssClass="fontHead"  ><%#GetSystemText("StyleSet")%></asp:Label></HeaderTemplate>
                        <ItemTemplate><asp:Label runat="server" ID="lblStyleSet" CssClass="font" ><%# Convert.toString (DataBinder.Eval(Container.DataItem, "StyleSetName"))  %></asp:Label></ItemTemplate>
                    </asp:TemplateColumn>
                    
                    <%--<asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate>
                            <table border="0" cellpadding="0" cellspacing="0" width="80"><tr><td><asp:Label runat="server" ID="hColor" CssClass="fontHead"  ><%#GetSystemText("Color")%></asp:Label></td></tr></table>
                         </HeaderTemplate>
                        <ItemTemplate><asp:Label runat="server" ID="lblColor" CssClass="font" ><%# Convert.toString (DataBinder.Eval(Container.DataItem, "Color"))  %></asp:Label></ItemTemplate>
                    </asp:TemplateColumn> --%>
                    
                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate>
                            <table border="0" cellpadding="0" cellspacing="0" width="80"><tr><td><asp:Label runat="server" ID="hDim1" CssClass="fontHead"  ></asp:Label></td></tr></table>
                         </HeaderTemplate>
                        <ItemTemplate><asp:Label runat="server" ID="lblDim1" CssClass="font" ></asp:Label></ItemTemplate>
                    </asp:TemplateColumn>
                   
                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate>
                            <table border="0" cellpadding="0" cellspacing="0" width="80"><tr><td><asp:Label runat="server" ID="hDim2" CssClass="fontHead"  ><%#GetSystemText("Dim2")%></asp:Label></td></tr></table>
                         </HeaderTemplate>
                        <ItemTemplate><asp:Label runat="server" ID="lblDim2" CssClass="font" ></asp:Label></ItemTemplate>
                    </asp:TemplateColumn>
                   
                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate>
                            <table border="0" cellpadding="0" cellspacing="0" width="80"><tr><td><asp:Label runat="server" ID="hDim3" CssClass="fontHead"  ><%#GetSystemText("Dim3")%></asp:Label></td></tr></table>
                         </HeaderTemplate>
                        <ItemTemplate><asp:Label runat="server" ID="lblDim3" CssClass="font" ></asp:Label></ItemTemplate>
                    </asp:TemplateColumn>
                    
                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate><asp:Label runat="server" ID="hTechPack" CssClass="fontHead" ><%#GetSystemText("TechPack")%></asp:Label></HeaderTemplate>
                        <ItemTemplate><asp:Label runat="server" ID="lblTechpack" CssClass="font" ></asp:Label></ItemTemplate>
                    </asp:TemplateColumn>
                    

				</Columns>
				
			</asp:datagrid>			
			
		</form>
	</body>
</html>
