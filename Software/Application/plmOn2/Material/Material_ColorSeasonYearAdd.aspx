<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_ColorSeasonYearAdd.aspx.vb" Inherits="plmOnApp.Material_ColorSeasonYearAdd" %>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
	<head>
		<title><%=GetSystemText(strColor)%></title>
		<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
            <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
	            <tr>
		            <td align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td> 
		            <td ><cc1:confirmedimagebutton id="btnAdd" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
		                <asp:ImageButton ID="btnClose"  runat ="server" />
		            </td>

	            </tr>
            </table>
            <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
	            <tr>
		            <td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		            <td class="fonthead" height="20"><%=strColor + " " + GetSystemText("List")%>...</td>
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
					            <td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
					            <td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
					            <td nowrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fonthead"></asp:label></td>
					            <td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
					            <td width="20"><asp:imagebutton id="btnImgLast" runat="server"></asp:imagebutton></td>
					            <td width="10">&nbsp;</td>
					            <td width="100"><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>				
					            <td class="fonthead" align="right" width="110"><asp:Label ID="lblRecordsperPage" runat="server" Visible="true" Text="Records per Page:"></asp:Label></td>
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
					            <td width="10"><asp:button id="Button1" runat="server" CssClass="fonthead" text="GO"></asp:button></td>
					            <td>&nbsp;</td>
				            </tr>
			            </table>
            			
			            <table width="100%" >
			            <tr>
			                <td>
			                    <cc1:ScrollingGrid ID="sgColorPaletteGrid" runat="server" Width="800" ScrollBars="Auto" Height="600">
                                    <asp:datagrid id="DataGrid1" runat="server"  EnableViewState="true" DataKeyField="MaterialColorID">
                                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate">
                                        </AlternatingItemStyle>
                                        <ItemStyle CssClass="ItemTemplate"></ItemStyle>
                                        <headerStyle Height="25px" CssClass="tableheader"></headerStyle>
                                        <PagerStyle Visible="False"></PagerStyle>
                                        <Columns>
                                            <asp:TemplateColumn>
                                                <HeaderTemplate>
                                                    <input type="checkbox" onclick="SelectAll(this)" id="chkSelectAll" />
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <asp:CheckBox runat="server" ID="chkSelected" />
                                                </ItemTemplate>
                                            </asp:TemplateColumn>
                                        </Columns>
                                    </asp:datagrid>
                                </cc1:ScrollingGrid>
                                <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
			                    
			                </td>
			            </tr>
			            </table>
            			
		            </td>
	            </tr>
            </table>
	
			
		</form>
		<script language="javascript" type="text/javascript"  >
		var frm = document.Form1 ;
		function SelectAll(checkAllBox) {
		    var actVar = checkAllBox.checked ;
		    for(i=0;i< frm.length;i++) {
			    e=frm.elements[i];
			    if (e.type == 'checkbox' && e.name.indexOf("chkSelected") != -1)
			        e.checked= actVar ;
		    }
		}
		</script>
	</body>
</html>
