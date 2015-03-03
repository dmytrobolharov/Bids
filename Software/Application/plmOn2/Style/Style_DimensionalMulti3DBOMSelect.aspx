<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_DimensionalMulti3DBOMSelect.aspx.vb" Inherits="plmOnApp.Style.DimensionalBOM.Style_DimensionalMulti3DBOMSelect" %>
<%@ Register src="../System/Control/WaitControl.ascx" tagname="Color_Wait" tagprefix="wc1" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Select Dim Values</title>
		<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">	
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet"/>	
		<link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
		<script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
		<script language="javascript" type="text/javascript">

//		    if (window.screen) {
//		        var aw = screen.availWidth;
//		        var ah = screen.availHeight;
//		        window.moveTo(0, 0);
//		        window.resizeTo(aw, ah);
//		    }
		    
      </script>
			

	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
        <wc1:Color_Wait ID="Color_Wait" runat="server" />
			<table class="TableHeader" id="toolbar" style="display: none" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" visible="false" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>					
				</tr>
			</table>	
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="30" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td valign="middle">
					    <asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="Medium" ForeColor="#E0E0E0"></asp:label>
					</td>					
				</tr>
			</table>																
			<asp:Panel ID="pnlQuantity"  runat="server" >	
			    <table class="TableHeader" height="30" cellSpacing="0" cellpadding="0" width="100%" border="0">
			        <tr>                                           
                        <td>
                            <cc1:confirmedimagebutton id="btnQty" runat="server" Message="NONE"></cc1:confirmedimagebutton>&nbsp;&nbsp;
                            <cc1:confirmedimagebutton id="btnQtyClearAll" visible="false" runat="server"></cc1:confirmedimagebutton>&nbsp;&nbsp;
                            <asp:label id="lblQtyApply" runat="server" CssClass="fontHead"></asp:label>&nbsp;
                            <asp:textbox id="txtApplyQty" runat="server" width='50' CssClass="fontHead"></asp:textbox>&nbsp;
                            <cc1:confirmedimagebutton id="btnQtyApplyAll" runat="server"></cc1:confirmedimagebutton>&nbsp;&nbsp;
                            <cc1:BWImageButton ID="btnChangeLog" runat="server" CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:BWImageButton>
                            <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton> 
                        </td>
                    </tr>                    
			    </table>			    			    			    			    
		       <asp:datagrid id="dgMaterial" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" Width="100%" datakeyfield="StyleMaterialID"  AutoGenerateColumns="false">
                <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                <ItemStyle Height="20px"  CssClass="ItemTemplate"></ItemStyle>
                <HeaderStyle Height="25px"  CssClass="TableHeader"></HeaderStyle>                                                         		
              </asp:datagrid>              	             			                  						    		          				
			</asp:Panel>							
		</form>		
	</body>

    <script type='text/javascript'>

            function selectAllCheckboxesInTable(sender) {
                var checkboxesList = $(sender).closest('table').find(":checkbox").each(function () {
                    this.checked = sender.checked;
                });
            }

    </script>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</html>
