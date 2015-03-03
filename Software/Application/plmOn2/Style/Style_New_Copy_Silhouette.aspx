<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_New_Copy_Silhouette.aspx.vb" Inherits="plmOnApp.Style_New_Copy_Silhouette" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Style</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
         <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
		<script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSaveSet" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"
							CausesValidation="False"></cc1:confirmedimagebutton></td>
				</tr>
			</table>
            <table cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Copy Style...</asp:label></td>
				</tr>
			</table>
			<table borderColor="gold" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffff99"
				border="1">
				<tr>
					<td>
						<table cellSpacing="0" cellpadding="0" width="100%" border="0">
							<tr>
								<td width="10">&nbsp;</td>
								<td width="200"><asp:radiobuttonlist id="rblImage" runat="server" RepeatDirection="Horizontal" CssClass="fontHead">
										
									</asp:radiobuttonlist></td>
								<TD class="fontHead">
										 <%= GetSystemText("No. of Styles")%> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                          <asp:DropDownList runat="server" ID="NoStyles" Width="150">
                                    <asp:ListItem Value="1" Text="1" Selected="True"></asp:ListItem>
                                     <asp:ListItem Value="2" Text="2" ></asp:ListItem>
                                     <asp:ListItem Value="3" Text="3" ></asp:ListItem>
                                     <asp:ListItem Value="4" Text="4" ></asp:ListItem>
                                     <asp:ListItem Value="5" Text="5" ></asp:ListItem>
                                     <asp:ListItem Value="10" Text="10" ></asp:ListItem>
                                     <asp:ListItem Value="15" Text="15" ></asp:ListItem>
                                     <asp:ListItem Value="20" Text="20" ></asp:ListItem>
                        
                                    </asp:DropDownList>
                        
                                </TD>
								<!--<td><asp:checkbox id="chbAllColors" runat="server" CssClass="fontRed" Font-Bold="True" Text="All Colors" onclick="CheckAllColors(this)"></asp:checkbox></td>-->
								<td runat="server" id="tdCopies" style="display:none;"><asp:Label runat="server" id="lbCopies" CssClass="fontHead" >No. of Copies:</asp:Label><asp:DropDownList ID="ddlCopies" runat="server"  >
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
			</table>
            <div style="display:none;">
            <asp:datalist id="dlVariation"
	            BorderColor="White" BorderStyle="Solid" Width="100%" 
                CssClass="font" runat="server"
	            DataKeyField="StyleID">
	            <ItemStyle></ItemStyle>
	            <ItemTemplate> 
	            <table id="tbStyleVariarion" cellspacing="0" cellpadding="0" width="100%" border="1" runat="server" bgcolor="#FFFFCC">
	            <tr>
	            <td>
					<table cellspacing="0" cellpadding="0" style="padding: 0 5 0;" border="0" runat="server">
						<tr>
							<td><asp:checkbox ID="chbStyleId" runat="server" CssClass="fontHead"></asp:checkbox></td>
                            <td><asp:checkbox id="chbAllColors" runat="server" CssClass="fontRed" Font-Bold="True" Text='<%#GetSystemText("All Colors")%>' onclick="CheckAllColors1(this)"></asp:checkbox></td>
							<td>&nbsp;</td>
						</tr>
					</table>	
		            <TABLE>
			            <TR>
				            <TD class="font">
							    <asp:checkboxlist id="cklVariation" runat="server" CssClass="fontHead" RepeatDirection="Horizontal" ></asp:checkboxlist>	
							</TD>
			            </TR> 
		            </TABLE>	            
	            
	            </td>
	            </tr>
	            </table>

        		
	            </ItemTemplate>
            </asp:datalist>
            </div>
			<table height="100" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr valign="top">
					<td width="10">&nbsp;</td>
					<td width="900"><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td><cc1:bwimagebutton id="imgDesign" runat="server"></cc1:bwimagebutton></td>
				</tr>
			</table>
		
			
		</form>
		<SCRIPT language="javascript">
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
                function CheckAllColors(checkAllBox) {
                    var actVar = checkAllBox.checked;
                    for (i = 0; i < frm.length; i++) {
                        e = frm.elements[i];
                        if (e.type == 'checkbox' && e.name.indexOf("cklVariation$") != -1) {
                            var num = e.name.indexOf("cklVariation")
                            var str = e.name.substring(0, num);
                            str = str + "chbStyleId"
                            for (j = 0; j < frm.length; j++) {
                                e1 = frm.elements[j];

                                if (e1.type == 'checkbox' && e1.name.indexOf(str) != -1 && e1.checked == true)
                                    e.checked = actVar;
                            }
                        }
                    }
                }

               function CheckAllColors1(checkAllBox) {
                    var actVar = checkAllBox.checked;
                    var num = checkAllBox.id.indexOf("chbAllColors");
                    var str = checkAllBox.id.substring(0, num);
                    var str1 = "";
                    var count = 0;
                    str = str + "cklVariation_";

                    for (j = 0; j < frm.length; j++) {
                        e1 = frm.elements[j];
                        str1 = str + count;
                        if (e1.id == str1) {
                           e1.checked = actVar;
                           count++;
                          }
                        }
                    return;
                }
		</SCRIPT>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</html>
