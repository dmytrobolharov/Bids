<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YsTreeView" Assembly="YSTreeView" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Line_List_Folder_MerchandiseTracker.aspx.vb" Inherits="plmOnApp.Line_List_Folder_MerchandiseTracker" %>
<%@ Register Src="Line_List_Header.ascx" TagName="Line_List_Header" TagPrefix="hc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" "http://www.w3.org/TR/REC-html40/loose.dtd">
<HTML>
	<HEAD>
		<title>Line Plan Folder</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/jquery-ui-1.10.3.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/toastr.min.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>

        <style type="text/css">
            th a img {
                border:none;
            }
            th.rgHeaderYPLM, th.rgHeader {
                padding: 0 0px !important;
            }  
            #styles-list  {
            	margin: 0;
            	padding: 2px;
            }
            #styles-list li {
            	list-style-type: none;
            	display: inline-block;
            	margin: 2px;
            	width: 75px;
            	height: 75px;
            	text-align: center;
            	vertical-align: bottom;
            	zoom: 1;
            	*display: inline;            	
            }
            #styles-list li span {
            	display: block;
            	text-align: center;
            	margin-top: 2px;
            }  
            #styles-list img {
            	border: 1px solid #ddd;
            }   
            .img-cont {
            	height: 50px;
            	width: 50px;            	
            }
            #remove-dialog, #empty-message { display: none; }
        </style>
	</HEAD>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">

			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<td>
                        &nbsp;
					</td>
				</TR>
			</TABLE>
            <hc1:Line_List_Header id="LineListHeader" runat="server" />
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Line Plan Folder...</asp:label></td>
				</tr>
			</table>
            <table id="tblFinPlan" width="100%" border="0" bgcolor="#ffffff" cellspacing="0" cellpadding="0" runat="server">
                <tr>
                    <td width="20%" valign="top">
                        <table class="TableHeaderOver" id="tblSourcingHeader" runat="server" height="24" cellSpacing="0" cellpadding="0"
				            width="100%" border="0">
				            <tr>
					            <td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					            <td class="fontHead">
						            <div align="center">
                                        <asp:Label ID="lblMenuHeader" runat="server" ></asp:Label>
                                    </div>
					            </td>
				            </tr>
			            </table>
                        <div id="divMenu" style="overflow: auto;">
                            <cc2:YSTreeView id="YSTreeViewPlanMenu" runat="server"></cc2:YSTreeView>
                        </div>
                    </td>
                    <td width="80%" valign="top">
                       <asp:PlaceHolder runat="server" ID="plhFinancialPlanGrid"></asp:PlaceHolder>
                       &nbsp;
                    </td>
                </tr>
            </table>
<%--            <TABLE  id="StylesExistAlert" cellSpacing="0" cellPadding="0" width="100%" border="1" borderColor="#0061fe"
				runat="server">
				<TR vAlign="middle" align="left">
					<TD vAlign="middle" align="left" ><TABLE id="Table3" cellspacing="1" width="100%" bgColor="#699ff7" border="0"><tr><td><%= GetSystemText("Styles matching this Line Plan exist outside of this plan...")%></TD>	</TR></TABLE>		
            </TD>
								</TR>
			</TABLE>	--%>			
            <asp:placeholder id="phSearch" runat="server"></asp:placeholder>

        <script type="text/javascript" language="javascript">
            function ShowHeaderContent(obj) {
                obj.style.display = 'none';
                document.getElementById('imgBtnCol').style.display = 'block';
                document.getElementById('divHeaderContent').style.display = 'block';
                return false;
            }

            function HideHeaderContent(obj) {
                obj.style.display = 'none';
                document.getElementById('imgBtnExp').style.display = 'block';
                document.getElementById('divHeaderContent').style.display = 'none';
                return false;
            }

        </script>

        <script type="text/javascript" src="../System/Jscript/jquery-1.8.3.min.js"></script>
        <script type="text/javascript" src="../System/Jscript/jquery-ui-1.10.3.custom.min.js"></script>
        <script type="text/javascript" src="../System/Jscript/toastr.min.js"></script>

        <script type="text/javascript">

            toastr.options = {
                "closeButton": true,
                "debug": false,
                "positionClass": "toast-bottom-right",
                "showDuration": "300",
                "hideDuration": "1000",
                "timeOut": "0",
                "extendedTimeOut": "0",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut"
            }

        </script>
        </form>
	</body>
</HTML>
