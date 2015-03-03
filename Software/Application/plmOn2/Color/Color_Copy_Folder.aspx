<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Color_Copy_Folder.aspx.vb" Inherits="plmOnApp.Color_Copy_Folder" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
	<HEAD>
		<title runat="server" id="PageTitle"></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
		<style type="text/css">
		    #DataList1 td.fontHead
		    {
		    	width: 35px;
		        border-right-style: solid;
		        border-top-style: solid;
		        border-right-width: 1px;
		        border-top-width: 1px;
		    }
		    
		    #DataList1 td.font
		    {
		    	width: 200px;
		    	padding: 2px;
		        border-top-style: solid;
		        border-top-width: 1px;
		    }
		</style>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server" defaultbutton = "ImgbtnSearch">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<td>
                        <cc1:confirmedimagebutton id="btnAdd" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnSaveClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                        <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click();"></cc1:confirmedimagebutton>
                    </td>
				</TR>
			</TABLE>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblColorHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Line Plan Folder...</asp:label></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0" class="TableHeader">
				<tr>
					<td align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>&nbsp;<asp:Label ID="lblColorSearch" runat="server" Text=""></asp:Label></td>
				</tr>
			</table>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="false"></asp:placeholder></td>
					<td width="100%" valign="top"><table id="Table3" height="45"><TR><TD><asp:imagebutton id="imgBtnSearch" runat="server"></asp:imagebutton></TD></TR></table></td>
				</tr>
			</table>
            <asp:ScriptManager ID="scrManager" runat="server" EnableViewState="true" ViewStateMode="Enabled" EnablePartialRendering="true"></asp:ScriptManager>
            <asp:Panel ID="Panel1" runat="server" Width="60%" style="float:left;" ScrollBars="Vertical">
                <asp:UpdatePanel ID="pnlUpd" runat="server" UpdateMode="Conditional" ViewStateMode="Enabled">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="imgBtnSearch" />
                </Triggers>
                <ContentTemplate>
			        <table class="TableHeader" cellSpacing="0" cellPadding="0" width="98%" border="0">
				        <tr>
					        <td align="center" width="10" height="30"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					        <td width="100"><asp:label id="lblSelectAll" CssClass="fontHead" Runat="server">Select All</asp:label>&nbsp;<input id="checkAll" onclick="CheckAll(this);" type="checkbox" name="checkAll" runat="server"></td>
                            <td width="20" height="25"><div align="center"><asp:imagebutton id="btnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></div></td>
					        <td width="20" height="25"><div align="center"><asp:imagebutton id="btnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></div></td>
					        <td width="125" height="25"><div align="center"><asp:label id="lblCounts" Runat="server" CssClass="plaintable"></asp:label></div></td>
					        <td width="20" height="25"><div align="center"><asp:imagebutton id="btnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></div></td>
					        <td width="20" height="25"><div align="center"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></div></td>
                            <td height="25"><div align="left"><b><asp:label id="lblRecordsFound" Runat="server" Visible="true"></asp:label></div></td>
                            <TD align="right"><asp:label id="lblRecordPerPage" runat="server" CssClass="fontHead"></asp:label></TD>
						    <TD width="25" align="right"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
							    <asp:ListItem Value="5">5</asp:ListItem>
							    <asp:ListItem Value="10">10</asp:ListItem>
							    <asp:ListItem Value="15">15</asp:ListItem>
							    <asp:ListItem Value="20">20</asp:ListItem>
							    <asp:ListItem Value="25" Selected="True">25</asp:ListItem>
							    <asp:ListItem Value="30">30</asp:ListItem>
							    <asp:ListItem Value="40">40</asp:ListItem>
							    <asp:ListItem Value="50">50</asp:ListItem>
							    </asp:dropdownlist>
                            </TD>
						    <TD width="10" align="right"><asp:button id="btnGo" runat="server" CssClass="fontHead" text="GO"></asp:button></TD>
				        </tr>
			        </table>
                    <asp:datalist id="DataList1" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" EnableViewState="True" DataKeyField="ColorPaletteID">
	                    <ItemStyle BorderWidth="1px" BorderStyle="Solid" BackColor="white" BorderColor="Gainsboro" VerticalAlign="Top"></ItemStyle>
	                    <ItemTemplate>
                            <table width="170px">
                                <tr><td><asp:Label ID="lblMessage" runat="server"></asp:Label></td></tr>
                                <tr>
                                    <td>
		                                <asp:Label align="left" ID="colorChip" runat="server" AssociatedControlID="colorCheck" style="display:block;">
		                                <asp:CheckBox ID="colorCheck" runat="server" /></asp:Label>
		                                <asp:PlaceHolder ID="plhHeaderItem" runat="server"></asp:PlaceHolder>
                                    </td>
                                </tr>
                            </table>
	                    </ItemTemplate>
                    </asp:datalist>
                    <asp:HiddenField ID="CurrentPage" runat="server" Value="0" />
                </ContentTemplate>
                </asp:UpdatePanel>
            </asp:Panel>
            <asp:Panel ID="Panel2" runat="server" style="float:left;" ScrollBars="Vertical" Width="40%">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
      		        <table class="TableHeader" cellSpacing="0" cellPadding="0" width="98%" border="0">
				        <tr>
					        <td align="center" width="10" height="30"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                            <td width="20" height="25"><div align="center"><asp:imagebutton id="exbtnImgFirst" runat="server" ImageUrl="../System/Icons/icon_first.gif"></asp:imagebutton></div></td>
					        <td width="20" height="25"><div align="center"><asp:imagebutton id="exbtnImgPrevious" runat="server" ImageUrl="../System/Icons/icon_Previous.gif"></asp:imagebutton></div></td>
					        <td width="125" height="25"><div align="center"><asp:label id="exlblCounts" Runat="server" CssClass="plaintable"></asp:label></div></td>
					        <td width="20" height="25"><div align="center"><asp:imagebutton id="exbtnImgNext" runat="server" ImageUrl="../System/Icons/icon_next.gif"></asp:imagebutton></div></td>
					        <td width="20" height="25"><div align="center"><asp:imagebutton id="exbtnImgLast" runat="server" ImageUrl="../System/Icons/icon_last.gif"></asp:imagebutton></div></td>
                            <td height="25"><div align="left"><b><asp:label id="exlblRecordsFound" Runat="server" Visible="true"></asp:label></div></td>
                            <TD  align="right"><asp:label id="exlblRecordPerPage" runat="server" CssClass="fontHead"></asp:label></TD>
						    <TD width="25" align="right"><asp:dropdownlist id="exps" runat="server" CssClass="fontHead">
							    <asp:ListItem Value="5">5</asp:ListItem>
							    <asp:ListItem Value="10">10</asp:ListItem>
							    <asp:ListItem Value="15" Selected="True">15</asp:ListItem>
							    <asp:ListItem Value="20">20</asp:ListItem>
							    <asp:ListItem Value="25">25</asp:ListItem>
							    <asp:ListItem Value="30">30</asp:ListItem>
							    <asp:ListItem Value="40">40</asp:ListItem>
							    <asp:ListItem Value="50">50</asp:ListItem>
							    </asp:dropdownlist>
                            </TD>
						    <TD width="10" align="right"><asp:button id="exbtnGo" runat="server" CssClass="fontHead" text="GO"></asp:button></TD>
				        </tr>
			        </table>      
                    <asp:datagrid id="DataGrid1" AutoGenerateColumns="true" runat="server" DataKeyField="ColorPaletteID">
				        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
				        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				        <PagerStyle Visible="False"></PagerStyle>
			        </asp:datagrid>
                    <asp:HiddenField ID="exCurrentPage" runat="server" Value="1" />
                </ContentTemplate>
                </asp:UpdatePanel>
            </asp:Panel>
		</form>
		<script type="text/javascript">
		    var frm = document.Form1;
		    function CheckAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("colorCheck") != -1)
		                e.checked = actVar;
		        }
		    }
		    document.getElementById("Panel1").style.height = top.main.screen.availHeight - top.main.screenTop - document.getElementById("Panel1").offsetTop - 1;
		    document.getElementById("Panel2").style.height = top.main.screen.availHeight - top.main.screenTop - document.getElementById("Panel2").offsetTop - 1;
		
                function btnClose_Click() {
                    <%= strExitScript %>
                    return false;
                }
        </script>
	</body>
</HTML>
