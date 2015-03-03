<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_Item_StyleColor_ApplyAll.aspx.vb" Inherits="plmOnApp.LinePlan_Item_StyleColor_ApplyAll" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server">


	    <table class="tableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
		    runat="server">
		    <tr vAlign="middle">
			    <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
			    <td><asp:imagebutton 
			    id="btnInvSearch" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton><asp:ImageButton 
			    id="btnSave" runat="server" ></asp:ImageButton>
			    <asp:ImageButton    id="btnClose" runat="server" OnClientClick="return btnClose_Click()"  CausesValidation="False"></asp:ImageButton></td>
		    </tr>
	    </table>		
	    <br /><br />
        <asp:datagrid id="dgColorway" runat="server" DataKeyField="StyleColorwaySeasonYearID" AutoGenerateColumns="False" 
             BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" Visible="true">
			<PagerStyle />
			<AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
			<ItemStyle Height="20px" CssClass="font"></ItemStyle>
			<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
			<PagerStyle Visible="False"></PagerStyle>
			<Columns>
			    <asp:TemplateColumn>
			        <ItemTemplate>
			            <span>&nbsp;</span>
			        </ItemTemplate>
			    </asp:TemplateColumn>
			</Columns>
		</asp:datagrid>
		<input type="hidden" runat="server"  id="hdStyleColorwaySeasonYearID" />
		
        <br /><br />
        <asp:datagrid id="dgMessage" runat="server" AutoGenerateColumns="False" 
             BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" Visible="true">
			<PagerStyle />
			<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
			<ItemStyle Height="20px" BackColor="White"></ItemStyle>
			<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
			<PagerStyle Visible="False"></PagerStyle>
			<Columns>
			    <asp:BoundColumn DataField="Message" HeaderText="Message">
			    </asp:BoundColumn>
			</Columns>
		</asp:datagrid>
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
