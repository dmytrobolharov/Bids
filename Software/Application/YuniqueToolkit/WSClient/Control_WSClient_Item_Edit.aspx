<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_WSClient_Item_Edit.aspx.vb" Inherits="YuniFace.Control_WSClient_Item_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
	<head>
		<title runat="server" id="PageTitle">Web Service Client Access</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
		<meta content="JavaScript" name="vs_defaultClientScript" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	</head>
	<body>
		<form onkeypress="if(event.keyCode==13) {document.getElementById('btnImgSearch').click(); return false}" id="Form1" method="post" runat="server">
            <telerik:RadScriptManager ID="RadScriptManager1" runat="server" >
                <Scripts>
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
                </Scripts>
                <CdnSettings TelerikCdn="Disabled" />
            </telerik:RadScriptManager>
            <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" Runat="server">
                <StyleSheets>
                    <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
                    <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
                    <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
                    <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
                </StyleSheets>
                <CdnSettings TelerikCdn="Disabled" />
            </telerik:RadStyleSheetManager>
            <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" />

			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10">
					    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
					    <asp:imagebutton id="btnInvSearch" tabIndex="0" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton>
					</td>
					<td>
					    <cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
			        </td>
					<td class="fontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Web Service Client Access</asp:label></td>
				</tr>
			</table>
			<asp:datalist id="dlWSClientAccess" runat="server" Width="100%" 
                BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" 
                style="margin-top: 0px">
				<AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
				<FooterTemplate>
				</FooterTemplate>
				<ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray" BackColor="White"></ItemStyle>
				<ItemTemplate>
					<table width="100%">
						<tr>
							<td width="20"><asp:Image id="iconStatus" runat="server"></asp:Image></td>
							<td class="fontHead" width="200"><%#Container.DataItem("WebServiceName")%></td>
							<td width="125">
								<asp:RadioButtonList id="rbAccess" runat="server" Width="200px" OnSelectedIndexChanged="SelectedIndexChanged"
									RepeatDirection="Horizontal" AutoPostBack="True" CssClass="fontHead">
								</asp:RadioButtonList>
						    </td>
							<td>
								<asp:Panel id="pnlPartial" runat="server">
                                    <asp:CheckBox ID="cbAccessView" runat="server" AutoPostBack="True" CssClass="fontHead" OnCheckedChanged="SelectedIndexChanged" Text='<%#GetSystemText("View") %>' />
                                    <asp:CheckBox ID="cbAccessCreate" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Create") %>' />
                                    <asp:CheckBox ID="cbAccessModify" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Modify") %>' />
                                    <asp:CheckBox ID="cbAccessDelete" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Delete") %>' ForeColor="Red" />
                                    <asp:CheckBox ID="cbAccessPrint" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Print") %>' />
								</asp:Panel>
							</td>
						</tr>
					</table>		
					<table>
					    <tr>
					        <td width="20"></td>
                            <td colspan="3">
                                <asp:DataList ID="dlWebServiceItemTab" runat="server" BorderColor="Silver" 
                                    BorderStyle="Solid" BorderWidth="1px" Width="100%" OnItemDataBound="dlWebServiceItemTabDataBound">
                                    <AlternatingItemStyle BackColor="AliceBlue" />
                                    <FooterTemplate>
                                    </FooterTemplate>
                                    <ItemStyle BackColor="White" BorderColor="LightGray" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemTemplate>
                                        <table width="100%">
                                            <tr>
                                                <td width="20">
                                                    <asp:Image ID="iconStatusTab" runat="server" />
                                                    <asp:HiddenField ID="hdnSchemaFile" runat="server" Value="" />
                                                </td>
                                                <td class="fontHead" width="200">
													<a class="fontHead" href="Control_WSClient_RESTfulTest.aspx?WSID=<%#Container.DataItem("WebServiceID")%>&WSIID=<%#Container.DataItem("WebServiceItemID")%>&WSCID=<%#Container.DataItem("WSClientID")%>">
                                                        <%#Container.DataItem("WebServiceItemName")%>
                                                    </a>
                                                </td>
                                                <td width="125">
                                                    <asp:RadioButtonList ID="rbAccessTab" runat="server" AutoPostBack="True" 
                                                        CssClass="fontHead" OnSelectedIndexChanged="SelectedIndexTabChanged" 
                                                        RepeatDirection="Horizontal" Width="200px">
                                                    </asp:RadioButtonList>
                                                </td>
                                                <td>
                                                    <asp:Panel ID="pnlPartialTab" runat="server">
                                                        <asp:CheckBox ID="cbAccessViewTab" runat="server" AutoPostBack="True" CssClass="fontHead" OnCheckedChanged="SelectedIndexTabChanged" Text='<%#GetSystemText("View") %>' />
                                                        <asp:CheckBox ID="cbAccessCreateTab" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Create") %>' />
                                                        <asp:CheckBox ID="cbAccessModifyTab" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Modify") %>' />
                                                        <asp:CheckBox ID="cbAccessDeleteTab" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Delete") %>'  ForeColor="Red" />
                                                        <asp:CheckBox ID="cbAccessPrintTab" runat="server" CssClass="fontHead" Text='<%#GetSystemText("Print") %>' />
                                                    </asp:Panel>
                                                </td>
                                            </tr>
                                        </table>
                                    </ItemTemplate>
                                </asp:DataList>
                            </td>
                        </tr>
					</TABLE>
				</ItemTemplate>
			</asp:datalist>
		    <SCRIPT language="javascript">
		    var frm = document.Form1 ;
		    function CheckAll( checkAllBox )
		    {
		    var actVar = checkAllBox.checked ;
		    for(i=0;i< frm.length;i++)
		    {
			    e=frm.elements[i];
			    if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
			    e.checked= actVar ;
		    }
		    }
		    </SCRIPT>
		    <asp:Label id="lblWarning" runat="server" CssClass="fontHead"></asp:Label>
	    </form>
	</body>
</html>
