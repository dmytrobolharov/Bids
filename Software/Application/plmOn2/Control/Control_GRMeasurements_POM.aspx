<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_GRMeasurements_POM.aspx.vb" Inherits="plmOnApp.Control_GRMeasurements_POM" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>POM</title>
	<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
	<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
	<meta content="JavaScript" name="vs_defaultClientScript">
	<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
	<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <style type="text/css">
        .style1
        {
            width: 146px;
        }
        .style2
        {
            width: 136px;
        }
    </style>
</head>
<body MS_POSITIONING="GridLayout">
   <form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD>
						<cc1:confirmedimagebutton id="btnNew" runat="server" ToolTip="New..." 
							Message="NONE"></cc1:confirmedimagebutton>	
                        <cc1:confirmedimagebutton id="btnPDFView" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnDelete" runat="server" ToolTip="Delete..." 							Message="NONE"></cc1:confirmedimagebutton>						
						<cc1:confirmedimagebutton id="btnClose" Visible="false" runat="server" ToolTip="" OnClientClick="return btnClose_Click()"
							 Message="NONE"></cc1:confirmedimagebutton></TD>
				</TR>
			</TABLE>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
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
								<TD noWrap align="center" class="style1"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
								<TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
								<TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></TD>
								<TD width="10">&nbsp;</TD>
								<TD noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
								<TD class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></TD>
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
								<TD width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead"></asp:button></TD>
							</TR>
						</TABLE>
						<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
							<tr>
								<td class="style2"><asp:placeholder id="plhSearchControl" runat="server"></asp:placeholder></td>
								<td width="100%"><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
							</tr>
						</table>
						<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td>
					<asp:datagrid id="DataGrid1" runat="server"  EnableViewState="True" AllowSorting="true">                            
                            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate" />
                            <ItemStyle Height="20px" CssClass="ItemTemplate" />
                            <headerStyle Height="25px" CssClass="TableHeaderRed"></headerStyle>
                            <PagerStyle Visible="False"></PagerStyle>
                             <Columns>
			                    <asp:TemplateColumn>
			                        <HeaderTemplate >
					                    <input type="checkbox" id="checkAll" onClick="CheckAll(this);" runat="server" name="checkAll">
				                    </HeaderTemplate>
				                    <ItemTemplate>
					                    <asp:CheckBox ID="chkDelete" runat="server"></asp:CheckBox>
				                    </ItemTemplate>
			                    </asp:TemplateColumn>
		                    </Columns>
                        </asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
                     
                       
                       
					</td>
				</tr>
			</table>
				</TR>
			</TABLE>
		</form>		
	</body>
	<script language="javascript">
		var frm = document.Form1 ;
		function CheckAll( checkAllBox )
		{
		var actVar = checkAllBox.checked ;
		for(i=0;i< frm.length;i++)
		{
			e=frm.elements[i];
			if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
			    if (e.disabled==false)
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
</html>

