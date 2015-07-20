<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Color_PaletteImageSelect.aspx.vb" Inherits="plmOnApp.Color_PaletteImageSelect" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<HTML>
	<HEAD>
		<title>Select Images</title>
		<meta name="vs_defaultClientScript" content="JavaScript">
		<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <script language="javascript" SRC="../System/Jscript/jquery-1.8.3.min.js"></script>
		<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>       
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>        
	    <style type="text/css">
	        .DescriptionStyle
	        {
	            height:16px;
	            display: inline-block;
	            overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
	                       
	        }	
	        .font
            {
             font-family: Tahoma, Geneva, Arial, Helvetica, sans-serif;
             font-weight: normal;
             font-size: 11px; 
             color: Black;
             vertical-align:middle;
            }       
        </style>
    </HEAD>
    
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0"  width="100%" border="0" runat="server"  style="padding-top:0;">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><asp:imagebutton id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" ></asp:imagebutton>                   
                        <cc1:confirmedimagebutton id="btnAdd" runat="server" Message="NONE" ></cc1:confirmedimagebutton>                    
                        <cc1:confirmedimagebutton id="imgBtnClose" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                    </td> 
                    <td>&nbsp;</td>                        
				</tr>
			</TABLE>
			<table  style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
                    height="45" width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
				<tr>
					<td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Select Image...</asp:Label></td>
				</tr>
			</table>
			<cc3:YSTabView id="YSTabView1" runat="server"></cc3:YSTabView>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" vAlign="top">
						<TABLE id="Table3" height="45">
							<TR>
								<TD>
									<asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></TD>
							</TR>
						</TABLE>
					</td>
				</tr>
			</table>
			<asp:PlaceHolder id="phGrid" runat="server"></asp:PlaceHolder>
		</form> 
	</body>
</HTML>
