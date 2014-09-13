<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="LinePlanningMaterial_Remove.aspx.vb" Inherits="plmOnApp.LinePlanningMaterial_Remove" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<head>
		<title>Material Remove</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
		<script language="javascript" src="../System/Jscript/Custom.js"></script>
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>		   
	</head>
	<body MS_POSITIONING="GridLayout">
		<form id="form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton 
					    id="btnRemove" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
					    id="btnClose" runat="server"  Message="NONE" ></cc1:confirmedimagebutton></td>
				</tr>
			</TABLE>						
			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="top">
					<TD>
						<TABLE class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
							border="0">
							<TR vAlign="middle">
								<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
								<TD width="16"></TD>
								<TD class="fontHead" width="100"></TD>
								<TD width="20"></TD>
								<TD width="20"></TD>
								<TD noWrap align="center" width="125"></TD>
								<TD width="20"></TD>
								<TD width="20"></TD>
								<TD width="10">&nbsp;</TD>
								<TD noWrap></TD>
								<TD class="fontHead" align="right" width="110"></TD>
								<TD width="25"></TD>
								<TD width="10"></TD>
							</TR>
						</TABLE>						
						<asp:datagrid id="DataGrid1" runat="server" DataKeyField="MaterialID" BorderStyle="Solid" BorderWidth="1px" PageSize="50" >
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False" ></PagerStyle>
							<Columns>
							    <asp:TemplateColumn>
							        <HeaderTemplate>
							            <input type="checkbox" id="checkAll" onclick="CheckAll(this);" runat="server" name="checkAll" />
							        </HeaderTemplate>
									<ItemTemplate>
										<asp:CheckBox id="chkSelected" runat="server"></asp:CheckBox>
									</ItemTemplate>							        
							    </asp:TemplateColumn>	 					
                            </Columns>
						</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
						<input type="hidden" runat="server" id="hiddenCurrentPage"  value="0"/>
						</TD>
				</TR>
			</TABLE>
		</form>
		<SCRIPT language="javascript">
		    var frm = document.form1;
		    function CheckAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chkSelected") != -1)
		                e.checked = actVar;
		        }
		    }
		</SCRIPT>
	</body>
</HTML>
