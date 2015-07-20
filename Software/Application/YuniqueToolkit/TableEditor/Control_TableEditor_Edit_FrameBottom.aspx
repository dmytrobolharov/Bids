<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_TableEditor_Edit_FrameBottom.aspx.vb" Inherits="YuniFace.Control_TableEditor_Edit_FrameBottom" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Table File</title>
		<meta name="GENERATOR" content="Microsoft Visual Studio .NET 7.1" />
		<meta name="CODE_LANGUAGE" content="Visual Basic .NET 7.1" />
		<meta name="vs_defaultClientScript" content="JavaScript" />
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5" />
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>

		<script language="JavaScript">
			<!--
		    function SavePage() {
		        document.Form1.hdnMethod.value = 'SAVE';
		        Form1.submit();
		    }
            function NewRecordAdded() {
		        document.Form1.hdnMethod.value = 'NEWRECORDADDED';
		        Form1.submit();
		    }
			//-->
		</script>

    </head>
	<body>
		<form id="Form1" method="post" runat="server" >
            <asp:HiddenField ID="hdnMethod" runat="server" Value="" />

		<div id="TheWholeForm" runat="server">
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
            <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
                <Windows>
                    <telerik:RadWindow ID="NewRecordDialog" runat="server" Title="Dev New Record" Height="700px"
                        Width="700px" ReloadOnShow="true" ShowContentDuringLoad="false" 
                        NavigateUrl="Control_TableEditor_Edit_NewRecord.aspx"
                        Top="10px" Left="10px" 
                        Behaviors="Close, Move, Resize, Maximize"
                        IconUrl="../System/Icons/icon_table.gif"
                        KeepInScreenBounds="true" Modal="true" />
                </Windows>
            </telerik:RadWindowManager>

            <script type="text/javascript">
                //<![CDATA[
                function ShowNewRecordForm() {
                    window.radopen("<%=GetNewRecordPopUpURL()%>", "NewRecordDialog");
                }
                //]]>
            </script>

            <br />
            <cc2:YSTabView ID="YSTabView1" StartTab="1" runat="server"></cc2:YSTabView>

            <asp:Panel runat="server" ID="pnlPerm" Visible="false">
		        <table style="height:50;" cellspacing="0" cellpadding="0" width="100%" bgcolor="#990000" border="1" bordercolor="red">
			        <tr>
				        <td>
                            <table style="height:25;" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td width="25"><div align="center"><asp:image id="Image1" ImageUrl="../System/Icons/icon_lock.gif" runat="server"></asp:image></div></td>
                                    <td><asp:Label ID="lblPerm" runat="server" Text="You might not have permission to edit tables using your credentials." CssClass="fontHead" ForeColor="White"></asp:Label></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>			
	        </asp:Panel>

            <asp:Panel runat="server" ID="pnlSQL" Visible="false">
			    <table cellspacing="0" cellpadding="0" width="100%" border="0">
			        <tr class="font">
				        <td>
					        <asp:label id="lblSQL" runat="server"></asp:label>
				        </td>
			        </tr>
			        <tr class="font">
				        <td>
						    <asp:textbox TextMode="MultiLine" Rows="4" Columns="20" id="txtSQL" runat="server" CssClass="font" Width="100%"></asp:textbox>
				        </td>
			        </tr>
			    </table>

			    <table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
				    <tr valign="middle">
					    <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
					    <td valign="top">
				            <cc1:confirmedimagebutton id="btnRequery" runat="server" Message="NONE" EnableViewState="False" />&nbsp;
				            <cc1:confirmedimagebutton id="btnAdd" runat="server" Message="NONE" EnableViewState="False" OnClientClick="ShowNewRecordForm(); return false;" />&nbsp;
				            <cc1:confirmedimagebutton id="btnDelete" runat="server" Message="NONE" EnableViewState="False" />
                        </td>
					    <td width="75">&nbsp;</td>
					    <td align="right"></td>
				    </tr>
			    </table>

			    <table cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr>
                        <td width="100%" valign="top">
                            <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
					    </td>
				    </tr>
			    </table>
			</asp:Panel>

            <asp:Panel runat="server" ID="pnlWhereUsedSchemas" Visible="false">
                <br />
			    <table cellspacing="0" cellpadding="0" width="100%" border="0">
			        <tr class="font">
				        <td height='25' class='fontHead' nowrap="nowrap">
					        <asp:label id="lblWhereUsedSchemas" runat="server"></asp:label>
				        </td>
			        </tr>
			        <tr class="font">
				        <td>
                            <asp:PlaceHolder ID="plhWhereUsedSchemas" runat="server"></asp:PlaceHolder>
				        </td>
			        </tr>
			    </table>
                <br />
			    <table cellspacing="0" cellpadding="0" width="100%" border="0">
			        <tr class="font">
				        <td height='25' class='fontHead' nowrap="nowrap">
					        <asp:label id="lblWhereUsedTableSQL" runat="server"></asp:label>
				        </td>
			        </tr>
			        <tr class="font">
				        <td>
                            <asp:PlaceHolder ID="plhWhereUsedTableSQL" runat="server"></asp:PlaceHolder>
				        </td>
			        </tr>
			    </table>
			</asp:Panel>

            <asp:Panel runat="server" ID="pnlWhereUsedLookupQueries" Visible="false">
                <br />
			    <table cellspacing="0" cellpadding="0" width="100%" border="0">
			        <tr class="font">
				        <td height='25' class='fontHead' nowrap="nowrap">
					        <asp:label id="lblWhereUsedLookupQueries" runat="server"></asp:label>
				        </td>
			        </tr>
			        <tr class="font">
				        <td>
                            <asp:PlaceHolder ID="plhWhereUsedLookupQueries" runat="server"></asp:PlaceHolder>
				        </td>
			        </tr>
			    </table>
			</asp:Panel>

            <asp:Panel runat="server" ID="pnlWhereUsedColumns" Visible="false">
                <br />
			    <table cellspacing="0" cellpadding="0" width="100%" border="0">
			        <tr class="font">
				        <td height='25' class='fontHead' nowrap="nowrap">
					        <asp:label id="lblWhereUsedColumns" runat="server"></asp:label>
				        </td>
			        </tr>
			        <tr class="font">
				        <td>
                            <asp:PlaceHolder ID="plhWhereUsedColumns" runat="server"></asp:PlaceHolder>
				        </td>
			        </tr>
			    </table>
			</asp:Panel>

            <asp:Panel runat="server" ID="pnlWhereUsedSPXs" Visible="false">
                <br />
			    <table cellspacing="0" cellpadding="0" width="100%" border="0">
			        <tr class="font">
				        <td height='25' class='fontHead' nowrap="nowrap">
					        <asp:label id="lblWhereUsedSPXs" runat="server"></asp:label>
				        </td>
			        </tr>
			        <tr class="font">
				        <td>
                            <asp:PlaceHolder ID="plhWhereUsedSPXs" runat="server"></asp:PlaceHolder>
				        </td>
			        </tr>
			    </table>
			</asp:Panel>

            <asp:Panel runat="server" ID="pnlWhereUsedVWXs" Visible="false">
                <br />
			    <table cellspacing="0" cellpadding="0" width="100%" border="0">
			        <tr class="font">
				        <td height='25' class='fontHead' nowrap="nowrap">
					        <asp:label id="lblWhereUsedVWXs" runat="server"></asp:label>
				        </td>
			        </tr>
			        <tr class="font">
				        <td>
                            <asp:PlaceHolder ID="plhWhereUsedVWXs" runat="server"></asp:PlaceHolder>
				        </td>
			        </tr>
			    </table>
			</asp:Panel>

        </div>
		</form>
	</body>
</html>
