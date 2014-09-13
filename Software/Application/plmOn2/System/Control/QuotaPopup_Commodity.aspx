<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="QuotaPopup_Commodity.aspx.vb" Inherits="plmOnApp.QuotaPopup_Commodity" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
	<title runat="server" id="PageTitle"></title>
	
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../CSS/Grid.css" type="text/css" rel="stylesheet">
		<script language="javascript">
		    function SelectWindowCustom(sValue, sTxtBox) {
		        opener.document.Form1[sTxtBox].value = sValue;
		        try {
		            opener.document.Form1['fx_' + sTxtBox].value = sValue;
		        } catch (err) { }		        
		        self.close();
		    }

		    function SetHiddenVariable() {
		        var e = document.getElementById("drlCustomCode");
		        var hiddenControl = '<%= inpHide.ClientID %>';
		        var hiddenControlFlag = '<%= inpFlag.ClientID %>';

		        if (e.options[e.selectedIndex].text == "" && document.getElementById(hiddenControl).value == "" && document.getElementById(hiddenControlFlag).value == "") {

		            //alert(opener.document.Form1.drlCustomField4[opener.document.Form1.drlCustomField4.selectedIndex].value);
		            //alert ('aaa');					
		            var cf = opener.document.Form1.drlCustomField4;
		            if (cf) {

		                if (opener.document.Form1.drlCustomField4.selectedIndex != -1) {

		                    var jsVar = opener.document.Form1.drlCustomField4[opener.document.Form1.drlCustomField4.selectedIndex].value;
		                    document.getElementById(hiddenControl).value = jsVar;
		                    e.options[e.selectedIndex].text = jsVar;
		                    document.getElementById('<%= imgBtnSearch.ClientID %>').click();
		                }
		            }


		            else {
		                var jsVar = opener.document.Form1.fx_lblCustomField4.value;

		                //alert(jsVar);						

		                document.getElementById(hiddenControl).value = jsVar;
		                e.options[e.selectedIndex].text = jsVar;
		                document.getElementById('<%= imgBtnSearch.ClientID %>').click();

		            }



		        }



		        if (document.getElementById(hiddenControl).value == e.options[e.selectedIndex].text) {
		            //document.getElementById(hiddenControl).value = "";
		        }
		        else {
		            if (e.options[e.selectedIndex].text == "" && document.getElementById(hiddenControlFlag).value == "true") {
		                e.options[e.selectedIndex].text = document.getElementById(hiddenControl).value;
		                document.getElementById(hiddenControlFlag).value = "false";
		            }
		        }

		    }
		    function AddHandler() {
		        var ddl = document.getElementById("drlCustomCode");
		        SetHiddenVariable();
		    }                      	
		</script>
	</HEAD>
	<body  MS_POSITIONING="GridLayout" onload="AddHandler()">
		<form id="Form1" method="post" runat="server">
		    <input id="inpHide" type="hidden" runat="server" />
		     <input id="inpFlag" type="hidden" runat="server" />
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td height="40">&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#999999" 
                            Font-Size="Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
				<TR vAlign="top">
					<TD>
						<table>
							<tr>
								<TD width="10">&nbsp;</TD>
								<TD width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></TD>
								<TD width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></TD>
								<TD noWrap align="center" width="100"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></TD>
								<TD width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></TD>
								<TD width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></TD>
								<TD width="10">&nbsp;</TD>
								<TD noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></TD>
								<TD width="50">&nbsp;</TD>
								<TD class="fontHead" noWrap><asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></TD>
								<TD width="10"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead" Visible="true">
										<asp:ListItem Value="5">5</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="20">20</asp:ListItem>
										<asp:ListItem Value="25">25</asp:ListItem>
										<asp:ListItem Value="30">30</asp:ListItem>
										<asp:ListItem Value="40">40</asp:ListItem>
										<asp:ListItem Value="50"  Selected="True">50</asp:ListItem>
										<asp:ListItem Value="75">75</asp:ListItem>
										<asp:ListItem Value="100">100</asp:ListItem>
									</asp:dropdownlist></TD>
								<TD width="10"><asp:button id="Button1" onclick="RePage" runat="server" CssClass="fontHead"  Visible="true"></asp:button></TD>
								<TD>&nbsp;</TD>
							</tr>
						</table>
						<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
							<tr>
								<td><asp:placeholder id="plhSearchControl" runat="server"></asp:placeholder></td>
								<td width="100%" vAlign="top"><table height="45">
										<tr>
											<td><asp:imagebutton id="imgBtnSearch" runat="server"  /></td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
						<asp:datagrid id="DataGrid1" runat="server" DataKeyField="CustomID">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
						</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label></TD>
				</TR>
			</TABLE>						
		</form>
	</body>
</HTML>



