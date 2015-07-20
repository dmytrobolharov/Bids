<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_TempItem_StyleShowroom_2.aspx.vb" Inherits="plmOnApp.LinePlan_TempItem_StyleShowroom_2" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Showroom</title>
	<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
</head>
<body>
    <form id="form1" runat="server">

    		<table class="TableHeader" id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0" 
				runat="server">
				<tr vAlign="middle" height="25">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnRemove" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75"></td>
				</tr>
			</table>
			
	        <table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0" >
			    <TR>
				    <TD>&nbsp;
					    <asp:label id="lbHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Vendor</asp:label></TD>
			    </TR>
		    </table>
		    <br /><br />
		    <cc1:ystabview id="YSTabView1" runat="server"></cc1:ystabview>
	
            <asp:DataGrid  ID="dgStyles" runat="server"  AutoGenerateColumns="false" BorderWidth="0"> 
			<HeaderStyle CssClass="TableHeader" Height="25px"></HeaderStyle>
			<PagerStyle Visible="False"></PagerStyle>
		    <Columns >
		        <asp:TemplateColumn>
		            <HeaderTemplate>
		                <input id="checkAll" runat="server" onclick="CheckAll(this, 'chkSelectStyle');" type="checkbox" />
		            </HeaderTemplate>
		            <ItemTemplate>
		                <asp:CheckBox  runat="server" ID="chkSelectStyle" Checked="false" />
		            </ItemTemplate>
		        </asp:TemplateColumn>

		        <asp:TemplateColumn>
		            <ItemTemplate>
		                <asp:Image runat="server" ID="imgDesign"  />
		            </ItemTemplate>
		        </asp:TemplateColumn>
		        
    		    <asp:TemplateColumn>
		            <ItemStyle Width = "30"  HorizontalAlign="Center"/>
		            <ItemTemplate>
		                <asp:Image runat="server" ID="imgColor"  />
		            </ItemTemplate>
		        </asp:TemplateColumn>
		        
		        		        
		    </Columns>
		    </asp:DataGrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>		    
    
    </form>
    
    	
		<script language="javascript">
		    var frm = document.form1 ;
		    function CheckAll( checkAllBox ,  obj )		{
		        var actVar = checkAllBox.checked ;
		        for(i=0;i< frm.length;i++)		{
			        e=frm.elements[i];
			        if ( e.type=='checkbox' && e.name.indexOf(obj) != -1 )
			     e.checked= actVar ;
		        }
		    }
		</script>    
		
</body>
</html>
