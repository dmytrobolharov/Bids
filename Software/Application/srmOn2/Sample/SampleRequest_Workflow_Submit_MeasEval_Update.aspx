<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_MeasEval_Update.aspx.vb" Inherits="srmOnApp.SampleRequest_Workflow_Submit_MeasEval_Update" ResponseEncoding="UTF-8" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>Style</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">        
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10" style="height: 28px"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="600" style="height: 28px">
					    <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>							
					    <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"></cc1:confirmedimagebutton>	
					    <asp:CheckBox valign="top"  align="center" ID="ChbShowHide" visible="false" autopostback="true" runat="server" Text="Show Sort ID" />						
					    <asp:CheckBox valign="top"  align="center" ID="ChbFixEvalSize" runat="server" Text="Update EvalSize" />						
					</td>										
				</tr>
			</table>			
			<table borderColor="whitesmoke" cellspacing="0" cellpadding="0" width="100%" border="1">
				<tr>
					<td valign="top" width="100%" bgColor="#ffffff">					    
							<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
								<tr>
									<td valign="middle" align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
									<td><asp:label id="lblMeasHeader" runat="server">Worksheet Information</asp:label></td>
								</tr>
							</table>							
							<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder>						
					</td>
				</tr>
			</table>	
				
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top" width="450">												
						<asp:datagrid id="DataGrid1" runat="server" DataKeyField="AMLMeasPomID" EnableViewState="False" OnItemDataBound="ItemDataBoundEventHandler" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
							PageSize="100"  Width="300px">
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
                                <asp:TemplateColumn HeaderStyle-CssClass="TableHeaderRed" ItemStyle-CssClass="TableHeaderRed" HeaderStyle-BorderWidth="0" ItemStyle-BorderWidth="0">
                                    <HeaderTemplate >
                                        <input type="checkbox" onclick="SelectAll(this)" id="chkSelectAll" />
                                    </HeaderTemplate>                        
                                </asp:TemplateColumn>
                            </Columns>					
						</asp:datagrid>
						<table cellspacing="2" cellpadding="0" width="550" border="0">
							<tr class="fontHead">
								<td width="10" style="height: 24px">&nbsp;</td>
								<td noWrap width="85" style="height: 24px"><asp:Label id="lblNoofRows" runat="server">No. of Row(s)</asp:Label>:</td>
								<td width="35" style="height: 24px"><asp:dropdownlist id="dpNewRow" runat="server" CssClass="fontHead">
										<asp:ListItem Value="1" Selected="True">1</asp:ListItem>
										<asp:ListItem Value="2">2</asp:ListItem>
										<asp:ListItem Value="3">3</asp:ListItem>
										<asp:ListItem Value="4">4</asp:ListItem>
										<asp:ListItem Value="5">5</asp:ListItem>
										<asp:ListItem Value="10">10</asp:ListItem>
										<asp:ListItem Value="15">15</asp:ListItem>
										<asp:ListItem Value="20">20</asp:ListItem>
									</asp:dropdownlist></td>
								<td style="width: 400px; height: 24px">
								<cc1:confirmedimagebutton id="imgBtnAdd" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
								<cc1:confirmedimagebutton id="imgBtnRemove" runat="server" Message="NONE"></cc1:confirmedimagebutton>
								<cc1:confirmedimagebutton id="imgBtnLibrary" runat="server" Message="NONE"></cc1:confirmedimagebutton>
								</td>   
							</tr>
						</table>
					</td>					
				</tr>
			</table>
		</form>		
		<table id="Table3" height="24" cellspacing="0" cellpadding="0" width="100%" border="0"
			runat="server">
			<tr valign="middle">
				<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></td>
				<td class="TableBar" valign="middle" align="center" width="20"><IMG src="../System/icons/icon_changeobject.gif"></td>
				<td class="TableBar"><asp:label id="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:label>&nbsp;/
					<asp:label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:label></td>
				<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></td>
			</tr>
		</table>
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
		            //case 13: //Enter
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

		    function SelectAll(checkAllBox) {
		        var frm = document.Form1;
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chbAMLMeasPOMId") != -1)
		                e.checked = actVar;
		        }
		    }
		    
		</script>
	</body>
</html>
