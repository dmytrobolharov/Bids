<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_Workflow_Submit_Custom_VendorAdd.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Custom_VendorAdd" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
 <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server">
        <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"/></td> 
                <td ><cc1:confirmedimagebutton id="btnAdd" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                    <asp:ImageButton ID="btnClose"  runat ="server" OnClientClick="return btnClose_Click()"/>
                </td>

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
			                    <cc1:ScrollingGrid ID="sgScrollingGrid" runat="server" Width="800" ScrollBars="Auto" Height="600">
                                    <asp:datagrid id="DataGrid1" runat="server"  EnableViewState="true" >
                                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate">
                                        </AlternatingItemStyle>
                                        <ItemStyle CssClass="ItemTemplate" />
                                        <HeaderStyle Height="25px" CssClass="TableHeader" />
                                        <PagerStyle Visible="False"></PagerStyle>
                                        <Columns>
                                            <asp:TemplateColumn>
                                                <HeaderTemplate>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <input type="radio" id="rdbSelected" name="rdbSelected"
                                                    value='<%# Container.DataItem(strPrimaryKey).ToString() %>' />
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
            <input type="hidden" runat="server" id="hdnSQL" />
    </form>
    
    <script language="javascript" >
        function SelectAll(checkAllBox) {
        
		        var frm = document.form1;
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chkSelected") != -1)
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
