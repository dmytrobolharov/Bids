<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Color_PaletteRemove.aspx.vb" Inherits="plmOnApp.Color_PaletteRemove" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
	<head runat="server">
		<title runat="server" id="PageTitle">Palette</title>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
        <style>
            html{overflow:hidden;}
        </style>
	</head>
	<body>
	    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server" defaultbutton = "ImgbtnSearch">

            <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
	            <tr>
		            <td align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td> 
		            <td ><cc1:confirmedimagebutton id="btnDelete" runat="server"  ></cc1:confirmedimagebutton>
		                <asp:ImageButton ID="btnClose"  runat ="server" OnClientClick="return btnClose_Click();"/>
		            </td>
	            </tr>
            </table>
            <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
	            <tr>
		            <td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		            <td class="fonthead" height="20"><asp:label id="lblHeader" runat="server" CssClass="fonthead">Color List...</asp:label></td>
	            </tr>
            </table>			
			<table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table height="45">
							<tr>
								<td>
									<asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>            
            <table cellspacing="0" cellpadding="0" width="100%" border="0">
	            <tr valign="top">
		            <td>
			            <table  class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
				            border="0">
				            <tr valign="middle">
					            <td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					            <td class="fonthead" width="10">&nbsp;</td>
					            <td width="20"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></td>
					            <td width="20"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></td>
					            <td nowrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fonthead"></asp:label></td>
					            <td width="20"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></td>
					            <td width="20"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></td>
					            <td width="10">&nbsp;</td>
					            <td noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>				
					            <td class="fonthead" align="right"><asp:label id="lblRecordsPerPage" runat="server" CssClass="fonthead" Text="Records per Page:"></asp:label></td>
					            <td width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fonthead">
							            <asp:ListItem Value="5">5</asp:ListItem>
							            <asp:ListItem Value="10">10</asp:ListItem>
							            <asp:ListItem Value="15">15</asp:ListItem>
							            <asp:ListItem Value="20">20</asp:ListItem>
							            <asp:ListItem Value="25">25</asp:ListItem>
							            <asp:ListItem Value="30">30</asp:ListItem>
							            <asp:ListItem Value="40">40</asp:ListItem>
							            <asp:ListItem Value="50" Selected="true">50</asp:ListItem>
						            </asp:dropdownlist></td>
					            <td width="10"><asp:button id="Button1" runat="server" CssClass="fontHead" text="GO"></asp:button></td>
					            <td>&nbsp;</td>
				            </tr>
			            </table>
            			
			            <table width="100%" >
			            <tr>
			                <td>
			                    <%-- cc1:ScrollingGrid ID="sgColorPaletteGrid" runat="server" Width="800" ScrollBars="Auto" Height="600" --%>
			                        <div style="width:800px;height:600px;background-color:#ffffff;overflow:auto;">
                                    <asp:datagrid id="DataGrid1" runat="server" AllowSorting="False" DataKeyField="ColorPaletteID">
                                        <Columns>
                                            <asp:TemplateColumn>
                                                <HeaderTemplate>
                                                    <asp:CheckBox ID="checkAll" runat="server" onclick="CheckAll(this);" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkDelete" />
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                        </Columns>                                        
                                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                                        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
                                        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                                        <PagerStyle Visible="False"></PagerStyle>
                                    </asp:datagrid>
                                   </div>
                                <%--/cc1:ScrollingGrid --%>
                                <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
			                    <input type="hidden" runat="server" id="hiddenCurrentPage"  value="0"/>
			                    
			                </td>
			            </tr>
			            </table>
            			
		            </td>
	            </tr>
            </table>
	
			
		</form>
		<script type="text/javascript" language="javascript">
		
		var frm = document.Form1 ;
		function CheckAll( checkAllBox )
		{
		var actVar = checkAllBox.checked ;
		for(var i=0; i < frm.length; i++)
		{
			var e=frm.elements[i];
			if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
			e.checked= actVar ;
		}
}

        function btnClose_Click() {
            <%= strExitScript %>
            return false;
        }
		</script>
	</body>
</html>
