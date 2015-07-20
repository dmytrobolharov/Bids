<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_Copy.aspx.vb" Inherits="plmOnApp.Material_Copy" %>
<%@ Register TagPrefix="uc1" TagName="Material_Header" Src="Material_Header.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Palette</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="80"><cc1:confirmedimagebutton id="btnSaveMaterial" runat="server"  Message="NONE"></cc1:confirmedimagebutton></TD>
					<td width="80"><cc1:confirmedimagebutton id="imgbtnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
					<td width="75">&nbsp;</td>
					<td>&nbsp;</td>
				</TR>
			</TABLE>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			
			
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblMaterialHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr bgColor="#ffffff">
					<td vAlign="top" width="50%">
						<table class="TableHeader" height="32" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3">
								</td>
								<td class="fontHead" width="75">
                                    <asp:Label ID="lblColorHeader" runat="server" ><%=GetSystemText(String.Concat(GetColorHeader() & "s"))%>...</asp:Label>  
								</td>
								<td class="fontHead">&nbsp;</td>
							</tr>
						</table>
						<asp:datagrid id="DataGrid1" runat="server" OnItemDataBound="DataGrid1_OnItemDataBound" DataKeyField="MaterialColorID"
							OnItemCommand="DataGrid1_ItemCommand" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
							PageSize="1000" AutoGenerateColumns="False">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<input type="checkbox" id="DataGrid1_checkAll" onclick="DataGrid1_CheckAll(this);" runat="server"
											NAME="checkAll">
									</HeaderTemplate>
									<ItemTemplate>
										<asp:CheckBox id="DataGrid1_chkSelected" runat="server"></asp:CheckBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<asp:Label ID="lblColorHeaderTemplate" runat="server" ><%= GetSystemText(GetColorHeader) %></asp:Label> 
									</HeaderTemplate>
									<ItemTemplate>
										<table>
											<tr>
												<td height="16" width="16">
													<asp:Image Runat="server" ID="imgChip"></asp:Image>
												</td>
											</tr>
										</table>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<asp:Label ID="lblColorVendorHeader" runat="server" ><%=GetSystemText(String.Concat("Vendor " & GetColorHeader()))%></asp:Label> 
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtVendorColorName" runat="server" Width="100px" BorderColor="#E0E0E0" BorderStyle="Solid"
											BorderWidth="1px" Columns="30" MaxLength="50"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<asp:Label ID="lblColorNoHeader" runat="server" ><%=GetSystemText(String.Concat(GetColorHeader() & " No"))%></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtColorCode" runat="Server" Width="100px" BorderWidth="1px" BorderStyle="Solid"
											BorderColor="#E0E0E0" columns="15" maxlength="50"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<asp:Label ID="lblColorNameHeader" runat="server" ><%=GetSystemText(String.Concat(GetColorHeader() & " Name"))%></asp:Label> 
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtColorName" runat="server" Width="100px" BorderWidth="1px" BorderStyle="Solid"
											BorderColor="#E0E0E0" MaxLength="100" Columns="30"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<DIV align="center">
											<asp:Label id="lblSort" runat="server"><%=GetSystemText("Order")%></asp:Label></DIV>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtSort" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
											maxlength="5" columns="5"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
					<td vAlign="top" width="50%">
						<table class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead" width="100"></td>
								<td height="30"></td>
							</tr>
						</table>
						<asp:datagrid id="Datagrid2" runat="server" OnItemDataBound="DataGrid2_ItemEventHandler" DataKeyField="MaterialSizeID"
							OnItemCommand="DataGrid2_ItemCommand" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
							PageSize="1000" AutoGenerateColumns="False" Width="250">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<FooterStyle></FooterStyle>
							<Columns>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<input type="checkbox" id="DataGrid2_checkAll" onclick="DataGrid2_CheckAll(this);" runat="server"
											NAME="checkAll">
									</HeaderTemplate>
									<ItemTemplate>
										<asp:CheckBox id="DataGrid2_chkSelected" runat="server"></asp:CheckBox>
										<asp:TextBox id="txtMaterialSizeVersion" runat="server" Visible="false" />
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<asp:Label id="lblMaterialSize" runat="server"></asp:Label>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtMaterialSize" runat="server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
											MaxLength="100" Columns="30"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<DIV align="center">
											<asp:Label id="lblMaterialPrice" runat="server"></asp:Label></DIV>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtMaterialPrice" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
											maxlength="5" columns="5"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>
										<DIV align="center">
											<asp:Label id="Label1" runat="server"><%=GetSystemText("Sort")%></asp:Label></DIV>
									</HeaderTemplate>
									<ItemTemplate>
										<asp:TextBox id="txtMaterialSizeSort" runat="Server" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
											maxlength="5" columns="5"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
				</tr>
			</table>
			
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr bgColor="#ffffff">
					<td vAlign="top" Width="33%">
						<table class="TableHeader" height="32" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead" width="200"><asp:Label ID="Label2" runat="server" Text="Season & Year..."></asp:Label></td>
								<td class="fontHead">&nbsp;</td>
							</tr>
						</table>
				    </td>
				    <td Width=33%">
				        <table class="TableHeader" height="32" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead" width="200"><asp:Label ID="Label3" runat="server" Text="Attachments..."></asp:Label></td>
								<td class="fontHead">&nbsp;</td>
							</tr>
						</table>
				    </td>
                    <td Width="33%">
				        <table class="TableHeader" height="32" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead" width="200"><asp:Label ID="Label4" runat="server" Text="3D Files..."></asp:Label></td>
								<td class="fontHead">&nbsp;</td>
							</tr>
						</table>
				    </td>
				</tr>
				<tr bgColor="#ffffff">
				    <td>
				    
						<asp:datagrid id="dgSeasonYear" runat="server" AllowSorting="True" DataKeyField="SeasonYearID">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>				    
							<Columns>
							    <asp:TemplateColumn>
							        <ItemTemplate>
							            <asp:CheckBox  runat="server" ID="chkSelect" />
							        </ItemTemplate>
							    </asp:TemplateColumn>
							</Columns>
						</asp:datagrid>
				    
				    </td>
				    <td valign="top" >
				        <asp:datagrid id="Datagrid3" runat="server" Width="300" AllowSorting="True" AutoGenerateColumns="false"  DataKeyField="MaterialDocumentID">
							<AlternatingItemStyle Height="20px" CssClass="Font"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="Font"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>				    
							<Columns>
							   	<asp:TemplateColumn>							   	
									<HeaderTemplate>
										<input type="checkbox" id="DataGrid3_checkAll" onclick="DataGrid3_CheckAll(this);" runat="server" NAME="checkAll">
									</HeaderTemplate>
									<ItemTemplate>
										<asp:CheckBox id="DataGrid3_chkSelected" runat="server"></asp:CheckBox>
									</ItemTemplate>
								</asp:TemplateColumn>								
								<asp:TemplateColumn>
								    <HeaderTemplate>
										<asp:Label ID="lblMatDocumentNameHead" runat="server" ><%=GetSystemText("File Name")%></asp:Label> 										
									</HeaderTemplate>								    
							        <ItemTemplate>
									    <asp:Label ID="lblMatDocumentName" runat="server" ><%#Container.DataItem("MaterialDocumentName")%></asp:Label> 										
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
								    <HeaderTemplate>
										<asp:Label ID="lblMatDocumentFileDescHead" runat="server" ><%=GetSystemText("File Description")%></asp:Label> 										
									</HeaderTemplate>	
									<ItemTemplate>
										<asp:Label ID="lblMatDocumentDesc" runat="server" ><%#Container.DataItem("MaterialDocumentDescription").Replace(vbCrLf, "<BR>").toString%></asp:Label>										
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>	
								    <HeaderTemplate>
										<asp:Label ID="lblMatDocumentFileSizeHead" runat="server" ><%=GetSystemText("File Size")%></asp:Label> 										
									</HeaderTemplate>	
									<ItemTemplate>
									    <asp:Label ID="lblMatDocumentSize" runat="server" ><%#Container.DataItem("MaterialDocumentSize")%></asp:Label>																				
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid>
				    </td>

                    <td valign="top" >
				        <asp:datagrid id="Datagrid4" runat="server" Width="300" AllowSorting="True" AutoGenerateColumns="false"  DataKeyField="MaterialDocumentID">
							<AlternatingItemStyle Height="20px" CssClass="Font"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="Font"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>				    
							<Columns>
							   	<asp:TemplateColumn>							   	
									<HeaderTemplate>
										<input type="checkbox" id="DataGrid4_checkAll" onclick="DataGrid4_CheckAll(this);" runat="server" NAME="checkAll">
									</HeaderTemplate>
									<ItemTemplate>
										<asp:CheckBox id="DataGrid4_chkSelected" runat="server"></asp:CheckBox>
									</ItemTemplate>
								</asp:TemplateColumn>								
								<asp:TemplateColumn>
								    <HeaderTemplate>
										<asp:Label ID="lblMatDocumentNameHead" runat="server" ><%=GetSystemText("File Name")%></asp:Label> 										
									</HeaderTemplate>								    
							        <ItemTemplate>
									    <asp:Label ID="lblMatDocumentName" runat="server" ><%#Container.DataItem("MaterialDocumentName")%></asp:Label> 										
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
								    <HeaderTemplate>
										<asp:Label ID="lblMatDocumentFileDescHead" runat="server" ><%=GetSystemText("File Description")%></asp:Label> 										
									</HeaderTemplate>	
									<ItemTemplate>
										<asp:Label ID="lblMatDocumentDesc" runat="server" ><%#Container.DataItem("MaterialDocumentDescription").Replace(vbCrLf, "<BR>").toString%></asp:Label>										
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>	
								    <HeaderTemplate>
										<asp:Label ID="lblMatDocumentFileSizeHead" runat="server" ><%=GetSystemText("File Size")%></asp:Label> 										
									</HeaderTemplate>	
									<ItemTemplate>
									    <asp:Label ID="lblMatDocumentSize" runat="server" ><%#Container.DataItem("MaterialDocumentSize")%></asp:Label>																				
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid>
				    </td>
				</tr>			
			</table>
						
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr bgColor="#ffffff">
					<td vAlign="top" width="50%">
						<table class="TableHeader" height="32" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead" width="200"><asp:Label ID="lblImage" runat="server" Text="Image..."></asp:Label></td>
								<td class="fontHead">&nbsp;</td>
							</tr>
						</table>
						<table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td width="50">&nbsp;</td>
								<td width="20"><asp:radiobutton id="LinkImage" runat="server" GroupName="ImageChoice" Checked="True"></asp:radiobutton></td>
								<td class="fontHead" width="100">&nbsp;<asp:Label ID="lblLinkImage" runat="server" Text="Link Image"></asp:Label></td>
								<td width="20"><asp:radiobutton id="CopyImage" runat="server" GroupName="ImageChoice"></asp:radiobutton></td>
								<td class="fontHead" width="100">&nbsp;<asp:Label ID="lblCopyImage" runat="server" Text="Copy Image"></asp:Label></td>
								<td width="20"><asp:radiobutton id="NoneImage" runat="server" GroupName="ImageChoice"></asp:radiobutton></td>
								<td class="fontHead" width="100">&nbsp;<asp:Label ID="lblNone" runat="server" Text="None"></asp:Label></td>
								<td>&nbsp;</td>
							</tr>
						</table>
						<asp:image id="ImgMaterial" runat="server"></asp:image></td>
					<td vAlign="top" width="50%">
						<table class="TableHeader" height="32" cellSpacing="0" cellPadding="0" width="100%" border="0">
							<tr>
								<td align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
								<td class="fontHead" width="200"><asp:Label ID="lblImageProperty" runat="server" Text="Image Property..."></asp:Label>
									</td>
								<td class="fontHead">&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			
			
		</form>
		<script language="javascript">
		var frm = document.Form1 ;
		function DataGrid1_CheckAll( checkAllBox )
		{
		var actVar = checkAllBox.checked ;
		for(i=0;i< frm.length;i++)
		{
			e=frm.elements[i];
			if ( e.type=='checkbox' && e.name.indexOf("DataGrid1_chkSelected") != -1 )
			e.checked= actVar ;
		}
		}
		
		function DataGrid2_CheckAll( checkAllBox )
		{
		var actVar = checkAllBox.checked ;
		for(i=0;i< frm.length;i++)
		{
			e=frm.elements[i];
			if ( e.type=='checkbox' && e.name.indexOf("DataGrid2_chkSelected") != -1 )
			e.checked= actVar ;
		}
        }


        function DataGrid3_CheckAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("DataGrid3_chkSelected") != -1)
                    e.checked = actVar;
            }
        }

        function DataGrid4_CheckAll(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("DataGrid4_chkSelected") != -1)
                    e.checked = actVar;
            }
        }	
        function btnClose_Click() {
                        <%= strExitScript %>
                        return false;
        }
		</script>
	</body>
</HTML>
