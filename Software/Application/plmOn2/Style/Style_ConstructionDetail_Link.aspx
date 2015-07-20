<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_ConstructionDetail_Link.aspx.vb" Inherits="plmOnApp.Style.ConstructionDetail.Style_ConstructionDetail_Link" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<html>
	<head>
		<title id="tlLinkFeature" runat="server">Link Feature</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td>
					<td><asp:imagebutton id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px"
							Height="0px"></asp:imagebutton>
						<cc1:confirmedimagebutton id="btnLink" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
					</td>
				</tr>
			</table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
				<tr>
					<td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:Label></td>
				</tr>
			</table>
            <table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
                <tr valign="middle">
		            <td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		            <TD width="16"><asp:checkbox id="cbThumbnail" AutoPostBack="True" runat="server"></asp:checkbox></TD>
					<TD class="fontHead" width="100"><asp:label id="lblThumbnail" runat="server" CssClass="fontHead">Thumbnail</asp:label>?</TD>
		            <td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
		            <td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
		            <td nowrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
		            <td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
		            <td width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></td>
		            <td width="10">&nbsp;</td>
		            <td nowrap><asp:label id="RecordCount" runat="server" CssClass="fontHead"></asp:label></td>
		            <td class="fontHead" align="right" width="110">
                    <asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></td>
		            <td width="25">
		                <asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
				            <asp:ListItem Value="5">5</asp:ListItem>
				            <asp:ListItem Value="10">10</asp:ListItem>
				            <asp:ListItem Value="15">15</asp:ListItem>
				            <asp:ListItem Value="20">20</asp:ListItem>
				            <asp:ListItem Value="25">25</asp:ListItem>
				            <asp:ListItem Value="30">30</asp:ListItem>
				            <asp:ListItem Value="40">40</asp:ListItem>
				            <asp:ListItem Value="50" Selected="True">50</asp:ListItem>
			            </asp:dropdownlist>
		            </td>
		            <td width="10"><asp:button id="btnGo" onclick="RePage" runat="server" CssClass="fontHead" ></asp:button></td>
	            </tr>
            </table>
            
            <table height="15" cellSpacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControl" runat="server"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table id="Table3" height="45">
							<tr>
								<td>
									<asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton>
                                </td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
            
	        <asp:datagrid id="DataGrid1" runat="server" AllowSorting="False" DataKeyField="Level3ID" AllowPaging="false">
		        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
		        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
		        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
		        <PagerStyle Visible="False"></PagerStyle>
                <Columns>
                    <asp:TemplateColumn>
                        <HeaderTemplate>
                                <input type="checkbox" id="checkAll" onclick="CheckAll(this);" runat="server" name="checkAll" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="chbLevel3ID" runat="server"></asp:CheckBox>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                    <asp:TemplateColumn>
                        <HeaderTemplate>
                            <%# GetSystemText("Image")%>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <cc1:BWImageButton ID="imgConstruction" runat="server" title="Click here to zoom it" ImageUrl='<%# GetImageStreamPath("CD", 50, Eval("ImageVersion").ToString, Eval("ImageID").ToString) %>'/>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
	        </asp:datagrid>   
            <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
		</form>

		<script type="text/javascript" language="javascript">
		    var frm = document.Form1;
		    function CheckAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chbLevel3ID") != -1)
		                e.checked = actVar;
		        }
		    }
		    function calendar(sTxtBoxName) {
		        windowDatePicker = window.open("../System/Control/month_popup.aspx?txtbox=" + sTxtBoxName, "dp", "toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=200,height=180,left=375,top=200");
		        windowDatePicker.focus();
		    }
		</script>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
