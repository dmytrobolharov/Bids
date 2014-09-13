<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_BOL_Machines_Edit.aspx.vb" Inherits="plmOnApp.Control_BOL_Machines_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title>Control Panel</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />

    <script language="javascript" type="text/javascript">
// <!CDATA[

        //function Submit1_onclick() {

        //}

// ]]>
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <wc1:Color_Wait ID="Color_Wait" runat="server" />
    <div>
		<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
			runat="server">
			<tr vAlign="middle">
				<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				<td>
				    <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>
				    <cc1:confirmedimagebutton id="btnSaveClose" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnSaveNew" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnDelete" runat="server" CausesValidation="false"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="false"></cc1:confirmedimagebutton>
				</td>
				<td class="FontHead" align="right" width="75"></td>
				<td width="40"></td>
				<td></td>
			</tr>
		</table>
		
		<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
			height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr>
				<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label></td>
			</tr>
		</table>
		<table cellSpacing="2" cellPadding="0" width="100%" border="0">
			<tr>
				<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				<td vAlign="top">
                    <table cellspacing="0" cellpadding="0" width="300" border="0" style="background-color:White">
                        <tr>
                            <td class="fontHead" valign="top" width="100">
                               <asp:Label ID="lblImageFile" runat="server"></asp:Label>:
                            </td>
                            <td class="font">
                                <input class="font" id="txtImagePath" type="file" name="txtImagePath" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"  class="font" width="50">
                            <br />
                                <cc1:BWImageButton id="imgFeature" runat="server" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <cc1:confirmedimagebutton id="btnImageRemove" runat="server"  />
                            </td>

                        </tr>
                    </table>
				</td>
			</tr>
		</table>
       
        <asp:datagrid id="DataGrid1" runat="server" AllowSorting="True" 
            DataSourceID="SqlDataSource1" >
			<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
			<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
			<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
			<PagerStyle Visible="False"></PagerStyle>
		</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
        
		<table cellSpacing="0" cellPadding="0" width="100%" border="0">
			<tr>
				<td vAlign="top"></td>
			</tr>
		</table>
					    
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server"></asp:SqlDataSource>
    </form>
</body>
</html>
