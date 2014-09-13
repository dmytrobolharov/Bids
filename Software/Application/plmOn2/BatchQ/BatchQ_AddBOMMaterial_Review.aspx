<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BatchQ_AddBOMMaterial_Review.aspx.vb" Inherits="plmOnApp.BatchQ_AddBOMMaterial_Review" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />
        <asp:placeholder id="phNav" runat="server"></asp:placeholder>
        
        <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
	        runat="server">
	        <TR valign="middle">
		        <td valign="middle" align="center" width="10" height="27">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
		        <td><cc1:confirmedimagebutton 
		            id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
		            id="btnExecute" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
		            id="btnClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
		        <td width="75">&nbsp;</td>
		        <td>&nbsp;</td>
	        </TR>
        </table> 
        
        
        <asp:placeholder id="phSeason" runat="server"></asp:placeholder>  
        <table id="Table1" class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0"
            runat="server">
            <tr valign="middle">
                <td valign="middle" align="center" width="10" height="27">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                </td>
                <td><asp:Label runat="server" ID="Label2"><%= Me.GetSystemText("Selected Material")%></asp:Label></td>
            </tr>
        </table>         
		<table height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">		
			<tr>
				<td width="900"><asp:placeholder id="plhXMLForm" runat="server" EnableViewState="False"></asp:placeholder></td>
				<td>&nbsp;</td>
			</tr>			
		</table>       
        
    <telerik:RadSplitter ID="RadSplitter1" runat="server" Height="800" Width="100%">     
    <telerik:RadPane ID="LeftPane" runat="server" with="50%" Index="0" Skin="" >        

                <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0"
	                runat="server">
	                <tr valign="middle">
		                <td valign="middle" align="center" width="10" height="27">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                        </td>
		                <td><asp:Label runat="server" ID="Label1"><%= Me.GetSystemText("Selected Styles")%></asp:Label></td>
	                </tr>
                </table> 
                <asp:datagrid id="DataGrid1" runat="server" AllowSorting="false" DataKeyField="StyleID">
				    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
					<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
					<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
					<PagerStyle Visible="False"></PagerStyle>
				</asp:datagrid><asp:label id="SortOrder1" runat="server" Visible="False"></asp:label>            
            
    </telerik:RadPane>                    
    <telerik:RadSplitBar ID="RadSplitbar1" runat="server" CollapseMode="Both" 
            EnableResize="True" Width="20px"></telerik:RadSplitBar>
    <telerik:RadPane ID="RightPane" runat="server" Width="50%">            
    
                <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0"
	                runat="server">
	                <tr valign="middle">
		                <td valign="middle" align="center" width="10" height="27">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
                        </td>
		                <td><asp:Label runat="server" ID="lblColorsHdr"><%= Me.GetSystemText("Available colors")%></asp:Label></td>
	                </tr>
                </table> 
                <asp:datagrid id="DataGrid2" runat="server" AllowSorting="false" DataKeyField="StyleMaterialColorID">
				    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
					<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
					<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
					<PagerStyle Visible="False"></PagerStyle>
				</asp:datagrid><asp:label id="SortOrderColor" runat="server" Visible="False"></asp:label>            

    </telerik:RadPane>                
    </telerik:RadSplitter>				
    
    
    
    </div>
    </form>
</body>
</html>
