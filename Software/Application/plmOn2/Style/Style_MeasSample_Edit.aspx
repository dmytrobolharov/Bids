<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_MeasSample_Edit.aspx.vb" Inherits="plmOnApp.Style.Measurements.Style_MeasSample_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Workflow_Edit" Src="Style_Workflow_Edit.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="uc4" TagName="Style_FabricGrid" Src="Style_FabricGrid.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Style</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />                
	</head>
	<body>
		<form id="Form1" method="post" runat="server" >
		    <asp:panel id="Panel1" runat="server" defaultbutton="btnSave">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="400"><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnSamplesize" runat="server" Message="Are you sure you want to change sample size?"
							 Visible="False" ToolTip="Change Sample Size..."></cc1:confirmedimagebutton>
                             <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
                        <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75">&nbsp;<asp:label id="lblSelectSet" runat="server" CssClass="fontHead">Select Set:</asp:label></td>
					<td width="40"><asp:dropdownlist id="dpStyleSet" runat="server" AutoPostBack="true" DataValueField="ID" DataTextField="Value"
							CssClass="font"></asp:dropdownlist></td>
					<td><asp:imagebutton id="imgBtnGo" runat="server" ImageUrl="../System/Icons/icon_go.gif"></asp:imagebutton>
                        </td>
				</tr>
			</table>
			</asp:panel>
			<uc2:style_workflow_edit id="Style_Workflow_Edit1" runat="server"></uc2:style_workflow_edit>
			<asp:panel id="pnlChange" runat="server">
                <uc1:Style_Change_Alert id="Style_Change_Alert1" runat="server"></uc1:Style_Change_Alert>				
			</asp:panel>
			<asp:panel id="Panel2" runat="server">
			<uc2:style_header id="Style_Header1" runat="server" StyleID='<%Request("SID")%>'></uc2:style_header>
			</asp:panel>
			<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>
			<uc4:Style_FabricGrid ID="Style_FabricGrid1" runat="server" IsReadOnly="false" />
			<br />
			<asp:panel id="Panel3" runat="server">		
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top" width="300">
					
					<asp:datagrid id="DataGrid1" runat="server" DataKeyField="AMLMeasPOMId" AllowSorting="False" BorderColor="Silver" 
                        BorderStyle="Solid" BorderWidth="1px" AutoGenerateColumns="False" OnItemDataBound="ItemDataBoundEventHandler" >
					        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
					        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
					        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
					        
					  </asp:datagrid>	
					
				<%--	<asp:datagrid id="DataGrid1" runat="server" DataKeyField="AMLMeasPOMId" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
							PageSize="100" AutoGenerateColumns="False" OnItemDataBound="ItemDataBoundEventHandler" Width="100%">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>		
							    <asp:TemplateColumn>
									<HeaderTemplate>										
											<asp:Label id="lblHeaderPOMRow" style="display:none" Width="0px" runat="server"></asp:Label>										
									</HeaderTemplate>
									<ItemTemplate>																					
											<asp:Label id="lblPOMRow" style="display:none" runat="server" Width="0px" ></asp:Label>										
									</ItemTemplate>
								</asp:TemplateColumn>						
								<asp:TemplateColumn>
									<HeaderTemplate>										
											<asp:Label id="lblHeaderPOM" runat="server">POM</asp:Label>										
									</HeaderTemplate>
									<ItemTemplate>																					
											<asp:Label id="lblRefcode" runat="server" ></asp:Label>										
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>
									<HeaderTemplate>									    
										<asp:Label id="lblHeaderPointMeasur" runat="server">Description</asp:Label>									    
									</HeaderTemplate>
									<ItemTemplate>									    
										<asp:Label id="lblDescription"  runat="Server"></asp:Label>										
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>									
									<HeaderTemplate>										
											<asp:Label id="lblHeaderTOL" runat="server">+Tol</asp:Label>
									</HeaderTemplate>
									<ItemTemplate>										
											<asp:Label id="lblTolPlus"  runat="server" Columns="5" MaxLength="10"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>
								<asp:TemplateColumn>									
									<HeaderTemplate>										
											<asp:Label id="lblHeaderTOLN" runat="server">-Tol</asp:Label>
									</HeaderTemplate>
									<ItemTemplate>										
											<asp:Label id="lblTolMinus" Width="100px" runat="server" Columns="5" MaxLength="10"></asp:Label>
									</ItemTemplate>
								</asp:TemplateColumn>								
								<asp:TemplateColumn>
								    <HeaderStyle CssClass="TableHeaderGreen"></HeaderStyle>
								    <ItemStyle CssClass="TableHeaderGreen"></ItemStyle>
									<HeaderTemplate>										
											<asp:Label id="lblSampleHeader" runat="server" />
									</HeaderTemplate>
									<ItemTemplate>										
											<asp:TextBox id="txtIncr" runat="Server" Width="50px" BorderWidth="1px" BorderStyle="Solid" BorderColor="#E0E0E0"
												MaxLength="10" columns="5"></asp:TextBox>
									</ItemTemplate>
								</asp:TemplateColumn>								
							</Columns>
						</asp:datagrid>--%>
						</td>
				</tr>
			</table>
			</asp:panel>
			<asp:panel id="Panel4" runat="server">		
		        <table id="Table5" height="24" cellspacing="0" cellpadding="0" width="100%" border="0"
			        runat="server">
			        <tr valign="middle">
				        <td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></td>
				        <td class="TableBar" valign="middle" align="center" width="20"><IMG src="../System/icons/icon_changeobject.gif"></td>
				        <td class="TableBar"><asp:label id="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:label>&nbsp;/
					        <asp:label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:label></td>
				        <td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></td>
			        </tr>
		        </table>
		    </asp:panel>
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





	</body>
</html>
