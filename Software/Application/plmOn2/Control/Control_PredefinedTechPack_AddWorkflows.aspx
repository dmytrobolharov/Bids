<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_PredefinedTechPack_AddWorkflows.aspx.vb" Inherits="plmOnApp.Control_PredefinedTechPack_AddWorkflows" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
        <meta http-equiv="X-UA-Compatible" content="IE=Edge" />
		<title runat="server" id="PageTitle">Add Workflow Type</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <style>
            #lstSelect::-webkit-scrollbar { width: 0 !important }
            #lstSelected::-webkit-scrollbar { width: 0 !important }
            #lstSelect{overflow: hidden; -ms-overflow-style: none; overflow: -moz-scrollbars-none;}
            #lstSelected{overflow: hidden; -ms-overflow-style: none; overflow: -moz-scrollbars-none;}
        </style>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0">
					<tr vAlign="middle">
						<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td vAlign="middle" align="left" width="100%">
						    <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton>
					    </td>
						<td></td>
					</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0" align="center">
				<tr>
					<td align="center" width="45%"><asp:Label ID="lblAvailable" runat="server" style="font-size: larger; font-weight: bold;"></asp:Label></td>
					<td width="10%"></td>
					<td align="center" width="45%"><asp:Label ID="lblSelected" runat="server" style="font-size: larger; font-weight: bold;"></asp:Label></td>
				</tr>
				<tr>
					<td align="center" width="45%">
                        <asp:listbox id="lstSelect" runat="server"  SelectionMode="Multiple" CssClass="fonthead" style="overflow: hidden!important; height: 375px; width:100%; -webkit-overflow-scrolling:touch;" ></asp:listbox>
                    </td>
					<td align="center" width="10%" class="fonthead">(+/-)<br />
						<br />
						<asp:imagebutton id="btnaddall" runat="server" ></asp:imagebutton><br />
						<asp:imagebutton id="btnadditem" runat="server" ></asp:imagebutton><br />
						<asp:imagebutton id="btnremoveitem" runat="server" ></asp:imagebutton><br />
						<asp:imagebutton id="btnremoveall" runat="server" ></asp:imagebutton><br />
					</td>
					<td align="center" width="45%">
						<asp:ListBox id="lstSelected" SelectionMode="Multiple" Runat="server" CssClass="fonthead" style="overflow:hidden!important; height: 375px; width:100%; -webkit-overflow-scrolling:touch;" ></asp:ListBox>
                    </td>    
				</tr>
			</table>
		</form>

        <script type="text/javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
