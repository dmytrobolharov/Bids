<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BatchQ_TechPack_CreateZip.aspx.vb" Inherits="srmOnApp.BatchQ_TechPack_CreateZip" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />        
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        
        <asp:placeholder id="phNav" runat="server"></asp:placeholder>

      
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
	        runat="server">
	        <TR valign="middle">
		        <td valign="middle" align="center" width="10" height="27">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
		        <td><cc1:confirmedimagebutton 
		            id="btnExecute" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
		            id="btnClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
		        <td width="75">&nbsp;</td>
		        <td>&nbsp;</td>
	        </TR>
        </table> 

        <asp:Panel  runat="server" ID="pnlDownload" >
            <table class="TableHeaderGreen" cellspacing="0" cellpadding="0" width="100%" height="30"
                border="0">
                <tr valign="middle">
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                    </td>
                    <td width="20"><img src="../System/Icons/ext_zip.gif" /></td>
                    <td nowrap="nowrap">
                        <asp:Label runat="server" ID="lblZipDownload" class="fontHead" >Download Zip file</asp:Label>
                    </td>
                </tr>
            </table>
        </asp:Panel>


        <asp:placeholder id="phSeason" runat="server"></asp:placeholder>  
        <table id="Table1" class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0"
            runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10" height="27">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                </td>
                <td><asp:Label runat="server" ID="lblTechPack">Selected Tech pack:</asp:Label>&nbsp;<asp:Label CssClass="font" runat="server" ID="lblTechPackName"></asp:Label></td>
            </tr>
        </table>         
        <table id="Table2" class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0"
            runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10" height="27">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                </td>
                <td><asp:Label runat="server" ID="lblStyles">Selected Styles</asp:Label></td>
            </tr>
        </table>         
        
        <asp:datagrid id="DataGrid1" runat="server" AllowSorting="false" DataKeyField="StyleID">
            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
            <ItemStyle Height="20px" ></ItemStyle>
            <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
            <PagerStyle Visible="False"></PagerStyle>
        </asp:datagrid><asp:label id="SortOrder1" runat="server" Visible="False"></asp:label>                
    
    </div>
    </form>
</body>
</html>
