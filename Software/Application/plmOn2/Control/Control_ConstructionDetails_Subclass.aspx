<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_ConstructionDetails_Subclass.aspx.vb" Inherits="plmOnApp.Control_ConstructionDetails_Subclass" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Process Details Class</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">
		<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" height="25" border="0">
			<tr>
				<td align="center" width="10">
				    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
				</td>
				<td>
                    <asp:imagebutton id="btnInvSearch" runat="server" ImageUrl="../System/icons/1x1.gif" Width="0px"
							Height="0px" />
				    <cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnSaveAsNew" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
			        <cc1:confirmedimagebutton id="btnDelete" runat="server" Message="NONE" CausesValidation="false"></cc1:confirmedimagebutton>
				</td>
			</tr>
		</table>
		 <table class="TableHeader" style="height:25" cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td valign="middle" align="center" width="10"><img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
	            <td align="left" style="color:#666666;font-family:Tahoma,Verdana;font-size:medium;"><asp:label id="lblHeader" runat="server">test</asp:label></td>
	        </tr>
	    </table>

		
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
		
	<asp:Panel runat="server" ID="pnlHeader">		
		<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" height="25" border="0">
			<tr>
				<td align="center" width="10">
				    <img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" />
				</td>
				<td>
	                <cc1:ConfirmedImageButton ID="btmImgNewFeature" runat="server" 
                    Message="NONE" CausesValidation="False"></cc1:ConfirmedImageButton>
                    <cc1:confirmedimagebutton id="btnCopy" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
                    <cc1:confirmedimagebutton id="btnDeleteFeature" runat="server" Message="NONE" ></cc1:confirmedimagebutton>

				</td>
			</tr>
		</table>
			

    <table class="TableHeader" height="25" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
	    <tr valign="middle">
		<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		<td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
		<td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
		<td nowrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
		<td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
		<td width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></td>
		<td width="10">&nbsp;</td>
		<td nowrap><asp:label id="RecordCount" runat="server" CssClass="fontHead"></asp:label></td>
		<td class="fontHead" align="right" width="110">
        <asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></td>
		<td width="25">
		    <asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
				<asp:ListItem Value="5">5</asp:ListItem>
				<asp:ListItem Value="10">10</asp:ListItem>
				<asp:ListItem Value="15">15</asp:ListItem>
				<asp:ListItem Value="20">20</asp:ListItem>
				<asp:ListItem Value="25">25</asp:ListItem>
				<asp:ListItem Value="30">30</asp:ListItem>
				<asp:ListItem Value="40">40</asp:ListItem>
				<asp:ListItem Value="50" Selected="True">50</asp:ListItem>
			</asp:dropdownlist>
		</td>
		<td width="10"><asp:button id="btnGo" onclick="RePage" runat="server" CssClass="fontHead" ></asp:button></td>
	</tr>
</table>
    </asp:Panel>
	<table height="15" cellspacing="0" cellpadding="0" width="100%" bgColor="white" border="0">
		<tr>
			<td><asp:placeholder id="plhSearchControl" runat="server"></asp:placeholder></td>
			<td width="100%"><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
		</tr>
	</table>   
	<asp:datagrid id="DataGrid1" runat="server" AllowSorting="True" DataKeyField="Level3ID">
		<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
		<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
		<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
		<PagerStyle Visible="False"></PagerStyle>
        <Columns>
            <asp:TemplateColumn>
                <HeaderTemplate>
                    <asp:CheckBox ID="checkAll" runat="server" onclick="CheckAll(this);" />
                </HeaderTemplate>
                <ItemTemplate>
                    <asp:CheckBox ID="chbLevel3ID" runat="server" />
                </ItemTemplate>
            </asp:TemplateColumn>            
        </Columns>
	</asp:datagrid>   
    <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
     
    </form>
	<script type="text/javascript" language="javascript">
	    //var frm = document.Form1;
	    var frm = document.forms['form1'];

	    function CheckAll(checkAllBox) {
	        var actVar = checkAllBox.checked;
	        for (i = 0; i < frm.length; i++) {
	            e = frm.elements[i];
	            if (e.type == 'checkbox' && e.name.indexOf("chbLevel3ID") != -1)
	                e.checked = actVar;
	        }
	    }

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
