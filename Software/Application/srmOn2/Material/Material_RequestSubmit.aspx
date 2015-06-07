<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_RequestSubmit.aspx.vb" Inherits="srmOnApp.Material_RequestSubmit" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc2" TagName="Material_Header" Src="Material_Header.ascx" %>

<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
	<title runat="server" id="PageTitle">Material Request</title>
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
    <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />		
    <link href="../System/CSS/Grid.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Tree.css" rel="stylesheet" type="text/css" />    
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	<script type="text/javascript">
	    function userselect(sValueUsr, sValueDate) {
	    
	        var hiddenControl = '<%= hd_SessionName.ClientID %>';
	        var hiddenControlFlag = '<%= hd_SessionDate.ClientID %>';
	        
	        document.form1[sValueUsr].value = document.getElementById(hiddenControl).value
	        document.form1[sValueDate].value = document.getElementById(hiddenControlFlag).value	  
	    }
				
</script>
</head>
<body>
    <form id="form1" runat="server">
    
			<table class="TableHeader" cellSpacing="0" cellPadding="0" width="100%" 
                height="25" border="0">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnRemove" runat="server" Visible="false"></cc1:confirmedimagebutton>
						<cc1:BWImageButton ID="btnPreview" runat="server"></cc1:BWImageButton>
						<cc1:confirmedimagebutton id="btnClose" Visible="false" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					</td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="Silver">Material Submit</asp:label></td>
				</tr>
			</table>
			<table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr class="TableHeader">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="20"><asp:imagebutton id="imbBtnExpand" runat="server" ImageUrl="../System/Icons/icon_Next.gif" ToolTip="Show Material Header..."></asp:imagebutton><asp:imagebutton id="imgBtnCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif" ToolTip="Hide Material Header..."></asp:imagebutton></td>
					<td class="fontHead" width="400">&nbsp;
						<asp:label id="lblMaterialDetail" runat="server"></asp:label></td>
					<td valign="middle" align="left" width="125"><asp:Label ID="lblSelectColorSize" runat="server"></asp:Label></td>
					    <td>
                            <asp:DropDownList ID="ddlMaterialTradeColor" runat="server" AutoPostBack="True">
                            </asp:DropDownList>
                        </td>
                        <td align="left" valign="middle">
                            &nbsp;</td>
				</tr>
			</table>
 
			<asp:panel id="Panel1" runat="server" CssClass="font" BorderWidth="0" BackColor="#ffffff" Width="100%">
				<table height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
					<tr>
						<td width="900">
							<uc2:Material_Header id="Material_Header1" runat="server"></uc2:Material_Header></td>
					
					
						<td>&nbsp;</td>
					</tr>
				</table>
			</asp:panel>
            <asp:Panel ID="pnlSeasonYear"  runat="server" >
                <table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
                    border="0">
                    <tr valign="middle">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
                        <td width="20"><img src="../System/Icons/icon_season.gif" /></td>
                        <td nowrap="nowrap">
                            <asp:Label runat="server" ID="lblSeasonYearLabel" class="fontHead" ></asp:Label>&nbsp;
                            <asp:Label ID="lblStyleSeasonYear" runat="server"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:Panel> 	
	        <table cellspacing="0" bgcolor="White" border="0" cellpadding="0" width="100%">
                <tr>
                    <td>
                    <table cellspacing="2" cellpadding="0">
                        <tr >
                            <td valign="top" bgcolor="White"  > 
			                    <table height="26" cellSpacing="0" cellPadding="0" width="100%" border="0" bgcolor="White">
				                    <tr>
					                    <td vAlign="bottom">
						                    <cc2:YSTabView id="tabSubmit" runat="server"></cc2:YSTabView></td>
				                    </tr>
			                    </table>
			                    <table cellspacing="0" width="400" cellpadding="0" style="border: 1px solid #F0F0F0; background-color: #FFFFFF;">
			                        <tr>
			                            <td>			                            
	                                        <table cellSpacing="1" cellPadding="0" width="100%" border="0">
		                                        <tr>
			                                        <td class="fontHead"><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
		                                        </tr>
	                                        </table>                                   
	                                        <table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
		                                        <tr class="TableHeader">
			                                        <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
			                                        <td class="fontHead">&nbsp;<asp:label id="lblSubmitGrid" runat="server"></asp:label></td>
		                                        </tr>
	                                        </table>
	                                        <asp:datagrid id="dgMaterial" runat="server"
                                                DataKeyField="MaterialRequestSubmitItemID" AutoGenerateColumns="False" 
                                                 BorderWidth="1px" BorderColor="#CCCCCC" CellPadding="1" BackColor="White" >
		                                        <PagerStyle />
		                                        <AlternatingItemStyle Height="20px" CssClass="font"></AlternatingItemStyle>
		                                        <ItemStyle Height="20px" CssClass="font"></ItemStyle>
		                                        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
	                                        </asp:datagrid>				                            
			                                
			                            </td>
			                        </tr>
			                    </table> 		
                    </td>
                    <td valign="top">
                        
                    			 <table height="26" cellSpacing="0" cellPadding="0" width="100%" border="0" bgcolor="White">
				                    <tr>
					                    <td vAlign="bottom" bgcolor="White">
						                    <cc2:YSTabView id="tabComment" runat="server"></cc2:YSTabView>

                                        </td>
				                    </tr>
			                    </table> 
			            <asp:Panel ID="pnlSubmitComment" runat="server">        
                                <table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0">
                                    <tr class="TableHeader">
                                        <td vAlign="middle" align="center" width="20"></td>
                                        <td class="fontHead">
	                                        <asp:label id="lblComment" runat="server">Comments</asp:label></td>
                                    </tr>
                                </table>
                                <table cellspacing="0" width="450" cellpadding="0" style="border: 1px solid #F0F0F0; background-color: #FFFFFF;">
                                    <tr>
                                        <td height="400" align="left" valign="top">
                                            <asp:TextBox ID="txtSubmitComment" runat="server" Height="400px" Width="445px" 
                                                TextMode="MultiLine"></asp:TextBox>
                                            
                                            
                                        </td>
                                    </tr>
                                </table>                        
                        </asp:Panel>
                        <asp:Panel ID="pnlComment" runat="server">
                                <table cellspacing="0" width="450" cellpadding="0" style="border: 1px solid #F0F0F0; background-color: #FFFFFF;">
                                    <tr>
                                        <td height="400" align="left" valign="top">
                                            
                                            <asp:placeholder id="plhComments" runat="server"></asp:placeholder>
                                        </td>
                                    </tr>
                                </table>   
                        </asp:Panel>        
			            <asp:Panel ID="pnlAttachment" runat="server">
                                <table cellspacing="0" width="450" cellpadding="0" style="border: 1px solid #F0F0F0; background-color: #FFFFFF;">
                                    <tr>
                                        <td height="400" align="left" valign="top">
                                            
                                            <asp:placeholder id="plhAttachment" runat="server"></asp:placeholder>
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
    <asp:HiddenField ID="hd_SessionName" runat="server" />
    <asp:HiddenField ID="hd_SessionDate" runat="server" />
    <asp:HiddenField ID="hdnXmlFiles" runat="server" />
					
    </form>

</body>
</html>
