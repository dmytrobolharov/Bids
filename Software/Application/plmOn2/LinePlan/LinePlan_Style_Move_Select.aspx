<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_Style_Move_Select.aspx.vb" Inherits="plmOnApp.LinePlan_Style_Move_Select" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet"/>    
</head>
<body>
    <form id="form1" runat="server">

	    <table class="tableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
		    runat="server">
		    <tr vAlign="middle">
			    <td vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
			    <td>
				    <asp:ImageButton id="btnSave" runat="server" ></asp:ImageButton>
				    <asp:ImageButton id="btnClose" runat="server" ></asp:ImageButton></td>
		    </tr>
	    </table>
	    <br /><br />

	    <table >
	        <tr>
	            <td width="40">&nbsp;</td>
	            <td><asp:Label runat="server" ID="lblHeader" CssClass="fontHead" >LinePlan:</asp:Label></td>
	        </tr>
	   </table>	 
	      
	    <br /><br />
	    
    
	    <table runat="server" id="tb1">
	        <tr><td width="40">&nbsp;</td>
	        <td><table width="100%" bgColor="#ffffff" border="0" class="CodeBlockGreen">
		        <tr>
			        <td>&nbsp;</td>
			        <td><asp:label id="lblOptions" runat="server" CssClass="fontHead">select an option...</asp:label></td>
			        <td>&nbsp;</td>
		        </tr>			
		        <tr>
			        <td width="10">&nbsp;</td>
			        <td><asp:radiobuttonlist id="rbHierarchy" runat="server" CssClass="fontHead" AutoPostBack="False">
				        </asp:radiobuttonlist></td>
			        <td width="50">&nbsp;</td>
		        </tr>
    	        </table>
	        </td>
	        </tr>
	    </table>
	    <table runat="server" id="tb2">
	        <tr><td width="40">&nbsp;</td>
	        <td><table width="100%" bgColor="#ffffff" border="0" class="CodeBlockGreen">
		        <tr>
			        <td>&nbsp;</td>
			        <td><asp:label id="Label2" runat="server" CssClass="fontHead">Move from...</asp:label></td>
			        <td><asp:radiobuttonlist id="rbSeasonYear" runat="server" CssClass="fontHead" AutoPostBack="False">
				        </asp:radiobuttonlist></td>
		        </tr>			
		        </table>
		        <br />
		        <table width="100%" bgColor="#ffffff" border="0" class="CodeBlockGreen">
		        <tr>
			        <td width="10">&nbsp;</td>
			        <td><asp:label id="Label3" runat="server" CssClass="fontHead">Move To...</asp:label></td>
			        <td><asp:radiobuttonlist id="rbLinePlan" runat="server" CssClass="fontHead" AutoPostBack="False">
				        </asp:radiobuttonlist></td>
			        <td width="50">&nbsp;</td>
		        </tr>
    	        </table>
      	        
	        </td>
	        </tr>
	    </table>
	    
	    <table runat="server" id="tb3">
	        <tr><td width="40">&nbsp;</td>
	        <td><table width="100%" bgColor="#ffffff" border="0" class="CodeBlockGreen">
		        <tr>
			        <td>&nbsp;</td>
			        <td><asp:label id="lblAttribute" runat="server" CssClass="fontHead">Select an Attribute...</asp:label></td>
			        <td>&nbsp;</td>
		        </tr>			
		        <tr>
			        <td width="10">&nbsp;</td>
			        <td><asp:radiobuttonlist id="rbAttribute" runat="server" CssClass="fontHead" AutoPostBack="False">
				        </asp:radiobuttonlist></td>
			        <td width="50">&nbsp;</td>
		        </tr>
    	        </table>
	        </td>
	        </tr>
	    </table>	    

       
    </form>
</body>
</html>
