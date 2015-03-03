<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BatchQ_Final_MaterialToStyle.aspx.vb" Inherits="plmOnApp.BatchQ_Final_MaterialToStyle" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
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
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
	        <TR valign="middle">
		        <td valign="middle" align="center" width="10" height="27">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
		        <td >
                    <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                    <cc1:confirmedimagebutton id="btnRefresh" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                </td>
		        <td width="75">&nbsp;</td>
		        <td>&nbsp;</td>
	        </TR>
        </table>   
        
        <asp:placeholder id="phSeason" runat="server"></asp:placeholder>
        <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
	        <TR valign="middle">
		        <td valign="middle" align="center" width="10" height="27">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
		        <td>
                    <asp:Label ID="lblBar1" runat="server" Text="Label"></asp:Label>
                </td>
	        </TR>
        </table>            
        <asp:placeholder id="phHeader" runat="server"></asp:placeholder> 
        <br /> 
        <table cellSpacing="0" cellPadding="0" border="0">
			<tr valign="top">
				<td>
                    <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
	                    <TR valign="middle">
		                    <td valign="middle" align="center" width="10" height="27">
                                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
		                    <td>
                                <asp:Label ID="lblBar2" runat="server" Text="Label"></asp:Label>
                            </td>
	                    </TR>
                    </table>  
					<asp:datagrid id="DataGrid1" runat="server" AllowSorting="false">
						<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
						<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
						<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
						<PagerStyle Visible="False"></PagerStyle>
					</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
			    </td>
			        <td width="25">&nbsp;</td>
			    <td>
                   <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
	                    <TR valign="middle">
		                    <td valign="middle" align="center" width="10" height="27">
                                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
		                    <td>
                                <asp:Label ID="lblBar3" runat="server" Text="Label"></asp:Label>
                            </td>
	                    </TR>
                    </table> 
                    <asp:datagrid id="DataGrid2" runat="server" AllowSorting="false">
						<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
						<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
						<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
						<PagerStyle Visible="False"></PagerStyle>
					</asp:datagrid>	    
			    </td>
			</tr>
		</TABLE>


			            			
    </div>
    </form>
</body>
</html>
