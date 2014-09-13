<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_ColorGroup_Remove.aspx.vb" Inherits="plmOnApp.Style.ColorGroup.Style_ColorGroup_Remove" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title runat="server" id="PageTitle"></title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">
		<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
			runat="server">
			<TR valign="middle">
				<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
				<td width="80"><asp:ImageButton id="btnRemove" runat="server" Message="NONE" ></asp:ImageButton></td>
				<td width="80"><asp:ImageButton id="btnClose" runat="server" Message="NONE" ></asp:ImageButton></td>
				<td width="75">&nbsp;</td>
				<td>&nbsp;</td>
			</TR>
		</table>
		<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
			height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr>
				<td>&nbsp;<asp:label id="lblMaterialHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Select Color Groups...</asp:label>
				</td>
			</tr>
		</table>

            <table cellspacing="0" cellpadding="0" width="100%" border="0">
				<TR valign="top">
					<td>
						<table class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
							border="0">
							<TR valign="middle">
								<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt=""/></td>
								<td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
								<td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
								<td nowrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
								<td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
								<td width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></td>
								<td width="10">&nbsp;</td>
								<td nowrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>
								<td class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsPerPage" runat="server">Records per Page:</asp:Label></td>
								<td width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
										<asp:ListItem Value="5">5</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="20">20</asp:ListItem>
										<asp:ListItem Value="25">25</asp:ListItem>
										<asp:ListItem Value="30">30</asp:ListItem>
										<asp:ListItem Value="40">40</asp:ListItem>
										<asp:ListItem Value="50" Selected="True">50</asp:ListItem>
									</asp:dropdownlist></td>
								<td width="10"><asp:button id="Button1"  runat="server" CssClass="fontHead" text="GO"></asp:button></td>
							</TR>
						</table>
						<table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
							<tr>
								<td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
								<td valign="top" width="100%">
									<table height="45">
										<tr>
											<td><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</TR>	
			</table>			
          <cc1:ScrollingGrid ID="ScrollingGrid1" runat="server" Height="700px" Width="100%">
                  <asp:datagrid id="DataGrid1" runat="server" AutoGenerateColumns="False" 
                       DataKeyField="ColorGroupID" BorderStyle="Solid">
                    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate" BorderColor="#F0F0F0" BorderStyle="Solid"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="ItemTemplate" BorderColor="#F0F0F0" BorderStyle="Solid"></ItemStyle>
                    <HeaderStyle Height="25px" CssClass="TableHeader" BorderColor="#F0F0F0" BorderStyle="Solid"></HeaderStyle>
                    <Columns>
                        <asp:TemplateColumn>
	                        <HeaderTemplate>
		                        <input type="checkbox" id="chkSelectChips" onclick="CheckAll(this,'chkChip');" runat="server" name="checkAll" />
	                        </HeaderTemplate>
	                        <ItemTemplate>
		                        <asp:CheckBox id="chkChip" runat="server"></asp:CheckBox>
		                        <input type ="hidden"  runat="server"  id="hdnColorGroupName" />
	                        </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                    <PagerStyle Visible="False"></PagerStyle>
                </asp:datagrid>                
          </cc1:ScrollingGrid>
          <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>		
    </form>
    <script type="text/javascript" language="javascript">
	    var frm = document.form1 ;
	    function CheckAll( checkAllBox, objName ){
	        var actVar = checkAllBox.checked ;
	        for(i=0;i< frm.length;i++) {
		        e=frm.elements[i];
		        if ( e.type=='checkbox' && e.name.indexOf( objName ) != -1 )
		            e.checked= actVar ;
	        }
	    }

	</script>    
</body>
</html>

