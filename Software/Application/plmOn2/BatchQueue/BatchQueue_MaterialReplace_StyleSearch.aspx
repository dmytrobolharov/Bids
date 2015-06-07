<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="BatchQueue_MaterialReplace_StyleSearch.aspx.vb" Inherits="plmOnApp.BatchQueue_MaterialReplace_StyleSearch" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Style Search</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>		
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					<td><asp:imagebutton id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px"></asp:imagebutton>
					<cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnSaveClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="imgBtnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
				<tr>
					<td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Style</asp:Label></td>
				</tr>
			</table>
			<cc3:YSTabView id="YSTabView1" runat="server"></cc3:YSTabView>
			<table height="15" cellSpacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table id="Table3" height="45">
							<tr>
								<td>
									<asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
            <TABLE class="TableHeader" id="Table2" height="20" cellSpacing="0" cellPadding="0" width="100%"
	            border="0">
	            <TR class="fontHead">
		            <TD align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></TD>
		            <TD height="25">
			            <DIV align="left">&nbsp;
				            <asp:label id="lblCurrentIndex" Text="0" Visible="False" Runat="server"></asp:label><asp:label id="lblPageSize" Text="10" Visible="False" Runat="server">10</asp:label></DIV>
		            </TD>
		            <TD width="20"><asp:imagebutton id="btnImgFirst" OnClick="ShowFirstPage" runat="server"></asp:imagebutton></TD>
		            <TD width="20"><asp:imagebutton id="btnImgPrevious" OnClick="ShowPreviousPage" runat="server"></asp:imagebutton></TD>					
		            <TD noWrap align="center" width="125"><asp:label id="lblCounts" runat="server" CssClass="fontHead"></asp:label></TD>
		            <TD width="20"><asp:imagebutton id="btnImgNext" OnClick="ShowNextPage" runat="server"></asp:imagebutton></TD>
		            <TD width="20"><asp:imagebutton id="btnImgLast" OnClick="ShowLastPage" runat="server" ToolTip="Last"></asp:imagebutton></TD>
		            <TD width="10">&nbsp;</TD>
		            <TD noWrap height="25"><div align="left"><b>
                           <asp:label id="lblRecordCount" Visible="true" Runat="server"></asp:label>&nbsp;
                           <asp:label id="lblRecordFound" Runat="server" />
                         </b></div>
                    </TD>	
		            <TD height="25">
			            <P align="right"><asp:dropdownlist id="ddlSortField" runat="server"></asp:dropdownlist>
				            <asp:dropdownlist id="ddlSortBy" runat="server">
					            <asp:ListItem Value="ASC">ASC</asp:ListItem>
					            <asp:ListItem Value="DESC">DESC</asp:ListItem>
				            </asp:dropdownlist>
				            <asp:ImageButton id="btnSort" runat="server" ImageUrl="../System/Icons/icon_sort.gif"></asp:ImageButton></P>
		            </TD>
	            </TR>
            </TABLE>
            <TABLE borderColor="gainsboro" cellSpacing="1" cellPadding="0" border="0">
	            <TR>
		            <TD vAlign="top"><asp:datalist id="Datalist1" runat="server" DataKeyField="styleId" RepeatLayout="Table" RepeatColumns="1"
				            RepeatDirection="Horizontal" EnableViewState="false">
				            <ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="Gainsboro" VerticalAlign="Top" BackColor="White"></ItemStyle>
				            <ItemTemplate>
					            <table borderColor="silver" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
						            border="0">
						            <tr>
							            <td>
								            <asp:CheckBox id="cbSelectStyle" runat="server" Text='<%#GetSystemText("Click here to select style") & "..."%>' CssClass="font"></asp:CheckBox>
							            </td>
						            </tr>
					            </table> 
					            
                                <asp:TextBox ID="txtSeasonyearID" runat="server" visible="false" ></asp:TextBox>	
				            </ItemTemplate>
				            <HeaderStyle HorizontalAlign="Left" ></HeaderStyle>
			            </asp:datalist></TD>
	            </TR>
            </TABLE>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
