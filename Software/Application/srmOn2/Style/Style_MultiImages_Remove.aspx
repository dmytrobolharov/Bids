<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_MultiImages_Remove.aspx.vb" Inherits="srmOnApp.Style_MultiImages_Remove" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title runat="server" id="PageTitle">Style Documents</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">
		<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
			runat="server">
			<TR valign="middle">
				<td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
				<td width="80"><asp:ImageButton id="btnRemove" runat="server" Message="NONE" ></asp:ImageButton></td>
				<td width="80"><asp:ImageButton id="btnClose" runat="server" Message="NONE"  OnClientClick="return btnClose_Click()"></asp:ImageButton></td>
				<td width="75">&nbsp;</td>
				<td>&nbsp;</td>
			</TR>
		</table>
		<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
			height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr>
				<td>&nbsp;<asp:label id="lblImageHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Select Documents...</asp:label>
				</td>
			</tr>
		</table>           			
          
                 <asp:DataGrid id="dgStyleDocument" runat="server" ShowHeader="true" AutoGenerateColumns="False"
							Width="600px" OnItemDataBound="dgStyleDocument_ItemDataBound" BorderWidth="1px" BorderStyle="Solid"
							BorderColor="Silver" DataKeyField="StyleDocumentId">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
							     <asp:TemplateColumn>
	                                <HeaderTemplate>
		                                <input type="checkbox" id="chkSelectChips" onclick="CheckAll(this,'chkChip');" runat="server" name="checkAll" />
	                                </HeaderTemplate>
	                                <ItemTemplate>
		                                <asp:CheckBox id="chkChip" runat="server"></asp:CheckBox>
		                             </ItemTemplate>
                                </asp:TemplateColumn>
								
								<asp:TemplateColumn>
						            <HeaderTemplate>
							            <asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("File Name")%></asp:Label>
						            </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblStyleDocumentName" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>

								<asp:TemplateColumn>
						            <HeaderTemplate>
							            <asp:Label runat="server" CssClass="fontHead" ID="label2"><%#GetSystemText("File Description")%></asp:Label>
						            </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblStyleDocumentDescription" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>

								<asp:TemplateColumn>
						            <HeaderTemplate>
							            <asp:Label runat="server" CssClass="fontHead" ID="label3"><%#GetSystemText("File Date")%></asp:Label>
						            </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblStyleDocumentDate" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>

								<asp:TemplateColumn>
						            <HeaderTemplate>
							            <asp:Label runat="server" CssClass="fontHead" ID="label4"><%#GetSystemText("File Size")%></asp:Label>
						            </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblStyleDocumentSize" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>

								<asp:TemplateColumn>
						            <HeaderTemplate>
							            <asp:Label runat="server" CssClass="fontHead" ID="label5"><%#GetSystemText("Created By")%></asp:Label>
						            </HeaderTemplate>
									<ItemTemplate>
										<asp:Label id="lblCreatedBy" runat="server" />
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:DataGrid>              
                           
          
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
	<script type="text/javascript">
		function btnClose_Click() {
			<%= strExitScript %>
			return false;
		}
	</script>
</html>
