<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_MeasLink_Search.aspx.vb" Inherits="plmOnApp.Style.Measurements.Style_MeasLink_Search" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Style Search</title>
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
		<form id="Form1" method="post" runat="server" autocomplete="on" defaultbutton="imgBtnSearch" defaultfocus="Form1">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
                        <cc1:confirmedimagebutton id="imgBtnClose" runat="server" CausesValidation="False" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton>
                    </td>
				</tr>
			</table>
			<table height="15" cellspacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
					<td valign="top" width="100%">
						<table height="45">
							<tr>
								<td><asp:imagebutton id="imgBtnSearch" CausesValidation="False" runat="server" ></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<table id="Table1" cellspacing="1" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top">
					    <table class="TableHeader" height="20" cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr class="fontHead">
                                <td align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" /></td>
                                <td width="20"><asp:ImageButton ID="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:ImageButton></td>
                                <td width="20"><asp:ImageButton ID="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:ImageButton></td>
                                <td width="150" align="center"><asp:Label ID="lblCounts" CssClass="plaintable" runat="server"></asp:Label></td>
                                <td width="20"><asp:ImageButton ID="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:ImageButton></td>
                                <td width="20"><asp:ImageButton ID="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:ImageButton></td>
                                <td><asp:Label ID="lblRecordsFound" runat="server" Text="Records Found"></asp:Label></td>
                            </tr>
                        </table>
                        <asp:HiddenField ID="hdnCurrentPage" Value="0" runat="server" />
                        <asp:HiddenField ID="hdnPageSize" Value="24" runat="server" />
                        <asp:HiddenField ID="hdnRecordsCount" runat="server" />
						<asp:datalist id="DataList1" runat="server" OnItemDataBound="DataList1_ItemDataBound" EnableViewState="True"
							RepeatDirection="Horizontal" OnItemCommand="DataList1_ItemCommand" RepeatColumns="6" DataKeyField="StyleID" Width="100%">
							<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
								VerticalAlign="Top" BackColor="White"></ItemStyle>
							<ItemTemplate>
								<table borderColor="silver" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
									<tr>
										<td>
											<cc1:ConfirmedImageButton id="imgBtnEditImage" CausesValidation="False" runat="server"  Message="NONE" ToolTip='<%#GetSystemText("Select Style")%>' CommandName="Edit"></cc1:ConfirmedImageButton>
										</td>
									</tr>
									<tr>
										<td valign="top" width="200" bgColor="#ffffff" height="150"><IMG alt="" runat="server" id="imgStyle"></td>
									</tr>
                                    <tr><td><%#Eval("StyleNo")%></td></tr>
                                    <tr><td><%#Eval("Description")%></td></tr>
								</table>
                                <INPUT id="hdnStyleSet" type="hidden" value='<%# Eval("StyleSet") %>' name="hdnStyleSet" runat="server">
							</ItemTemplate>
							<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
						</asp:datalist></td>
				</tr>
			</table>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
