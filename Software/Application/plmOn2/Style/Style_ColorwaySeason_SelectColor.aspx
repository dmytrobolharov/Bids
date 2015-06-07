<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_ColorwaySeason_SelectColor.aspx.vb" Inherits="plmOnApp.Style.ColorwaySeasonal.Style_ColorwaySeason_SelectColor" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
    <head id="Head1" runat="server">
		<title><%= Me.strColorway %></title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script language="javascript" src='../System/Jscript/YSCalendarFunctions.js'></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
            <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
	            height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
	            <tr>
		            <td width="25" height="50">&nbsp;</td>
		            <td>
                        <table cellspacing="0" cellpadding="0" width="100%" border="0">
	                        <tr>
		                        <td width="25" height="50">&nbsp;<img src="../System/icons/icon_colorway.gif" /></td>
		                        <td><span class="fontHead">&nbsp;
                                    <asp:Label ID="lblHeader" runat="server"></asp:Label>
                                    </span></td>
	                        </tr>
                        </table>
		            </td>
	            </tr>
            </table>
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="top">
					<td>
						<table height="15" cellspacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
							<tr>
								<td><br /><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
								<td valign="top" width="100%">
									<table>
										<tr>
											<td><br /><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
                        <cc1:ScrollingGrid ID="ScrollingGrid1" runat="server" Height="425px" 
                            Width="100%">
                            <asp:datagrid id="DataGrid1" runat="server" DataKeyField="ColorPaletteID" 
                            AllowSorting="True">
                                <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate">
                                </AlternatingItemStyle>
                                <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                                <HeaderStyle Height="25px" CssClass="tableHeader"></HeaderStyle>
                                <PagerStyle Visible="False"></PagerStyle>
                                <Columns>
                                    <asp:TemplateColumn>
                                        <HeaderTemplate><input type="checkbox" id="chkHdrSelect"  onclick="CheckAll(this);"/></HeaderTemplate>
                                        <ItemTemplate>
                                            <asp:CheckBox runat="server" ID="chbColorPaletteID" />
                                        </ItemTemplate>
                                    </asp:TemplateColumn>
                                </Columns>
                            </asp:datagrid>
                        </cc1:ScrollingGrid>
                        
						<asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
					    <table bgcolor="Gainsboro" border="0" cellpadding="0" cellspacing="0" 
                            height="40" 
                            style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: Gainsboro" 
                            width="100%">
                            <tr>
                                <td align="center" width="50">
                                    &nbsp;</td>
                                <td align="center" width="500">
                                    <asp:ImageButton ID="btnSave" runat="server" 
                                        />
                                    <asp:ImageButton ID="btnClose" runat="server" OnClientClick="return btnClose_Click()"
                                         />
                                </td>
                                <td align="center">
                                    &nbsp;</td>
                            </tr>
                        </table>
					</td>
				</tr>
			</table>
		</form>
		
        <script language="javascript">
            var frm = document.Form1;
            function CheckAll(checkAllBox) {
                var actVar = checkAllBox.checked;
                for (i = 0; i < frm.length; i++) {
                    e = frm.elements[i];
                    if (e.type == 'checkbox' && e.name.indexOf("chbColorPaletteID") != -1)
                        e.checked = actVar;
                }
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

