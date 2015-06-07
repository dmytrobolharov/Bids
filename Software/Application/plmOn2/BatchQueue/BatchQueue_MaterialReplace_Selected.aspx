<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="BatchQueue_MaterialReplace_Selected.aspx.vb" Inherits="plmOnApp.BatchQueue_MaterialReplace_Selected" %>
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
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
 		    <table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">								           						
			    <tr vAlign="middle">
				    <td vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
				    <td>
					    <asp:imagebutton id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px" Height="0px" />
					    <cc1:confirmedimagebutton id="btnFindMaterial" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnReplaceMaterial" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnFindStyle" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnBatchQ" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
				    </td>
				    <td>&nbsp;</td>
			    </tr>
		    </table> 
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
           <asp:Panel ID="pnlSeasonYear"  runat="server"  >
                <table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
                    border="0">
                    <tr valign="middle">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
                        <td width="20"><img src="../System/Icons/icon_season.gif" /></td>
                        <td width="125" align="right" nowrap="nowrap">
                            <asp:Label runat="server" ID="Label1" class="fontHead" >Select Season / Year:</asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList  ID="ddlStyleSeasonYearID" runat="server" AutoPostBack="true" ></asp:DropDownList>
                        </td>
                    </tr>
                </table>
           </asp:Panel> 
            <table cellspacing="0" cellpadding="0" border="0" bgcolor="#ffffff">
                <tr>
                    <td valign="top">
                       <table class="TableHeader" cellSpacing="0" cellpadding="0" width="100%" border="0">
	                        <tr valign="middle">
		                        <td valign="middle" align="center" width="10" height="22"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		                        <td>Selected Material:</td>
	                        </tr>
                        </table>
                        <table cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="#ffffff">
	                        <tr>
		                        <td width="400">
			                        <asp:placeholder id="plhMaterialHeaderFrom" runat="server"></asp:placeholder></td>
	                        </tr>
                        </table>              
                    </td>

                    <td valign="top">
        		       <table class="TableHeaderGreen" cellSpacing="0" cellpadding="0" width="100%" border="0">
	                        <tr valign="middle">
		                        <td valign="middle" align="center" width="10" height="22"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		                        <td>Replace With:</td>
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
                    <td>Apply To:</td>
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
					                        <td>Selected Styles</td>
				                        </tr>
			                        </table>
			                        <table cellSpacing="0" cellpadding="0" width="100%" border="0">
				                        <tr bgColor="#ffffff">
					                        <td valign="top">        	
			                                    <asp:datagrid id="dgStyle" runat="server" DataKeyField="StyleID" AutoGenerateColumns="False" 
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
                    <td valign="top">
                        <table cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="#ffffff">
	                        <tr>
		                        <td width="300">
		                           <table class="TableHeader" cellSpacing="0" cellpadding="0" width="100%" border="0">
				                        <tr valign="middle">
					                        <td valign="middle" align="center" width="10" height="20"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					                        <td>Available Colors</td>
				                        </tr>
			                        </table>
			                        <table cellSpacing="0" cellpadding="0" width="100%" border="0">
				                        <tr bgColor="#ffffff">
					                        <td valign="top">        	
			                                    <asp:datagrid id="dgMaterialColor" runat="server" DataKeyField="MaterialColorID" AutoGenerateColumns="False" 
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
                    <td valign="top">
                        <table cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="#ffffff">
	                        <tr>
		                        <td width="300">
		                           <table class="TableHeader" cellSpacing="0" cellpadding="0" width="100%" border="0">
				                        <tr valign="middle">
					                        <td valign="middle" align="center" width="10" height="20"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					                        <td>Available Size / Treatment</td>
				                        </tr>
			                        </table>
			                        <table cellSpacing="0" cellpadding="0" width="100%" border="0">
				                        <tr bgColor="#ffffff">
					                        <td valign="top">        	
			                                    <asp:datagrid id="dgMaterialSize" runat="server" DataKeyField="MaterialSizeID" AutoGenerateColumns="False" 
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
