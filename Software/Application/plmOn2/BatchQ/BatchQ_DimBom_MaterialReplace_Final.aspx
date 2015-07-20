<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BatchQ_DimBom_MaterialReplace_Final.aspx.vb" Inherits="plmOnApp.BatchQ_DimBom_MaterialReplace_Final" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
	<title>Material Find Replace</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
            <asp:placeholder id="phNav" runat="server"></asp:placeholder>  
            <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
	            <TR valign="middle">
		            <td valign="middle" align="center" width="10" height="27">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
		            <td ><cc1:confirmedimagebutton 
    		            id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
	    	            id="btnExecute" runat="server" Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
	    	            id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton ></td>
		            <td width="75">&nbsp;</td>
		            <td>&nbsp;</td>
	            </TR>
            </table>  
            <asp:placeholder id="phSeason" runat="server"></asp:placeholder>
            <table cellspacing="0" cellpadding="0" border="0" bgcolor="#ffffff">
                <tr>
                    <td valign="top">
                       <table class="TableHeader" cellSpacing="0" cellpadding="0" width="100%" border="0">
	                        <tr valign="middle">
		                        <td valign="middle" align="center" width="10" height="22"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		                        <td><%=Me.GetSystemText("Selected Material:")%>?</td>
	                        </tr>
                        </table>
                        <table cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="#ffffff">
	                        <tr>
		                        <td width="400">
			                        <asp:placeholder id="plhXMLForm" runat="server"></asp:placeholder></td>
	                        </tr>
                        </table>              
                    </td>

                    <td valign="top">
        		       <table class="TableHeaderGreen" cellSpacing="0" cellpadding="0" width="100%" border="0">
	                        <tr valign="middle">
		                        <td valign="middle" align="center" width="10" height="22"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		                        <td><%= Me.GetSystemText("Replace With:")%></td>
	                        </tr>
                        </table>                    
                        <table cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="#ffffff">
	                        <tr>
		                        <td width="400">
			                        <asp:placeholder id="plhMaterialHeaderTo" runat="server"></asp:placeholder></td>
	                        </tr>
                        </table>        
                    </td>
                    <td></td>
                </tr>
            </table>	
            <br />
           <table class="TableHeaderGreen" cellSpacing="0" cellpadding="0" width="100%" border="0">
                <tr valign="middle">
                    <td valign="middle" align="center" width="10" height="20"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                    <td><%=Me.GetSystemText("Apply To:")%></td>
                </tr>
            </table>
            <table>
                <tr>
                    <td valign="top">
                        <table cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="#ffffff">
	                        <tr>
		                        <td width="400">
		                           <table class="TableHeader" cellSpacing="0" cellpadding="0" width="100%" border="0">
				                        <tr valign="middle">
					                        <td valign="middle" align="center" width="10" height="20"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					                        <td><%=Me.GetSystemText("Selected Styles")%></td>
				                        </tr>
			                        </table>
			                        <table cellSpacing="0" cellpadding="0" width="100%" border="0">
				                        <tr bgColor="#ffffff">
					                        <td valign="top">        	
			                                    <asp:datagrid id="DataGrid1" runat="server" DataKeyField="StyleID" AutoGenerateColumns="False" 
                                                     BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" 
                                                    Visible="true" PageSize="50">
				                                    <PagerStyle />
				                                    <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				                                    <ItemStyle Height="20px" CssClass="font"></ItemStyle>
				                                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
			                                    </asp:datagrid><asp:label id="SortOrder1" runat="server" Visible="False"></asp:label>	
			                                </td>
					                        <td valign="top">&nbsp;</td>
				                        </tr>
			                        </table>
		                        </td>
	                        </tr>
                        </table>              
                    </td>
                    <td valign="top">
                        <table cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="#ffffff">
	                        <tr>
		                        <td width="300">
		                           <table class="TableHeader" cellSpacing="0" cellpadding="0" width="100%" border="0">
				                        <tr valign="middle">
					                        <td valign="middle" align="center" width="10" height="20"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					                        <td ><%=Me.GetSystemText("Available Colors")%></td>
				                        </tr>
			                        </table>
			                        <table cellSpacing="0" cellpadding="0" width="100%" border="0">
				                        <tr bgColor="#ffffff">
					                        <td valign="top">        	
			                                    <asp:datagrid id="DataGrid2" runat="server" DataKeyField="StyleMaterialColorID" AutoGenerateColumns="False" 
                                                     BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" Visible="true">
				                                    <PagerStyle />
				                                    <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				                                    <ItemStyle Height="20px" CssClass="font"></ItemStyle>
				                                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
			                                    </asp:datagrid><asp:label id="SortOrderColor" runat="server" Visible="False"></asp:label> 	
			                                </td>
					                        <td valign="top">&nbsp;</td>
				                        </tr>
			                        </table>
		                        </td>
	                        </tr>
                        </table>              
                    </td>
                    <td valign="top">
                        <table cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="#ffffff">
	                        <tr>
		                        <td width="300">
		                           <table class="TableHeader" cellSpacing="0" cellpadding="0" width="100%" border="0">
				                        <tr valign="middle">
					                        <td valign="middle" align="center" width="10" height="20"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					                        <td><%= Me.GetSystemText("Available Size / Treatment")%></td>
				                        </tr>
			                        </table>
			                        <table cellSpacing="0" cellpadding="0" width="100%" border="0">
				                        <tr bgColor="#ffffff">
					                        <td valign="top">        	
			                                    <asp:datagrid id="DataGrid3" runat="server" DataKeyField="StyleMaterialSizeID" AutoGenerateColumns="False" 
                                                     BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" Visible="true">
				                                    <PagerStyle />
				                                    <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				                                    <ItemStyle Height="20px" CssClass="font"></ItemStyle>
				                                    <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
			                                    </asp:datagrid>	
			                                </td>
					                        <td valign="top">&nbsp;</td>
				                        </tr>
			                        </table>
		                        </td>
	                        </tr>
                        </table>                 
                    </td>
                    <td></td>
                </tr>
            </table>
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
