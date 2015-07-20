<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Image_Item_Search.aspx.vb" Inherits="plmOnApp.Style.Image.Style_Image_Item_Search" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<title>Image Folder</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
        <style type="text/css">
            #imgBtnSearch
            {
                position:relative;
            }
        </style>
		<form id="Form1" method="post" autocomplete="on" runat="server" defaultbutton="imgBtnSearch" defaultfocus="Form1">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0" runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="10" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
					    <cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="imgBtnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
                    </td>
				</tr>
			</table>
			<table id="Table4" style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td><asp:label id="lblImageHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Image Folder...</asp:label></td>
				</tr>
			</table>
			<table height="15" cellSpacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="bottom">
						<table id="Table3" height="45">
							<tr><td><asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></td></tr>
						</table>
					</td>
				</tr>
			</table>
			<table id="Table1" cellSpacing="1" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top">
						<table class="TableHeader" id="Table2" height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr class="fontHead">
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
								<td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
								<td noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
								<td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
								<td width="20"><asp:imagebutton id="btnImgLast" runat="server"></asp:imagebutton></td>
								<td noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>
								<td>&nbsp;</td>
							</tr>
						</table>
                        <asp:HiddenField ID="hdnPageSize" Value="20" runat="server" />
						<asp:datalist id="DataList1" runat="server" RepeatDirection="Horizontal" RepeatColumns="5" DataKeyField="ImageID" Width="100%">
							<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
								VerticalAlign="Top" BackColor="White"></ItemStyle>
							<ItemTemplate>
								<table borderColor="silver" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
									border="0">
									<tr>
										<td>
											<table class="TableHeader" height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
												<tr class="fontHead">
													<td>&nbsp;
														<asp:CheckBox id="cbSelectStyle" runat="server" Text='<%#string.Concat(GetSystemText("Select Image") + "...")%>' CssClass="fonthead" ToolTip='<%#string.Concat(GetSystemText("click here to select image") + "...")%>'
															OnCheckedChanged="SelectedIndexChanged" AutoPostBack="True" Checked="false"></asp:CheckBox></td>
												</tr>
											</table>
											<table class="fontHead" height="25" cellSpacing="0" cellpadding="0" width="100%" border="0">
												<tr class="fontHead">
													<td>&nbsp;&nbsp;&nbsp;&nbsp;
														<asp:CheckBox id="cbImageLinked" runat="server" Visible="False" Text='<%#string.Concat("<b>" + GetSystemText("Link Image") + "</b>" + "...")%>' CssClass="fontred"
															ToolTip='<%#string.Concat(GetSystemText("click here to link image") + "...")%>' Checked="true"></asp:CheckBox></td>
												</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td valign="top" width="200" bgColor="#ffffff" height="150">
											<asp:Image id="btnImgNewWindow" runat="server" OnClick="checkImage(this);"></asp:Image></td>
									</tr>
									<tr>
										<td>
											<table>
												<tr>
													<td class="font">
														<asp:Label id="lblImageCode" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ImageNo") %>'>
														</asp:Label></td>
												</tr>
												<tr>
													<td class="font">
														<asp:Label id="lbImgDescription" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "ImageDescription") %>'>
														</asp:Label></td>
												</tr>
											</table>
											<INPUT id=txtImageFileName type=hidden value='<%# DataBinder.Eval(Container.DataItem, "ImageLocation") %>' runat="server">
											<INPUT id=txtImageVersion type=hidden value='<%# DataBinder.Eval(Container.DataItem, "Version") %>' runat="server">
											<INPUT id=txtImageID type=hidden value='<%# DataBinder.Eval(Container.DataItem, "ImageID") %>' runat="server"></td>
									</tr>
								</table>
							</ItemTemplate>
							<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
						</asp:datalist>
                    </td>
				</tr>
			</table>
		</form>

        <script type="text/javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }

            function checkImage(parent)
            {
                $(parent).closest('table').find('*[id*="cbSelectStyle"]').click();
            }
        </script>
	</body>
</html>
