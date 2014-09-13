<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DetailGrid_Custom.aspx.vb" Inherits="srmOnApp.Style_DetailGrid_Custom" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title runat="server" id="PageTitle">Style</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">

        <table class="TableHeader" height="27" cellSpacing="0" cellPadding="0" width="100%" border="0" >
		<TR vAlign="middle">
			<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
			<TD><cc1:confirmedimagebutton id="cmdPdfPrint" runat="server" 
					Message="NONE"></cc1:confirmedimagebutton></TD>
		</TR>
	    </table>
			
			<uc2:style_header id="Style_Header1" runat="server" StyleID='<%Request("SID")%>'/>
			<uc1:style_comment id="Style_Comment1" runat="server" />
			<asp:datagrid id="DataGrid1" runat="server" EnableViewState="False"
				BorderColor="#E0E0E0">
				<AlternatingItemStyle Height="20px"  CssClass="AlternateItemTemplate"></AlternatingItemStyle>
				<ItemStyle Height="25px" CssClass="ItemTemplate"></ItemStyle>
				<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
				<PagerStyle Visible="False"></PagerStyle>
  		    </asp:datagrid>
    </form>
</body>
</html>
