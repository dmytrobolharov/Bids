<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Report_Main.aspx.vb" Inherits="YuniqueBI.Report_Main"%>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=10.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />
        <script language="javascript" src="../System/Jscript/BrowserDetect.js"></script>
        <style type="text/css">
            .DropdownLabel
            {
                font-family: Verdana;
                font-size: 8pt;
                font-weight: bold;
            }
            .Dropdown
            {
                font-family: Verdana;
                font-size: 8pt;
            }
            html, body
            {
                overflow: hidden;
                height: 100%;
            }
            body
            {
                margin: 0;
                padding: 0;
            }
            html#html, body#body, form#form1, div#content
            {
                height: 90%;
            }
        </style>

	</head>
	<body onload="FixImageSize()">
		<form id="Form1" method="post" runat="server">
		
        <table border="0" cellspacing="5" cellpadding="5" >
            <tr>
                <td>
                    &nbsp; &nbsp;<asp:Label runat="server" ID="lblLanguage" CssClass="DropdownLabel">Language:</asp:Label>
                </td>
                <td>
                    &nbsp;<asp:DropDownList ID="ddlLanguage" runat="server" AutoPostBack="false" Width="200" CssClass="Dropdown"></asp:DropDownList>
                </td>
                <td>
                    <asp:button id="Button1" runat="server" CssClass="DropdownLabel" Text="GO" /> 
                </td>
                <td>
                    <asp:button id="btnEditReport" runat="server" CssClass="DropdownLabel" Text="Edit Report" />                   
                </td> 
                <td><asp:hiddenfield id="lblCurrentReport" runat="server"  /> </td>
            </tr>
        </table>		    

            <asp:ScriptManager ID="ScriptManager1" runat="server" />
	        <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana"  
                Font-Size="8pt" Height="100%" ProcessingMode="Remote" Width="100%" 
                BorderColor="Gray" 
                BorderStyle="Solid" BorderWidth="1px" 
                ShowBackButton="True" BackColor="WhiteSmoke" 
                ToolBarItemHoverBackColor="GhostWhite" 
                ToolBarItemPressedHoverBackColor="Gainsboro" 
            SizeToReportContent="false" AsyncRendering=false>
            </rsweb:ReportViewer>
            
            <asp:Panel id="pnlMain"  runat="server">
            
                <table width="100%" height="27" border="0" cellpadding="0" cellspacing="0" class="TableHeader">
				    <tr>
					    <td width="100%">&nbsp;</td>
					    <td>&nbsp;</td>
				    </tr>
			    </table>
			    <table width="100%" height="25" border="0" cellpadding="0" cellspacing="0" bgcolor="#cddeee">
				    <tr>
					    <td>&nbsp;</td>
					    <td>&nbsp;</td>
				    </tr>
			    </table>
			    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
				    <tr>
					    <td valign="top" bgcolor="#ffffff"><table width="100%" border="0" cellspacing="0" cellpadding="0">
							    <tr>
								    <td><div align="right">
										    <DIV align="right">
											    <asp:Label id="lblHeader" runat="server" Font-Size="XX-Large" ForeColor="Silver">Report Folder</asp:Label></DIV>
									    </div>
								    </td>
							    </tr>
						    </table>
						    <table width="100%" height="100" border="0" cellpadding="0" cellspacing="0">
							    <tr>
								    <td width="33%">&nbsp;</td>
								    <td width="33%">&nbsp;</td>
								    <td width="33%">&nbsp;</td>
							    </tr>
						    </table>
						    <table width="100%" height="50%" border="0" cellpadding="0" cellspacing="0">
							    <tr>
								    <td width="33%">&nbsp;</td>
								    <td width="33%">&nbsp;</td>
								    <td width="33%">&nbsp;</td>
							    </tr>
						    </table>
    						
					    </td>
					    <td width="200" bgcolor="#ffffff">&nbsp;</td>
				    </tr>
			    </table>
            </asp:Panel>            
            
	    </form>
        <script type="text/javascript" language="javascript">
            function FixImageSize() {
                if (BrowserDetect.browser.toLowerCase() == 'explorer' && BrowserDetect.isIE9) {
                    if (document.getElementById('ReportViewer1') != null) {
                        document.getElementById('ReportViewer1').ClientController.ActionHandler('Refresh', null);
                    }
                }
            }

		</script>
        <script type="text/javascript" src="../System/Jscript/jquery-1.8.3.min.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $("[id$='Toolbar'] > div > div").children().css("display", "inline");
            });
        </script>
	</body>
</html>
