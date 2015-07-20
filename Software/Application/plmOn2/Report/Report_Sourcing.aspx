<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Report_Sourcing.aspx.vb" Inherits="plmOnApp.Report_Sourcing" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title runat="server" id="PageTitle">Sourcing</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<script language="JavaScript" >
	<!--
	function DoPageLoad() 
	{
		
		var Timer = setTimeout('self.focus();', 1000);
	}
	// -->
	</script>    
</head>
<body onbeforeunload="busyBox.Show();" onload="DoPageLoad();">
    <script language="javascript" src="../system/jscript/ysbusyscript.js" type="text/javascript"></script>
    <form id="form1" runat="server">

			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="80"><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton></TD>
					<TD><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></TD>
				</TR>
			</TABLE>

		    <TABLE cellSpacing="0" cellPadding="0" width="500" border="0">
			    <TR>
                    <TD vAlign="middle" align="center" width="20" height="25">
                    </TD>
				    <TD width="100">
					    <asp:Label id="lblTechPackLanguage" Runat="server" CssClass="fontHead">Language:</asp:Label>
					</TD>
				    <TD width="400">
                        <asp:DropDownList ID="ddlLanguage" runat="server" AutoPostBack="false"></asp:DropDownList>
					</TD>
			    </TR>
		    </TABLE>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="100%"></td>
				</tr>
			</table>

			<asp:datagrid id="DataGrid1" runat="server" Width="100%" AutoGenerateColumns="False" PageSize="100"
				BorderWidth="1px" BorderStyle="Solid" BorderColor="Silver">
				<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderStyle HorizontalAlign="Center" Width="50px"></HeaderStyle>
						<HeaderTemplate>
							<asp:Label runat="server" CssClass="fontHead" ID="lblSelectHeader">&nbsp;<%#GetSystemText("Select")%>&nbsp;</asp:Label>
						</HeaderTemplate>
						<ItemStyle HorizontalAlign="Center"></ItemStyle>
						<ItemTemplate>
						    <asp:Label id="lblRadio" runat="server"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<asp:Label runat="server" CssClass="fontHead" ID="lblSelectPageHeader"><%#GetSystemText("Select page to print")%>...</asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="lblReportPage" runat="server"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid><br>
			<div id="BusyBoxDiv" style="BORDER-RIGHT: gainsboro 0px solid; PADDING-RIGHT: 5px; BORDER-TOP: gainsboro 0px solid; PADDING-LEFT: 5px; PADDING-BOTTOM: 5px; BORDER-LEFT: gainsboro 0px solid; PADDING-TOP: 5px; BORDER-BOTTOM: gainsboro 0px solid; POSITION: absolute; BACKGROUND-COLOR: transparent; TEXT-ALIGN: center">
				<p style="WIDTH: 220px; TEXT-ALIGN: center">
				<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="1">
					<TR>
						<TD height="32" width="50"><img id="BusyBoxImg" src="../system/images/busy_Layer_0.gif" width="32" height="32"></TD>
						<TD class="fontHead"><asp:label id="lblPleaseWait" runat="server" CssClass="fontHead">Please Wait...</asp:label><br>
							<asp:label id="lblReportLoading" runat="server" CssClass="fontHead">Report Loading</asp:label></TD>
					</TR>
				</TABLE>
				</p>
			</div>
			<script language="javascript" type="text/javascript">
				// Instantiate our BusyBox object
				var busyBox = new BusyBox("busyBox", 12, "busy_Layer_", ".gif", 120);
			</script>
			
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
