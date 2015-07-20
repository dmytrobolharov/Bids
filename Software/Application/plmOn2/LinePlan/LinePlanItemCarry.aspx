<%@ Page Language="vb" AutoEventWireup="false" Codebehind="LinePlanItemCarry.aspx.vb" Inherits="plmOnApp.LinePlanItemCarry" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<HTML>
	<head>
		<title>New</title>
        <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
        <script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>	
        <script language="javascript" src="../System/Jscript/Custom.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	</head>
	<body>
		<form id="form1" runat="server">

			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><asp:imagebutton id="btnInvSearch" runat="server" Height="0px" Width="0px" 
					ImageUrl="../System/icons/1x1.gif"></asp:imagebutton><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton 
    					id="btnSave" runat="server"  Message="NONE" ></cc1:confirmedimagebutton><cc1:BWImageButton  
						id="btnAddColor" runat="server" CausesValidation="False" /><cc1:confirmedimagebutton 
					    id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
		
			<table cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server" id="tbNoCopies" bgcolor="White">
				<tr>
				    <td width="10" height="100">&nbsp;</td>
				    <td width="195">
                        <table cellSpacing="0" cellPadding="0" border="0">
                            <tr>
                                <td class="fontHead" style="font-size: 14px; color: #CC0000">
                                   <asp:Label ID="lblNumberStyle" runat="server"></asp:Label>&nbsp;</td>
                                <td>
                                    <asp:DropDownList ID="ddlNewStyle" runat="server" Font-Size="16pt" 
                                        ForeColor="#CC0000" Font-Bold="True">
                                        <asp:ListItem>1</asp:ListItem>
				                    </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </td>
					<td width="20">&nbsp;</td>
				   					
				    <td>&nbsp;</td>
					
				</tr>
			</table>
			<table height="100" cellSpacing="0" cellPadding="0" border="0" width="100%" bgcolor="White">
			    <tr vAlign="top" runat="server" id="trAttribute" >
				    <td width="10">&nbsp;</td>
					<td width="900" align="right">
					    <table border="0" width="100%" cellSpacing="0" cellPadding="0" >
					        <tr><td width="33%">&nbsp;</td>
					            <td width="33%">&nbsp;</td>
					            <td width="33%"><asp:Label ID="lblAttribute" runat="server" CssClass="fontHead"></asp:Label></td>
					    </tr></table>
					</td>
					<td>&nbsp;</td>
				</tr>
				<tr vAlign="top">
				    <td width="10">&nbsp;</td>
					<td width="900"><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td>&nbsp;</td>
				</tr>
			</table>
			
		    <table border="0" cellpadding="0" cellspacing="0" bgcolor="White" width="100%">
            <tr >
                <td width="50%">
                    <table border="0" cellpadding="0" cellspacing="0" bgcolor="White" width="100%" class="tableHeader">
                    <tr height="25px" class="tableHeader">
                        <td width="5">&nbsp;</td>
                        <td width="300"><asp:label runat="server" ID="lblColorway1" ></asp:label>&nbsp;</td>
                     </tr>
                     <tr><td align="left" valign="top"  bgcolor="White" colspan="2">
        	                <asp:datagrid id="dgColorway" runat="server" DataKeyField="ColorPaletteID" AutoGenerateColumns="False" 
                                 BorderWidth="1" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" Visible="true">
				                <PagerStyle />
				                <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
				                <ItemStyle Height="20px" CssClass="font"></ItemStyle>
				                <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				                <Columns>
				                    <asp:TemplateColumn>
				                        <HeaderTemplate>
				                            <asp:CheckBox ID="chkSelectAll" runat="server" onclick="CheckAll(this,'chkSelect')" />
				                        </HeaderTemplate>
				                        <ItemTemplate>
				                            <asp:CheckBox ID="chkSelect" runat="server" EnableViewState="true" />
				                        </ItemTemplate>
				                    </asp:TemplateColumn>
				                </Columns>
			                </asp:datagrid>				
                        </td>
                     </tr>
                    </table>
                </td>
           </tr>
           </table>
		</form>
		
	    <script language="javascript" type="text/javascript">
            var frm = document.form1;
		    function CheckAll( checkAllBox, id ){
		        var actVar = checkAllBox.checked ;
		        for(i=0;i< frm.length;i++){
			        e=frm.elements[i];
			        if ( e.type=='checkbox' && e.name.indexOf(id) != -1 )
			            e.checked= actVar ;
		        }
		    }

		    function DelCheckAll(checkAllBox, id, grp) {
		        var actVar = checkAllBox.checked ;
		        for(i=0;i< frm.length;i++){
		            e = frm.elements[i];
		            if (e.type == 'radio' && e.id.indexOf(id) != -1) {
			            e.checked= actVar ;
			            //e.disabled = !actVar ;
			        }
    		        if (e.type == 'checkbox' && e.name.indexOf(grp) != -1 && e.name != checkAllBox.name) {
			            e.checked = false;
			        }
		        }
		    }
		    
		</script>				
		<script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
