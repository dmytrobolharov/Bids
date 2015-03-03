<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_CompanyTolerance_Edit.aspx.vb" Inherits="plmOnApp.Control_CompanyTolerance_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
	<HEAD>
		<title runat="server" id="PageTitle">Tolerance</title>
        <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<TABLE class="TableHeader" id="TableHeader" cellSpacing="0" cellPadding="0" width="100%"
				border="0" runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><cc1:confirmedimagebutton id="btnSave" runat="server" ToolTip="Save..." 
							Message="NONE"></cc1:confirmedimagebutton>						
						<cc1:confirmedimagebutton id="btnClose" runat="server" ToolTip="" OnClientClick="return btnClose_Click()"
							 Message="NONE"></cc1:confirmedimagebutton>
					</TD>
				</TR>
			</TABLE>
			<TABLE style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<TBODY>
				    <tr>				        
                        <td valign="middle">
                            &nbsp;<asp:Label ID="lblCompany" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                                ForeColor="#E0E0E0"></asp:Label>
                        </td>                        
                    </tr>					       
				</TBODY>
			</TABLE>
			
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
	            <tr valign="top">
		            <td>
			            <table  class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
				            border="0">
				            <tr valign="middle">
					            <td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					            <td class="fontHead" width="10">&nbsp;</td>
					            <td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
					            <td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
					            <td nowrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
					            <td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
					            <td width="20"><asp:imagebutton id="btnImgLast" runat="server"></asp:imagebutton></td>
					            <td width="10">&nbsp;</td>
					            <td width="125"><asp:label id="RecordCount" runat="server" CssClass="fontHead"></asp:label></td>				
					            <td class = "fontHead"  align="right" width="110"><asp:Label ID="lblRecordsperPage" runat="server" Visible="true" Text="Records per Page:"></asp:Label></td>
					            <td width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
							            <asp:ListItem Value="5">5</asp:ListItem>
							            <asp:ListItem Value="10">10</asp:ListItem>
							            <asp:ListItem Value="15">15</asp:ListItem>
							            <asp:ListItem Value="20">20</asp:ListItem>
							            <asp:ListItem Value="25">25</asp:ListItem>
							            <asp:ListItem Value="30">30</asp:ListItem>
							            <asp:ListItem Value="40">40</asp:ListItem>
							            <asp:ListItem Value="50" Selected="true">50</asp:ListItem>
							            <asp:ListItem Value="75">75</asp:ListItem>
							            <asp:ListItem Value="100">100</asp:ListItem>
						            </asp:dropdownlist></td>
					            <td width="10"><asp:button id="btnRepage" runat="server" CssClass="fontHead" Text="GO"></asp:button></td>
					            <td>&nbsp;</td>
				            </tr>
			            </table>
			  </td></tr></table>
			  <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
				<tr>
					<td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>
					<td width="100%" valign="top">
						<table height="45">
							<tr>
								<td>
									<asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>           
			<table cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td>
					<asp:datagrid id="DataGrid1" runat="server"  EnableViewState="True" 
                            DataKeyField="ToleranceGuidId">
                            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate" />
                            <ItemStyle Height="20px" CssClass="ItemTemplate" />
                            <headerStyle Height="25px" CssClass="TableHeader"></headerStyle>
                            <PagerStyle Visible="False"></PagerStyle>
                            
                        </asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
					</td>
				</tr>
				<TR class="fontHead">
					<TD width="50" align ="left">
						<cc1:BWImageButton id="imgBtnAdd" runat="server" Message="NONE" ></cc1:BWImageButton></td>
					</TR>
			</table>
			
			
                     
		
		</form>
		<script type="text/javascript">
		    if (window.document.addEventListener) {
		        window.document.addEventListener("keydown", avoidInvalidKeyStorkes, false);
		    } else {
		        window.document.attachEvent("onkeydown", avoidInvalidKeyStorkes);
		        //alert(Event.KEYDOWN);
		        //window.document.captureEvents(Event.KEYDOWN);
		    }

		    function avoidInvalidKeyStorkes(evtArg) {

		        var evt = (document.all ? window.event : evtArg);
		        var isIE = (document.all ? true : false);
		        var KEYCODE = (document.all ? window.event.keyCode : evtArg.which);

		        var element = (document.all ? window.event.srcElement : evtArg.target);
		        var msg = "We have disabled this key: " + KEYCODE;

		        switch (KEYCODE) {
		            case 13: //Enter
		            case 112: //F1
		            case 113: //F2
		            case 114: //F3
		            case 115: //F4
		            case 116: //F5
		            case 117: //F6
		            case 118: //F7
		            case 119: //F8
		            case 120: //F9
		            case 121: //F10
		            case 122: //F11
		            case 123: //F12
		            case 27: //ESCAPE
		                if (isIE) {
		                    if (KEYCODE == "112") {

		                        document.onhelp = function() { return (false); }
		                        window.onhelp = function() { return (false); }
		                    }

		                    evt.returnValue = false;
		                    evt.keyCode = 0;
		                    //window.status = msg;
		                } else {
		                    evt.preventDefault();
		                    evt.stopPropagation();
		                    //alert(msg);
		                }
		                break;
		            default:
		                window.status = "";
		                //window.status = "Done";
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
