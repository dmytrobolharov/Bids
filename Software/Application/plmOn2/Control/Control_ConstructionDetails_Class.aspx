<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_ConstructionDetails_Class.aspx.vb" Inherits="plmOnApp.Control_ConstructionDetails_Class" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Process Details Class</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>

</head>
<body>
    <form id="form1" runat="server">
		<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" height="25" border="0">
			<tr>
				<td align="center" width="10">
				    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
				</td>
				<td>
				    <cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnSaveAsNew" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnAddSubclass" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnDelete" runat="server" Message="NONE" CausesValidation="false"></cc1:confirmedimagebutton>
				</td>
			</tr>
		</table>

		
		<table runat="server" id="tblHeader" visible="false" class="TableHeader" style="height:25" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td valign="middle" align="center" width="10"><img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
	            <td align="left" style="color:#666666;font-family:Tahoma,Verdana;font-size:medium;"><asp:label id="lblHeader" runat="server">test</asp:label></td>
	        </tr>
	    </table>
	    <br /><br />
		
		<table cellspacing="2" cellpadding="0" width="100%" border="0">
			<tr>
				<td>
				    &nbsp;&nbsp;
				</td>		
		        <td>
		            <table cellspacing="2" cellpadding="0" width="100%" border="0">
			            <tr>
				            <td>
				                <asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder>
				                <asp:HiddenField runat="server" ID="hdnActive" />
				            </td>
			            </tr>
			            <tr>
				            <td align="left" >
				                <asp:Panel runat="server" ID="pnlRestoreAll">
                                     <table cellspacing="2" cellpadding="0" width="200px" border="0">
			                            <tr>
				                            <td align="left" >
				                                <asp:Label ID="lblRestoreAll" runat="server" CssClass="fontHead">Restore All Related Records:</asp:Label>
				                            </td>
				                            <td align="left">
				                                <asp:CheckBox runat="server" ID="chbRestoreAll" />
				                            </td>
			                            </tr>	
                                    </table>
                                </asp:Panel>
				            </td>
			            </tr>			            
		            </table>		        
		        </td>
		    </tr>
		 </table>
		
    </form>
   	<script type="text/javascript" language="javascript">
	    //var frm = document.Form1;
   	    var frm = document.forms['form1'];
   	    objRestoreAll = document.getElementById('chbRestoreAll')
   	    if (objRestoreAll != null) {
   	        objRestoreAll.disabled = true;
   	    }
        function EnableRestoreAll(obj) {
            var actVar = obj.checked;
            if (objRestoreAll != null) {
                if (actVar == true) {
                    objRestoreAll.disabled = false;
                }
                else {
                    objRestoreAll.checked = false;
                    objRestoreAll.disabled = true;
                }
            }
        }

	</script> 
    
    
    
</body>
</html>
