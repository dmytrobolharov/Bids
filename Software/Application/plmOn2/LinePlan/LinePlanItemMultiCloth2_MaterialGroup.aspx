<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="LinePlanItemMultiCloth2_MaterialGroup.aspx.vb" Inherits="plmOnApp.LinePlanItemMultiCloth2_MaterialGroup" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml" >
    <head id="Head1" runat="server">
		<title>Material Group</title>
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">	
	    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>		
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="Gray" 
                            Font-Size="X-Large" Font-Names="Tahoma,Verdana">Material Group</asp:label></td>
				</tr>
			</table>
			<table cellSpacing="2" cellPadding="0" width="100%" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top"></td>
				</tr>
			</table>
        	<asp:datagrid id="dgMaterial" runat="server" DataKeyField="MaterialCoreItemID" AutoGenerateColumns="False" 
                 BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" Visible="true">
				<PagerStyle />
				<AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
			</asp:datagrid>				
        </form>
			
		    <script language="javascript">
		    var frm = document.Form1 ;
		    function CheckAll( checkAllBox ){
		        var actVar = checkAllBox.checked ;
		        for(i=0;i< frm.length;i++) {
			        e=frm.elements[i];
			        if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
			        e.checked= actVar ;
		        }
		    }
   		
		    </script>			
	</body>
</html>
