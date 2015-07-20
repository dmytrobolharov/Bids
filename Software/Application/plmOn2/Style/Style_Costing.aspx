<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Costing.aspx.vb" Inherits="plmOnApp.Style.Costing.Style_Costing" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Costing_Material" Src="Style_Costing_Material.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="ycl" Namespace="Yunique.Core.Library" Assembly="Yunique.Core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Costing</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
						<cc1:confirmedimagebutton id="btnEdit" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnNewTask" Visible="false" runat="server"  Message="NONE" OnClientClick="btnNewTask_Click()"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnNewIssue" runat="server" Message="NONE" 
							CausesValidation="False"></cc1:confirmedimagebutton>
						<cc1:BWImageButton id="btnPrint" runat="server" ></cc1:BWImageButton>
                         <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
					</td>
				</tr>
			</table>
			<table class="TableHeader" id="Table2" height="25" cellspacing="0" cellpadding="0" width="100%"
				border="0" runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="20"><IMG src="../System/Icons/icon_costing.gif"></td>
					<td>&nbsp;<%=GetSystemText("Costing")%></td>
				</tr>
			</table>
			<table id="tbCosting" borderColor="crimson" cellspacing="0" cellpadding="0" width="100%"
				bgColor="mistyrose" border="1" runat="server">
				<tr>
					<td>
						<table id="Table4" height="35" cellspacing="0" cellpadding="0" width="800" border="0">
							<tr>
								<td width="10">&nbsp;</td>
								<td class="fontHead" width="35">&nbsp;
									<asp:image id="imgBlock" runat="server" ImageUrl="../System/Icons/icon_block.gif"></asp:image></td>
								<td class="fontHead">&nbsp;
									<asp:label id="lblHeader" runat="server" CssClass="fontHead" ForeColor="Black">Costing Not Found...</asp:label></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="900"><uc1:style_header id="Style_Header1" runat="server"></uc1:style_header></td>
					<td></td>
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
                        <td width="125" align="right" nowrap="nowrap">
                            <asp:Label runat="server" ID="Label1" class="fontHead" >Select Season / Year:</asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList  ID="ddlStyleSeasonYearID" runat="server" AutoPostBack="true" ></asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </asp:Panel> 					
			<table cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td valign="top" width="1"><asp:placeholder id="plhCostControls" runat="server"></asp:placeholder></td>
					<td valign="top"><asp:datalist id="dlCosting" runat="server" BorderColor="Silver" BorderWidth="0px" EnableViewState="True"
							RepeatDirection="Horizontal" RepeatColumns="6" Width="200" BackColor="#ffffff">
							<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
								VerticalAlign="Top"></ItemStyle>
							<ItemTemplate>
								<table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="200" border="0">
									<tr valign="middle">
										<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
										<td>
											<asp:Label id=lblCostingType runat="server" Text='<%# GetSystemText(DataBinder.Eval(Container.DataItem, "StyleCostingType")) %>'>
											</asp:Label></td>
									</tr>
								</table>
								<table cellspacing="0" cellpadding="0" width="100%" border="0">
									<tr>
										<td valign="top" width="900" bgColor="#ffffff">
											<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
										<td></td>
									</tr>
								</table>
								<INPUT id="txtStyleCostingId" type="hidden" runat="server" value='<%# DataBinder.Eval(Container.DataItem, "StyleCostingId").ToString %>'><INPUT id="txtStyleCostingTypeId" type="hidden" runat="server" value='<%# DataBinder.Eval(Container.DataItem, "StyleCostingTypeId") %>'>
								<asp:Panel id="pnlContainer" runat="server">
									<table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
										<tr class="TableHeader">
											<td style="HEIGHT: 24px" valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
											<td class="fontHead" style="HEIGHT: 24px">
												<asp:label id="lbQuoteSpecial" runat="server"><%#GetSystemText("Container")%>...</asp:label>&nbsp;</td>
										</tr>
									</table>
									<table height="25" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffff99" border="0">
										<tr>
											<td>
												<asp:placeholder id="plhContainer" runat="server"></asp:placeholder></td>
										</tr>
									</table>
								</asp:Panel>
								<table height="24" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
									<tr valign="middle">
										<td class="TableBar" valign="middle" align="center" width="1"></td>
										<td class="TableBar">
											<asp:Label id="lblCreateddBy" runat="server" CssClass="font"><B>C: </B><%# DataBinder.Eval(Container.DataItem, "CUser").ToString %>&nbsp;<%#Convert.ToDateTime(SystemHandler.GetLocalTime(DataBinder.Eval(Container.DataItem, "CDate"))).ToString(Me.GetFormatInfo.DateTimeLongFormat)%></asp:Label></td>
									</tr>
								</table>
								<table height="24" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server"
									ID="Table3">
									<tr valign="middle">
										<td class="TableBar" valign="middle" align="center" width="1"></td>
										<td class="TableBar">
											<asp:Label id="lblModifiedBy" runat="server" CssClass="font"><B>M: </B><%# DataBinder.Eval(Container.DataItem, "MUser").ToString %>&nbsp;<%#Convert.ToDateTime(SystemHandler.GetLocalTime(DataBinder.Eval(Container.DataItem, "MDate"))).ToString(Me.GetFormatInfo.DateTimeLongFormat)%></asp:Label></td>
									</tr>
								</table>
							</ItemTemplate>
						</asp:datalist>
					</td>
				</tr>
			</table>
			<table class="TableHeader" id="Table1" visible="false" height="25" cellspacing="0" cellpadding="0" width="100%"
				border="0" runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>&nbsp;<%=GetSystemText("Main Material")%></td>
				</tr>
			</table>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top" width="900" bgColor="#ffffff"><uc1:style_costing_material id="Style_Costing_Material1" Visible="false" runat="server"></uc1:style_costing_material></td>
					<td></td>
				</tr>
			</table>
		</form>
        <script language="javascript">
	        function btnNewTask_Click() {
		        <%= strOpenScript %>
                return false;
            }
        </script>
	</body>
</html>
