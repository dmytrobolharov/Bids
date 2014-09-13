<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Body_SizeRange_Variation.aspx.vb" Inherits="plmOnApp.Body_SizeRange_Variation" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Select...</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
		    
</head>
<body>
    <form id="form1" runat="server">

			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton   id="btnClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton></TD>
				</TR>
			</TABLE>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="100%"></td>
				</tr>
			</table>
			
			<TABLE width="100%" bgColor="#ffffff" border="0" >
				<TR>
					<TD width="50">&nbsp;</TD>
					<TD>&nbsp;
						<asp:label id="lblCopyFromSize" runat="server" CssClass="fontHead">Select size to copy from...</asp:label><br/>
						<asp:radiobuttonlist id="rbSizeCopyFrom" runat="server" CssClass="fontHead"></asp:radiobuttonlist></TD>
					<TD>&nbsp;</TD>
				</TR>
				<TR>
					<TD>&nbsp;</TD>
					<TD>&nbsp;</TD>
					<TD>&nbsp;</TD>
				</TR>
				<TR>
					<TD width="50">&nbsp;</TD>
					<TD>&nbsp;
						<asp:label id="lblNewSize" runat="server" CssClass="fontHead">Select new size class...</asp:label><br/>
						<asp:radiobuttonlist id="rbSizeClass" runat="server" CssClass="fontHead" AutoPostBack="True"></asp:radiobuttonlist>
					</TD>
					<TD>&nbsp;</TD>
				</TR>
				<TR>
					<TD>&nbsp;</TD>
					<TD>&nbsp;</TD>
					<TD>&nbsp;</TD>
				</TR>
								
				<TR>
					<td width="50">&nbsp;</td>
					<td>&nbsp;
						<asp:label id="lblOptionSizerange" runat="server" CssClass="fontHead">Select new size range...</asp:label><br />
						<br />
						
						<asp:DataList runat="server" ID="dlBodySets" DataKeyField="BodySet"  >
						    <AlternatingItemStyle CssClass="AlternateItemTemplate" BorderWidth="1px"></AlternatingItemStyle>
    						<ItemStyle CssClass="ItemTemplate" BorderWidth="1px"></ItemStyle>
    						<ItemTemplate>
    						    <table width="500"  cellpadding="0" cellspacing="0" border="0">
    						    <tr height="35">
    						        <td width="150"><asp:Label runat="server" ID="lblBodySet" CssClass="fontHead" ></asp:Label></td>
    						        <td width="350"><asp:radiobuttonlist id="rbSR" runat="server" CssClass="fontHead" RepeatDirection="Vertical" ></asp:radiobuttonlist></td>
    						    </tr>
    						    </table>
    						</ItemTemplate>
						</asp:DataList>
						
                        
						
					</td>
					<td>&nbsp;</td>
				</TR>
				<TR>
					<TD>&nbsp;</TD>
					<TD>&nbsp;</TD>
					<TD>&nbsp;</TD>
				</TR>
			</TABLE>
		

    </form>
</body>
</html>
