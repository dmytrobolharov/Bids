<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BatchQ_Grid1.aspx.vb" Inherits="plmOnApp.BatchQ_Grid" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title>Grid</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:imagebutton id="btnInvSearch" runat="server" Width="0px" Height="0px" />
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
        <asp:placeholder id="phNav" runat="server"></asp:placeholder>       
        <telerik:RadSplitter ID="RadSplitter1" runat="server" Height="800" Width="100%">     
        <telerik:RadPane ID="LeftPane" runat="server" with="80%" Index="0" Skin="">        
        
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
	        runat="server">
	        <tr valign="middle">
		        <td valign="middle" align="center" width="10" height="27">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
		        <td >
                    <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                    <cc1:confirmedimagebutton id="btnRefresh" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                </td>
		        <td width="75">&nbsp;</td>
		        <td>&nbsp;</td>
	        </tr>
        </table>     
		


        <table cellspacing="0" cellpadding="0" width="100%" border="0">
			<tr valign="top">
				<td>
					<table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
						<tr vAlign="middle">
							<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
							<td width="16" runat="server" id="tdcbThumbnail"><asp:checkbox id="cbThumbnail" runat="server" AutoPostBack="True"></asp:checkbox></td>
								<td class="fontHead" width="100" runat="server" id="tdlblThumbnail">
                                    <asp:Label ID="lblThumbnail" runat="server" ></asp:Label></td>
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
					</table>
					<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
						<tr>
							<td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
							<td vAlign="top" width="100%">
								<table height="45">
									<tr>
										<td><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
					<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>
					<asp:datagrid id="DataGrid1" runat="server" AllowSorting="false" DataKeyField="<%#BatchQueueTablePki%>">
						<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
						<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
						<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
						<PagerStyle Visible="False"></PagerStyle>
					</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
					
					<asp:DataList runat="server" ID="DataList1" RepeatDirection="Horizontal" DataKeyField="<%#BatchQueueTablePki%>">
					    <ItemStyle VerticalAlign="Top" />
					    <ItemTemplate>
                            <table bordercolor="silver" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0" >
							    <tr valign="top">
								    <td valign="top">
									    <table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
										    <tr class="fontHead">
											    <td>&nbsp;
												    
												    
												    <asp:PlaceHolder ID="PlaceHolder2" runat="server" ></asp:PlaceHolder>
												    </td>
										    </tr>
									    </table>
								    </td>
							    </tr>
								<tr>
									<td valign="top" width="200" bgColor="#ffffff" height="150"><asp:Image id="imgListItem" runat="server"/></td>
								</tr>
                                <tr>
							        <td><asp:PlaceHolder ID="plhHeader" runat="server" ></asp:PlaceHolder></td>
								</tr>
							</table>					    
					    </ItemTemplate>
					</asp:DataList>
					<asp:label id="lblCurrentIndex" Text="0" Visible="False" Runat="server"></asp:label>
					
			    </td>
			</tr>
		</table>
		
        </telerik:RadPane>
        <telerik:RadSplitBar ID="RadSplitbar1" runat="server" CollapseMode="Both" 
            EnableResize="True" Width="20px"></telerik:RadSplitBar>
        <telerik:RadPane ID="RightPane" runat="server" Width="20%">
	            <table class="TableHeader" id="Table1" cellspacing="0" cellpadding="0" width="100%" border="0"
		            runat="server">
		            <TR valign="middle">
	                    <td valign="middle" align="center" width="10" height="25">
                        
            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
                                        
            <td width="80">
            <cc1:confirmedimagebutton id="btnDelete" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
                                        
            <td width="75">&nbsp;</td>
                                        
            <td>&nbsp;</td>
            </TR>
	            </table> 

               <asp:datagrid id="DataGrid2" runat="server" AutoGenerateColumns="False" BorderStyle="Solid" EnableViewState="False" AllowSorting="false">
                    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate" BorderColor="#F0F0F0" BorderStyle="Solid"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="ItemTemplate" BorderColor="#F0F0F0" BorderStyle="Solid"></ItemStyle>
                    <HeaderStyle Height="25px" CssClass="TableHeader" BorderColor="#F0F0F0" BorderStyle="Solid"></HeaderStyle>
                    <PagerStyle Visible="False"></PagerStyle>
                </asp:datagrid>  			            

        </telerik:RadPane>                
    </telerik:RadSplitter>				
    </div>
        <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" Runat="server">
                <StyleSheets>
                    <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
                    <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
                    <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
                    <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
                </StyleSheets>
                <CdnSettings TelerikCdn="Disabled" />
            </telerik:RadStyleSheetManager>
    <input type="hidden" runat="server" id="hdnCurrentSelection"  value="0" />
    </form>
    
    <script language='javascript'>
        var frm = document.form1;
        
        for (i = 0; i < frm.length; i++) {
            // alert("element");
            e = frm.elements[i];
            if (e.type == 'radio' && e.name.indexOf('$rdb') != -1) {
                
                e.name = 'rdb';
               
            }
        }
  </script>
  
</body>
</html>
