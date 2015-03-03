<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_WorkflowLink_Select.aspx.vb" Inherits="plmOnApp.Style_WorkflowLink_Select" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Style Search</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
         <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server" autocomplete="on" defaultbutton="imgBtnSearch">
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
						<table class="ToolbarShort" id="Table2" height="20" cellspacing="0" cellpadding="0" width="100%"
							border="0">
							<tr class="fontHead">
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td>
									<DIV align="left">&nbsp;
										<asp:label id="lblCurrentIndex" Runat="server" Visible="False" Text="0"></asp:label><asp:label id="lblPageSize" Runat="server" Visible="False" Text="24"></asp:label></DIV>
								</td>
								<td width="20">
									<DIV align="center"><asp:imagebutton id="btnImgFirst" CausesValidation="False" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></DIV>
								</td>
								<td width="20">
									<DIV align="center"><asp:imagebutton id="btnImgPrevious" CausesValidation="False" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></DIV>
								</td>
								<td width="150">
									<DIV align="center"><asp:label id="lblCounts" Runat="server" CssClass="plaintable"></asp:label></DIV>
								</td>
								<td width="20">
									<DIV align="center"><asp:imagebutton id="btnImgNext" CausesValidation="False" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></DIV>
								</td>
								<td width="20">
									<DIV align="center"><asp:imagebutton id="btnImgLast" CausesValidation="False" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></DIV>
								</td>
								<td>
									<DIV align="left"><B><asp:label id="lblRecordCount" Visible="true" Runat="server"></asp:label>&nbsp; 
											<%=GetSystemText("Records Found")%></B></DIV>
									</td>
							</tr>
						</table>
						<asp:datalist id="DataList1" runat="server" OnItemDataBound="DataList1_ItemDataBound" EnableViewState="True"
							RepeatDirection="Horizontal" OnItemCommand="DataList1_ItemCommand" RepeatColumns="6" DataKeyField="StyleID"
							Width="100%">
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
                                <INPUT id="hdnWFItemInfo" type="hidden" name="hdnWFItemInfo" runat="server">
                                <INPUT id="hdnSourceStyle" type="hidden" name="hdnSourceStyle" runat="server">
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
