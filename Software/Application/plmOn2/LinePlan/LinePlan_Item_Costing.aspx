<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_Item_Costing.aspx.vb" Inherits="plmOnApp.LinePlan_Item_Costing" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register src="LinePlanningHeader.ascx" tagname="LinePlanningHeader" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Costing</title>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8" />    
    <LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        
        <table class="TableHeader" id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0"
		    runat="server">
		    <tr vAlign="middle">
			    <td vAlign="middle" align="center" width="10"><asp:imagebutton 
			    id="btnInvSearch" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
			    <td><cc1:confirmedimagebutton    id="btnSaveClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
			    <cc1:confirmedimagebutton     id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>
			    <cc1:ConfirmedImageButton 	id="btnUnlock"  Message="Do you want to continue?" runat="server"/>
			    <cc1:bwimagebutton id="btnChangeLog" runat="server"></cc1:bwimagebutton>
			    <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
			    <td class="FontHead" align="right" width="75"></td>
			    <td width="40"></td>
			    <td></td>
		    </tr>
		</table>
    
        <uc1:LinePlanningHeader ID="LinePlanningHeader1" runat="server" />    

        <br/><br/>
    
        <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
		    <tr>
			    <td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
			    <td width="100%" valign="top">
				    <table height="45">
					    <tr>
						    <td>
							    <asp:imagebutton id="imgBtnSearch" runat="server" CausesValidation="false"></asp:imagebutton></td>
					    </tr>
				    </table>
			    </td>
		    </tr>
	    </table>                
	    
        
    <asp:datagrid id="DataGrid1" runat="server" BorderColor="#E0E0E0" PageSize="100" AllowSorting="True"
							DataKeyField="StyleCostingHeaderID" BackColor="White" Width="300px">
							<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
						</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
    
            
        <input type ="hidden" runat ="server" id="hdnSQL" />            
        
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
