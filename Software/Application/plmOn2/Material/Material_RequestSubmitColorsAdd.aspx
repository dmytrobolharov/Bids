<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_RequestSubmitColorsAdd.aspx.vb" Inherits="plmOnApp.Material_RequestSubmitColorsAdd" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd html 4.0 Transitional//EN">
<html>
	<head>
		<title>Available Colors</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	</head>
	<body> 
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<TR valign="middle">
					<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
					<td width="80"><cc1:confirmedimagebutton id="btnSaveColorList" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
					<td width="80"><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></td>
					<td width="75">&nbsp;</td>
					<td>&nbsp;</td>
				</TR>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblMaterialHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Select Colors...</asp:label>
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
								<td width="20"><asp:imagebutton id="btnImgLast" runat="server"></asp:imagebutton></td>
								<td width="10">&nbsp;</td>
								<td nowrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>
								<td class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsperPage" runat="server" Text="Records per Page:"></asp:Label></td>
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
				</tr>	
			</table>			
          <cc1:ScrollingGrid ID="ScrollingGrid1" runat="server" Height="700px" Width="100%">
                  <asp:datagrid id="DataGrid1" runat="server" AutoGenerateColumns="False" 
                       DataKeyField="MaterialColorSizeID" BorderStyle="Solid">
                    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate" BorderColor="#F0F0F0" BorderStyle="Solid"></AlternatingItemStyle>
                    <ItemStyle Height="20px" CssClass="ItemTemplate" BorderColor="#F0F0F0" BorderStyle="Solid"></ItemStyle>
                    <HeaderStyle Height="25px" CssClass="TableHeader" BorderColor="#F0F0F0" BorderStyle="Solid"></HeaderStyle>
                    <Columns>
                        <asp:TemplateColumn>
	                        <HeaderTemplate>
		                        <input type="checkbox" id="chkSelectChips" onclick="CheckAll(this,'chkAddChips');" runat="server" name="checkAll" />
	                        </HeaderTemplate>
	                        <ItemTemplate>
		                        <asp:CheckBox id="chkAddChips" runat="server"></asp:CheckBox>
		                        <input type ="hidden"  runat="server"  id="hdnMaterialSizeID" />
		                        <input type ="hidden"  runat="server"  id="hdnMaterialColorID" />
	                        </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                    <PagerStyle Visible="False"></PagerStyle>
                </asp:datagrid>
          </cc1:ScrollingGrid>
          <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>		

	</form>
			
		<script type="text/javascript" language="javascript">
		    var frm = document.Form1 ;
		    function CheckAll( checkAllBox, objName )
		    {
		    var actVar = checkAllBox.checked ;
		    for(i=0;i< frm.length;i++)
		    {
			    e=frm.elements[i];
			    if ( e.type=='checkbox' && e.name.indexOf( objName ) != -1 )
			    e.checked= actVar ;
		    }
		    }
    		
    		
		    function CheckAllSelected( checkAllBox )
		    {
		    var actVar = checkAllBox.checked ;
		    for(i=0;i< frm.length;i++)
		    {
			    e=frm.elements[i];
			    if ( e.type=='checkbox' && e.name.indexOf("chkSelected") != -1 )
			    e.checked= actVar ;
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
