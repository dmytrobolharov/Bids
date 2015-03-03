<%@ Register TagPrefix="uc1" TagName="Material_Header" Src="Material_Header.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_TradePartnerVendor_Edit.aspx.vb" Inherits="plmOnApp.Material_TradePartnerVendor_Edit" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Palette</title>
		<META http-equiv="Content-Type" content="text/html; charset=windows-1252">
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="80"><cc1:confirmedimagebutton id="btnSaveColorList" runat="server" Message="NONE" ></cc1:confirmedimagebutton></TD>
					<td width="80"><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></td>
					<td width="75">&nbsp;</td>
					<td>&nbsp;</td>
				</TR>
			</TABLE>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblMaterialHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Select Colors...</asp:label>
					</td>
				</tr>
			</table>




            <TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="top">
					<TD>
						<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
							border="0">
							<TR vAlign="middle">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
								<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
								<TD noWrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
								<TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
								<TD width="20"><asp:imagebutton id="btnImgLast" runat="server"></asp:imagebutton></TD>
								<TD width="10">&nbsp;</TD>
								<TD noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
								<TD class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsperPage" runat="server" Visible="true" Text="Records per Page:"></asp:Label></TD>
								<TD width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
										<asp:ListItem Value="5">5</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="20">20</asp:ListItem>
										<asp:ListItem Value="25">25</asp:ListItem>
										<asp:ListItem Value="30">30</asp:ListItem>
										<asp:ListItem Value="40">40</asp:ListItem>
										<asp:ListItem Value="50" Selected="True">50</asp:ListItem>
									</asp:dropdownlist></TD>
								<TD width="10"><asp:button id="Button1"  runat="server" CssClass="fontHead" text="GO"></asp:button></TD>
							</TR>
						</TABLE>
						<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
							<tr>
								<td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
								<td vAlign="top" width="100%">
									<table height="45">
										<tr>
											<td><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</TD></TR>	
					<tr><td>
					      <table  cellpadding ="0" cellspacing="0" border="0" > 
					      <tr><td>
                              <asp:datagrid id="DataGrid1" runat="server" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True"
				                PageSize="25" BorderColor="#E0E0E0" DataKeyField="MaterialColorId" BackColor="White" >
				                <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				                <ItemStyle CssClass="ItemTemplate"></ItemStyle>
				                <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				                <Columns>
					                <asp:TemplateColumn>
					                    <HeaderStyle Width="40px" />
					                    <ItemStyle Width ="40px" />
						                <HeaderTemplate>
							                <input type="checkbox" id="chkSelectChips" onclick="CheckAll(this,'chkAddChips'  );" runat="server"
								                NAME="checkAll">
						                </HeaderTemplate>
						                <ItemTemplate>
							                <asp:CheckBox id="chkAddChips" runat="server"></asp:CheckBox><input type="hidden" id="txtMaterialSizeID" runat="server"  value='<%# Container.DataItem("MaterialSizeID") %>'  />
						                </ItemTemplate>
					                </asp:TemplateColumn>
    					            
				                    <asp:TemplateColumn >
				                        <HeaderStyle Width="50px" />
				                        <ItemStyle  Width="50px" />
				                        <ItemTemplate>
				                            <asp:Label ID="lblImageButton" runat ="server" ></asp:Label>
				                         </ItemTemplate>
				                    </asp:TemplateColumn>
    					            
				                </Columns>
				                <PagerStyle Visible="False"></PagerStyle>
			                </asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>												      
					      </td>
					      </tr></table> 
							

				    </TD>
				</TR>
			</TABLE>			



			</form>
			
		<script language="javascript">
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
</HTML>
