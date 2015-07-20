<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Line_List_Folder_Style_SeasonalColorAdd.aspx.vb" Inherits="plmOnApp.Line_List_Folder_Style_SeasonalColorAdd" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head id="Head1" runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/BOMColorway.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/jquery-ui.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
    <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
    <script language="javascript" src="../system/jscript/ysbusyscript.js" type="text/javascript"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <script type="text/javascript">
        function GetRadWindow() {
            var oWindow = null; if (window.radWindow)
                oWindow = window.radWindow; else if (window.frameElement.radWindow)
                oWindow = window.frameElement.radWindow; return oWindow;
        }

        function closeWindow() {
            GetRadWindow().close();
            return false;
        }

        function refreshAndCloseWindow() {
            //GetRadWindow().BrowserWindow.parent.menu.location.href = GetRadWindow().BrowserWindow.parent.menu.location.href;
            //GetRadWindow().BrowserWindow.parent.main.location.href = GetRadWindow().BrowserWindow.parent.main.location.href;
            GetRadWindow().BrowserWindow.parent.main.__doPostBack('', 'UpdateColorways');
            GetRadWindow().close();
        }
    </script>
</head>
<body style="background-color: #ffffff;">
    <form id="Form1" method="post" runat="server">    
		<TABLE class="TableHeader" id="TableHeader" cellSpacing="0" cellPadding="0" width="100%"
			border="0" runat="server">
			<TR vAlign="middle">
				<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
				<TD>
                    <cc1:confirmedimagebutton id="btnSave" runat="server" ToolTip="Save..." Message="NONE"></cc1:confirmedimagebutton>
                    <cc1:confirmedimagebutton id="btnClose" runat="server" ToolTip="" Message="NONE" OnClientClick="return closeWindow();"></cc1:confirmedimagebutton>
                </TD>
			</TR>
		</TABLE>
		<TABLE style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
			height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			<TBODY>
				<TR>
					<TD></TD>
				</TR>
			</TBODY>
		</TABLE>
		<table cellSpacing="0" cellPadding="0" width="100%" border="0">
            <tr>
                <td>
                    <asp:datagrid id="dgColorwaySeason" runat="server" BorderStyle="NotSet" AllowSorting="false" DataKeyField="ColorPaletteID"
                         AutoGenerateColumns="false" BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" cellspacing="0">
		                <PagerStyle />
		                <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
		                <Columns>
							<asp:TemplateColumn HeaderStyle-Width="20" ItemStyle-HorizontalAlign="Center" ItemStyle-BorderWidth="1" ItemStyle-BorderColor="#CCCCCC">
								<HeaderTemplate>
									<input type="checkbox" id="checkAll" onclick="CheckAll(this);" runat="server" name="checkAll" />
								</HeaderTemplate>
								<ItemTemplate>
									<asp:CheckBox id="chkSelect" runat="server"></asp:CheckBox>
                                    <asp:HiddenField ID="hdnStyleColorID" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "StyleColorID").ToString %>' />
                                    <asp:HiddenField ID="hdnColorName" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "StyleColorName").ToString %>' />
								</ItemTemplate>
							</asp:TemplateColumn>
		                    <asp:TemplateColumn HeaderStyle-Width="30" ItemStyle-HorizontalAlign="Center" ItemStyle-BorderWidth="1" ItemStyle-BorderColor="#CCCCCC" >
								<HeaderTemplate>
									<asp:Label ID="lblColor" runat="server" Text='<%# GetUserText("Color") %>'></asp:Label>
								</HeaderTemplate>
		                        <ItemTemplate>
                                    <img id="imgColor" alt="" runat="server" style="border:gray thin solid;" />
		                            <%--<cc1:BWImageButton  ID="ImgColorwaySeason" runat="server"  /> --%>
		                        </ItemTemplate> 
		                    </asp:TemplateColumn>
		                </Columns>
		                <ItemStyle Height="20px" CssClass="font"></ItemStyle>
		                <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
	                </asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
                </td>
            </tr>
		</table>
    </form>
    <script type="text/javascript">
        var frm = document.Form1;
        function CheckAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkSelect") != -1)
                    e.checked = actVar;
            }
        }
    </script>
</body>
</html>