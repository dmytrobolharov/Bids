<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_SizeRangeGR_Edit.aspx.vb" Inherits="plmOnApp.Control_SizeRangeGR_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<HEAD>
		<title runat="server" id="PageTitle">Grades</title>
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	    <style type="text/css">
            .style1
            {
                width: 1px;
            }
        </style>
	</HEAD>
<body>
    <form id="Form1" method="post" runat="server">
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" 
                    Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:confirmedimagebutton id="btnDelete" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                <cc1:confirmedimagebutton id="btnClose" runat="server" ToolTip=""
					 Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
				                          
            </td>
            <td class="FontHead" align="right" width="75">
            </td>
            <td width="40">
            </td>
            <td>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td valign="middle">
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large"
                    Font-Names="Tahoma,Verdana"></asp:Label>
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" width="100%" border="0" style="border-bottom: orange thin solid;" >
       
        <tr>
            <td class="style1">&nbsp;</td>           
            <td>    
                <asp:Label ID="lblSizeRangeName" runat="server"></asp:Label>
                <asp:TextBox ID="txtSizeRange" runat="server" MaxLength="60" Width="150px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rvSizeRangeName" runat="server"
                    ControlToValidate="txtSizeRange" Display="Dynamic" ErrorMessage="*"></asp:RequiredFieldValidator>
             </td>
             <td width="10">&nbsp;</td>
        </tr>
         <tr>
            <td class="style1">&nbsp;</td>
            <td align="left" width="30%">                
                <asp:CheckBox ID="chkActive" runat="server" Checked="" />
                <asp:Label ID="lblActive" runat="server"></asp:Label>
            </td>
            <td align="right" width="70%"><asp:Label ID="lblLastModifiedLabel" runat="server"></asp:Label>&nbsp;</td>
        </tr>   
         <tr>
            <td class="style1">&nbsp;</td>
            <td class="style2">&nbsp;</td>
            <td>&nbsp;</td>
        </tr>       
    </table>			  
	<asp:datagrid id="DataGrid1" runat="server" DataKeyField="SizeRangeDetailId" AllowSorting="True"
	   AutoGenerateColumns="False">
		<AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
		<ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
		<HeaderStyle Height="25px" CssClass="TableHeaderRed"></HeaderStyle>
		<PagerStyle Visible="False"></PagerStyle>
		<Columns>
			<asp:TemplateColumn>
			    <HeaderTemplate >
					<input type="checkbox" id="checkAll" onClick="CheckAll(this);" runat="server" name="checkAll">
				</HeaderTemplate>
				<ItemTemplate>
					<asp:CheckBox ID="chkDelete" runat="server"></asp:CheckBox>
				</ItemTemplate>
			</asp:TemplateColumn>
		</Columns>
	</asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
												
		 <table cellspacing="0" cellpadding="0" border="0" 
            style="height: 28px; width: 100%">
            <tr class="TableHeader">
                <td valign="middle" align="center" width="10">
                    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                </td>
                <td width="50" align="right">
                    <asp:DropDownList ID="dpNewRow" runat="server" CssClass="fontHead">                      
                        <asp:ListItem Text="1" Value="1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="2" Value="2"></asp:ListItem>
                        <asp:ListItem Text="3" Value="3"></asp:ListItem>
                        <asp:ListItem Text="4" Value="4"></asp:ListItem>
                        <asp:ListItem Text="5" Value="5"></asp:ListItem>
                        <asp:ListItem Text="6" Value="6"></asp:ListItem>
                        <asp:ListItem Text="7" Value="7"></asp:ListItem>
                        <asp:ListItem Text="8" Value="8"></asp:ListItem>
                        <asp:ListItem Text="9" Value="9"></asp:ListItem>
                        <asp:ListItem Text="10" Value="10"></asp:ListItem>
                        <asp:ListItem Text="15" Value="15"></asp:ListItem>
                        <asp:ListItem Text="20" Value="20"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                
                <td width="50">
                    <cc1:ConfirmedImageButton ID="btnAdd" runat="server" 
                        Message="NONE" />
                </td>
                <td></td>
                                    

            </tr>
        </table>
				</tr>
    </table>						
								
								
		
    <br>
    </form>
    <SCRIPT language="javascript">
		var frm = document.Form1 ;
		function CheckAll( checkAllBox )
		{
		var actVar = checkAllBox.checked ;
		for(i=0;i< frm.length;i++)
		{
			e=frm.elements[i];
			if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
			e.checked= actVar ;
		}
		}
		</SCRIPT>
</body>
</html>
