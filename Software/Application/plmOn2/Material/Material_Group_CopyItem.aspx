<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Material_Group_CopyItem.aspx.vb" Inherits="plmOnApp.Material_Group_CopyItem" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml" >
    <head id="Head1" runat="server">
		<title>Material Group</title>
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
         <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />	
	    <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>		
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton 
					id="btnSave" runat="server" Message="NONE" 
                            style="height: 24px"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton 
					id="btnClose" runat="server" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Material Group</asp:label></td>
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
			<br />
			<table>
			<tr><td valign="top" width="50%">
			    <table style="BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				    height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				    <tr>
					    <td>&nbsp;<asp:label id="lblMaterials" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Components</asp:label></td>
				    </tr>
			    </table>			        	
			    <asp:datagrid id="dgMaterial" runat="server" DataKeyField="MaterialCoreItemID" AutoGenerateColumns="False" 
                 BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" Visible="true">
				<PagerStyle />
				<AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
                <Columns>
                    <asp:TemplateColumn>
                        <HeaderTemplate>
                            <input type="checkbox" onclick="SelectAll(this,'chkMaterial')" id="chkSelectAll" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox runat="server" ID="chkMaterial" />
                        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
			</asp:datagrid>				
			</td><td valign="top" width="50%"><table style="BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				    height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				    <tr>
					    <td>&nbsp;<asp:label id="lblColor" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Colors</asp:label></td>
				    </tr>
			    </table>
                <asp:datagrid id="dgColors" runat="server" DataKeyField="MaterialCoreColorID">
                    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate">
                    </AlternatingItemStyle>
                    <ItemStyle CssClass="ItemTemplate"></ItemStyle>
                    <headerStyle Height="25px" CssClass="tableheader"></headerStyle>
                    <PagerStyle Visible="False"></PagerStyle>
                    <Columns>
                        <asp:TemplateColumn>
                            <HeaderTemplate>
                                <input type="checkbox" onclick="SelectAll(this,'chkColor')" id="chkAllColors" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <asp:CheckBox runat="server" ID="chkColor" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                    </Columns>
                </asp:datagrid>
            
                <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>

			    			        	

			    
			</td>
			</tr>
			</table>

        </form>
			
		    <script language="javascript">
		    var frm = document.Form1 ;
		    function SelectAll(checkAllBox,chkId) {
		        
		        var actVar = checkAllBox.checked ;
		        for(i=0;i< frm.length;i++) {
			        e=frm.elements[i];
			        if (e.type == 'checkbox' && e.name.indexOf(chkId) != -1)
			        e.checked= actVar ;
		        }
		    }
   		
		    </script>			
	</body>
</html>
