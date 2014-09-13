<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_Group_Where.aspx.vb" Inherits="plmOnApp.Material_Group_Where" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">

        <TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0">
		    <TR vAlign="middle">
			    <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
			    <td width="80"><cc1:confirmedimagebutton 
			    id="btnBatchUpdate" runat="server" Message="NONE" Visible="true"></cc1:confirmedimagebutton></td>
			    <td width="75">&nbsp;</td>
			    <td>&nbsp;</td>
		    </TR>
	    </TABLE>
	    <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
		    <tr>
			    <td></td>
		    </tr>
	    </table>


    <asp:datalist id="dlStyle" GridLines="Both" RepeatDirection="Horizontal" RepeatColumns="4" BackColor="White"
	    BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="100%" CssClass="font" runat="server"
	    DataKeyField="StyleID">
	    <ItemStyle Height="100px" Width="200px"></ItemStyle>
	    <ItemTemplate>
		    <DIV align="center">
			    <cc1:BWImageButton id="imgStyleFile" runat="server" >
			    </cc1:BWImageButton></DIV>
		    <br/>
		    <asp:PlaceHolder ID="plhHeaderItem" runat="server"></asp:PlaceHolder>
		    <br/><br/>
	    </ItemTemplate>
    </asp:datalist>
    

    </form>
</body>
</html>
