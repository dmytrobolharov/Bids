<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_MeasBeforeTreat.aspx.vb" Inherits="plmOnApp.Style.Measurements.Style_MeasBeforeTreat" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc4" TagName="Style_FabricGrid" Src="Style_FabricGrid.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title runat="server" id="tName">View Before Treatment</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
	<form id="Form1" method="post" runat="server">		    
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></td>
					<td></td>
				</tr>
			</table>
        <table>
            <tr>
                <td height="3"></td>
            </tr>
        </table>            			
		<cc2:ystabview id="YSTabView2" runat="server"></cc2:ystabview>			     			

        <asp:Panel runat="server" ID="pnlContent" Visible="true">
	        <table cellspacing="0" cellpadding="0" width="100%" border="0">	
                <tr>
                <td valign="top" width="50%">
		            <table cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
			            <tr valign="top">
				            <td>	
        					
                        <asp:datagrid id="DataGrid1" runat="server" BorderColor="Silver" 
                                BorderStyle="Solid" BorderWidth="1px"
				                    AutoGenerateColumns="False" AllowPaging="true">
				                    <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
				                    <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
				                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle></asp:datagrid>		
				                    <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>

		                    </td>	 		        
	                    </tr>  
	                </table>
	            </td>
	           </tr>
	        </table>	
        </asp:Panel>
	    <asp:Panel runat="server" ID="pnlPerm" Visible="false">
            <table style="height:50;" cellspacing="0" cellpadding="0" width="100%"  bgColor="#990000" border="1" borderColor="red">
                <tr>
                    <td>
                        <table style="height:25;" cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr>
                                <td width="25"><div align="center"><asp:image id="imgWorkStatus" ImageUrl="../System/Icons/icon_lock.gif" runat="server"></asp:image></div></td>
                                <td>
                                      <asp:Label ID="lblPerm" runat="server" 
                                    Text="You might not have permission to access this tab using your credentials." 
                                    CssClass="fontHead" ForeColor="White"></asp:Label>                         
                                
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </asp:Panel>

	</form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
