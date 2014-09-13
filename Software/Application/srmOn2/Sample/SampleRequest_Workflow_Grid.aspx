<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls" Assembly="YSDataCalendar" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Grid.aspx.vb" Inherits="srmOnApp.SampleRequest_Workflow_Grid" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Sample Request</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">

        <link href="../System/CSS/jquery.tablescroll.css" type="text/css" rel="stylesheet">
        <script type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
        <script type="text/javascript" src="../System/Jscript/jquery.tablescroll.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">
			<table height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="Large" ForeColor="DarkGray">Sample Request</asp:label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td bgColor="#ffffff"></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top" bgColor="#ffffff"><cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview></td>
				</tr>
			</table>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControl" runat="server"></asp:placeholder></td>
					<td vAlign="top" width="100%">
						<table height="45">
							<tr>
								<td><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
            <table class='TableHeader' height="25" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff"
                border="0">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
					<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
					<TD noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
					<TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
					<TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></TD>
					<TD width="10">&nbsp;</TD>
					<TD noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
					<TD class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></TD>
					<TD width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
							<asp:ListItem Value="5">5</asp:ListItem>
							<asp:ListItem Value="10">10</asp:ListItem>
							<asp:ListItem Value="15">15</asp:ListItem>
							<asp:ListItem Value="20">20</asp:ListItem>
							<asp:ListItem Value="25">25</asp:ListItem>
							<asp:ListItem Value="30">30</asp:ListItem>
							<asp:ListItem Value="40">40</asp:ListItem>
							<asp:ListItem Value="50" Selected="True">50</asp:ListItem>
						</asp:dropdownlist></TD>
					<TD width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead"></asp:button></TD>
				</TR>
			</TABLE>
            <input id="hiddenCurrentPage" type="hidden" value="0" name="hiddenCurrentPage" runat="server">
            <asp:Label Visible="false" ID="lblSort" runat="server"></asp:Label>
            <asp:datagrid id="dgSampleWorkflow" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
				AutoGenerateColumns="false"  DataKeyField="SampleRequestTradeID" AllowSorting="true" AllowPaging="true">
				<AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
                <PagerStyle visible="false"/>
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
                            <asp:Label runat="server" ID="hAgent" CssClass="fontHead" ><%# GetSystemText("Agent")%></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate><asp:Label runat="server" ID="lblAgent" CssClass="font" ><%# Convert.ToString(DataBinder.Eval(Container.DataItem, "TradePartnerName"))%></asp:Label></ItemTemplate>
                    </asp:TemplateColumn>
                                        
                    <asp:TemplateColumn>
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate >
                            <asp:Label runat="server" ID="hVendor" 
                            CssClass="fontHead"  ><%#GetSystemText("Vendor")%></asp:Label>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblVendor" CssClass="font" ><%# Convert.toString (DataBinder.Eval(Container.DataItem, "VendorName"))  %></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateColumn>

                    <asp:TemplateColumn>
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate >
                            <asp:LinkButton Width="100" CommandName="Sort" CommandArgument="NPM_AgentName" runat="server" ID="hPartnerAgent" 
                            CssClass="fontHead"  ><%# GetSystemText("Agent")%></asp:LinkButton>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label Width="100" runat="server" ID="lblPartnerAgent" CssClass="font" ><%# Convert.ToString(DataBinder.Eval(Container.DataItem, "NPM_AgentName"))%></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn>
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate >
                            <asp:LinkButton Width="50" CommandName="Sort" CommandArgument="NPM_VendorName" runat="server" ID="hPartnerVendor" 
                            CssClass="fontHead"  ><%# GetSystemText("Vendor")%></asp:LinkButton>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label Width="50" runat="server" ID="lblPartnerVendor" CssClass="font" ><%# Convert.ToString(DataBinder.Eval(Container.DataItem, "NPM_VendorName"))%></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn>
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate >
                            <asp:LinkButton Width="50" CommandName="Sort" CommandArgument="NPM_FactoryName" runat="server" ID="hPartnerFactory" 
                            CssClass="fontHead"  ><%#GetSystemText("Factory")%></asp:LinkButton>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:Label Width="50" runat="server" ID="lblPartnerFactory" CssClass="font" ><%# Convert.ToString(DataBinder.Eval(Container.DataItem, "NPM_FactoryName"))%></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateColumn>


                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate>
                            <asp:LinkButton Width="50" CommandName="Sort" CommandArgument="StyleNo" runat="server" ID="hStyleNo" CssClass="fontHead" ><%#GetSystemText("StyleNo")%></asp:LinkButton>
                        </HeaderTemplate>
                        <ItemTemplate><asp:Label Width="50" runat="server" ID="lblStyleNo" CssClass="font" ><%# Convert.toString (DataBinder.Eval(Container.DataItem, "StyleNo"))  %></asp:Label></ItemTemplate>
                    </asp:TemplateColumn>

                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate>
                            <asp:LinkButton Width="70" CommandName="Sort" CommandArgument="Description" runat="server" ID="hDescription" 
                            CssClass="fontHead" ><%#GetSystemText("Description")%></asp:LinkButton>               
                        </HeaderTemplate>
                        <ItemTemplate><asp:Label Width="70" runat="server" ID="lblDescription" CssClass="font" ><%# Convert.toString (DataBinder.Eval(Container.DataItem, "Description"))  %></asp:Label></ItemTemplate>
                    </asp:TemplateColumn>

                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate>
                            <asp:LinkButton Width="60" CommandName="Sort" CommandArgument="SizeClass" runat="server" ID="hSizeClass" CssClass="fontHead"  ><%#GetSystemText("SizeClass")%></asp:LinkButton>
                        </HeaderTemplate>
                        <ItemTemplate><asp:Label Width="60" runat="server" ID="lblSizeClass" CssClass="font" ><%# Convert.toString (DataBinder.Eval(Container.DataItem, "SizeClass"))  %></asp:Label></ItemTemplate>
                    </asp:TemplateColumn>
                    
                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate><asp:LinkButton Width="50" CommandName="Sort" CommandArgument="StyleSetName" runat="server" ID="hStyleSet" CssClass="fontHead"  ><%#GetSystemText("StyleSet")%></asp:LinkButton></HeaderTemplate>
                        <ItemTemplate><asp:Label Width="50" runat="server" ID="lblStyleSet" CssClass="font" ><%# Convert.toString (DataBinder.Eval(Container.DataItem, "StyleSetName"))  %></asp:Label></ItemTemplate>
                    </asp:TemplateColumn>

                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate><asp:LinkButton Width="50" CommandName="Sort" CommandArgument="WorkFlowItemName" runat="server" ID="hWorkFlowItemName" CssClass="fontHead" ><%# GetSystemText("BOM")%></asp:LinkButton></HeaderTemplate>
                        <ItemTemplate><asp:Label Width="50" runat="server" ID="lblWorkFlowItemName" CssClass="font" /></ItemTemplate>
                    </asp:TemplateColumn>
                    
                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate>
                            <asp:LinkButton Width="50" CommandName="Sort" CommandArgument="Dim1" runat="server" ID="hDim1" CssClass="fontHead"  ></asp:LinkButton>
                         </HeaderTemplate>
                        <ItemTemplate><asp:Label Width="50" runat="server" ID="lblDim1" CssClass="font" ></asp:Label></ItemTemplate>
                    </asp:TemplateColumn>
                   
                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate>
                            <asp:LinkButton Width="50" CommandName="Sort" CommandArgument="Dim2" runat="server" ID="hDim2" CssClass="fontHead"  ><%#GetSystemText("Dim2")%></asp:LinkButton>
                         </HeaderTemplate>
                        <ItemTemplate><asp:Label Width="50" runat="server" ID="lblDim2" CssClass="font" ></asp:Label></ItemTemplate>
                    </asp:TemplateColumn>
                   
                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <HeaderTemplate>
                            <asp:LinkButton Width="50" CommandName="Sort" CommandArgument="Dim3" runat="server" ID="hDim3" CssClass="fontHead"  ><%#GetSystemText("Dim3")%></asp:LinkButton>
                         </HeaderTemplate>
                        <ItemTemplate><asp:Label Width="50" runat="server" ID="lblDim3" CssClass="font" ></asp:Label></ItemTemplate>
                    </asp:TemplateColumn>
                    

				</Columns>
				
			</asp:datagrid>			
			
			<br />

			
			
			
		</form>
        <script type="text/javascript">
        
            $.fn.tableScroll.defaults =
            {
                flush: false, // makes the last thead and tbody column flush with the scrollbar
                width: null, // width of the table (head, body and foot), null defaults to the tables natural width
                height: 100, // height of the scrollable area
                containerClass: 'tablescroll' // the plugin wraps the table in a div with this css class
            };

            jQuery(document).ready(function ($) {

                var table = $('#dgSampleWorkflow');
                // Creating <thead> element for the first row
                var head = document.createElement("thead");
                var body = table.find(">tbody");
                head.appendChild(table[0].rows[0]);
                body.before(head);
                // Adding the scrollbar
                var tableWidth = table.width();
                var tableHeight = $(window).height() - $("#Form1").height() + table.height() - $(head).height();
                table.tableScroll({ height: tableHeight });

            });
        </script>
        <style type="text/css">
            .tablescroll_wrapper {overflow-x: hidden!important;}
        </style>
	</body>
</HTML>
