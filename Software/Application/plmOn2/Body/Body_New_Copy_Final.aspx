<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Body_New_Copy_Final.aspx.vb" Inherits="plmOnApp.Body_New_Copy_Final" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc2" TagName="Body_Header" Src="Body_Header.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
	<head runat="server">
		<title>Body Copy</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	</head>
	<body>
		<form id="form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSaveSet" runat="server" Message="NONE"></cc1:confirmedimagebutton>
                    <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
			<%--<table borderColor="gold" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffff99"
				border="1">
				<tr>
					<td>
						<table cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td width="10">&nbsp;</td>
								<td width="200"><asp:radiobuttonlist id="rblImage" runat="server" RepeatDirection="Horizontal" CssClass="fontHead">
										<asp:ListItem Value="L" Selected="True">Link Image</asp:ListItem>
										<asp:ListItem Value="C">Copy Image</asp:ListItem>
									</asp:radiobuttonlist></td>
								<td><asp:checkbox id="chbBodyCarryOver" runat="server" CssClass="fontRed" Font-Bold="True" Text="Carry Over?"></asp:checkbox></td>
								<td runat="server" id="tdCopies" ><asp:Label runat="server" id="lbCopies" CssClass="fontHead" >No. of Copies:</asp:Label><asp:DropDownList ID="ddlCopies" runat="server"  >
								        <asp:ListItem Value="1" Selected="True" >1</asp:ListItem>
								        <asp:ListItem Value="2">2</asp:ListItem>
								        <asp:ListItem Value="3">3</asp:ListItem>
								        <asp:ListItem Value="4">4</asp:ListItem>
								        <asp:ListItem Value="5">5</asp:ListItem>
								        <asp:ListItem Value="6">6</asp:ListItem>
								        <asp:ListItem Value="7">7</asp:ListItem>
								        <asp:ListItem Value="8">8</asp:ListItem>
								        <asp:ListItem Value="9">9</asp:ListItem>
								        <asp:ListItem Value="10">10</asp:ListItem>
								    </asp:DropDownList></td>
								<td>&nbsp;</td>
							</tr>
						</table>
						<!--
						<asp:panel id="pnlHomeClass" Runat="server">
							<table cellSpacing="0" cellpadding="0" width="100%" border="0">
								<tr>
									<td class="fontHead" width="20">&nbsp;</td>
									<td class="fontHead" width="70">&nbsp;Select Set:</td>
									<td>
										<asp:checkboxlist id="cklVariation" runat="server" CssClass="fontHead" RepeatDirection="Horizontal"
											DataValueField="StyleId" DataTextField="StyleDevelopmentName"></asp:checkboxlist></td>
								</tr>
							</table>
						</asp:panel><asp:panel id="pnlApparelClass" Runat="server">
							<table cellSpacing="0" cellpadding="0" width="100%" border="0">
								<tr>
									<td class="fontHead" width="20">&nbsp;</td>
									<td class="fontHead" width="70">&nbsp;Select Size:</td>
									<td>
										<asp:checkboxlist id="cklStyle" runat="server" CssClass="fontHead" RepeatDirection="Horizontal"></asp:checkboxlist></td>
								</tr>
							</table>
						</asp:panel>
						-->
					</td>
				</tr>
			</table>--%>
            <%--<asp:datalist id="dlVariation"
	            BorderColor="White" BorderStyle="Solid" Width="100%" 
                CssClass="font" runat="server"
	            DataKeyField="BodyID">
	            <ItemStyle></ItemStyle>
	            <ItemTemplate> 
	            <table id="tbBodyVariarion" cellspacing="0" cellpadding="0" width="100%" border="1" runat="server" bgcolor="#FFFFCC">
	            <tr>
	            <td>
					<table id="Table1" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
						<tr>
							<td class="fontHead">
                                <asp:CheckBox ID="chbBodyId" runat="server" /></td>
							<td>&nbsp;</td>
						</tr>
					</table>	
		            <TABLE>
			            <TR>
				            <TD class="font">
							    <asp:checkboxlist id="cklVariation" runat="server" CssClass="fontHead" RepeatDirection="Horizontal"></asp:checkboxlist>	
							</TD>
			            </TR> 
		            </TABLE>	            
	            
	            </td>
	            </tr>
	            </table>

        		
	            </ItemTemplate>
            </asp:datalist>--%>

			<table cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Copy Body...</asp:label></td>
				</tr>
			</table>
			<table height="100" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr valign="top">
					<td width="10">&nbsp;</td>
					<td width="900"><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
					<td><cc1:bwimagebutton id="imgDesign" runat="server"></cc1:bwimagebutton></td>
				</tr>
			</table>
		
			
		</form>
		<%--<SCRIPT language="javascript">
				var frm = document.Form1 ;
				function CheckAll1( checkAllBox )
				{
				var actVar = checkAllBox.checked ;
				for(i=0;i< frm.length;i++)
				{
					e=frm.elements[i];
					if ( e.type=='checkbox' && e.name.indexOf("cbSelected1") != -1 )
					e.checked= actVar ;
				}
				}
				function CheckAll2( checkAllBox )
				{
				var actVar = checkAllBox.checked ;
				for(i=0;i< frm.length;i++)
				{
					e=frm.elements[i];
					if ( e.type=='checkbox' && e.name.indexOf("cbSelected2") != -1 )
					e.checked= actVar ;
				}
				}
				function CheckAll3( checkAllBox )
				{
				var actVar = checkAllBox.checked ;
				for(i=0;i< frm.length;i++)
				{
					e=frm.elements[i];
					if ( e.type=='checkbox' && e.name.indexOf("cbSelected3") != -1 )
					e.checked= actVar ;
				}
				}
				function CheckAll4( checkAllBox )
				{
				var actVar = checkAllBox.checked ;
				for(i=0;i< frm.length;i++)
				{
					e=frm.elements[i];
					if ( e.type=='checkbox' && e.name.indexOf("cbSelected4") != -1 )
					e.checked= actVar ;
				}
				}
		</SCRIPT>--%>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
