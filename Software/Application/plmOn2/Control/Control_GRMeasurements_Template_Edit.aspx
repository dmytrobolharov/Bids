<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Control_GRMeasurements_Template_Edit.aspx.vb" Inherits="plmOnApp.Control_GRMeasurements_Template_Edit" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
		<title>POM Template</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">	
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
		<style type="text/css">.DataGridHeader { PADDING-RIGHT: 2px; PADDING-LEFT: 2px; FONT-WEIGHT: bold; FONT-SIZE: 11px; BACKGROUND-IMAGE: url(../System/Images/table_header.gif); PADDING-BOTTOM: 2px; PADDING-TOP: 2px; BACKGROUND-REPEAT: repeat-x; FONT-FAMILY: Tahoma, Geneva, Arial, Helvetica, sans-serif;  TOP: expression(this.offsetParent.scrollTop) }
	.DataGridControl { FONT-FAMILY: Tahoma, Geneva, Arial, Helvetica, sans-serif;  TOP: expression(this.offsetParent.scrollTop); BACKGROUND-COLOR: #f5f5f5 }
		</style> 

        <style type="text/css">
            #DataGrid1 .TableHeader {background-repeat: repeat;}
            #DataGrid1 .TableHeaderGreen {background-repeat: repeat;}
            #DataGrid1 .TableHeaderRed {background-repeat: repeat;}
            #DataGrid1 .TableHeader table {
                font-size: inherit;
                font-weight: inherit;
            }
        </style>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
                        <cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					    <cc1:BWImageButton id="btnAddSizeRange" runat="server" Message="NONE"></cc1:BWImageButton>
                        <cc1:confirmedimagebutton id="imgBtnCopy" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnPDFView" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
						<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
            <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
			<table cellSpacing="2" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td width="900"><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				</tr>
			</table>
			<Table style="BORDER-TOP: orange thin solid; BORDER-bottom: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" cellSpacing="1" cellPadding="0" width="100%" border="0">
	            <tr valign="top" width="100%"> 	                                     
                    <td>
                        <asp:Label ID="lblGradingType" runat="server" ></asp:Label>
                        <asp:RadioButton ID="rbRelative" class="font" runat="server" Checked="True" 
                           GroupName="rbGradingType" Text="" />
                        <asp:RadioButton ID="rbIncremental" class="font" runat="server" GroupName="rbGradingType"/>
                    </td>
                     <td>
                        <asp:Label ID="lblMeasurements" runat="server" ></asp:Label>
                        <asp:RadioButton ID="rbMetric" runat="server"  class="font" Checked="True" GroupName="rbMeasurements"  />
                        <asp:RadioButton ID="rbImperial" runat="server" class="font" GroupName="rbMeasurements" />
                    </td>
                    <td>
                        <asp:Label ID="lblGradesLSample" runat="server" ></asp:Label>
                        <asp:RadioButton ID="rbConvert2Negative" class="font" runat="server" Checked="True" GroupName="rbGradesLSample"  />
                        <asp:RadioButton ID="rbKeepAsEntred" class="font" runat="server" GroupName="rbGradesLSample"/>
                    </td>
                </tr>                        
               <%-- <tr valign="top" width="100%">                    
                   <td>
                        <asp:Label ID="lblGradesLSample" class="fontHead" runat="server" ></asp:Label>
                        <asp:RadioButton ID="rbConvert2Negative" class="font" runat="server" Checked="True" GroupName="rbGradesLSample"  />
                        <asp:RadioButton ID="rbKeepAsEntred" class="font" runat="server" GroupName="rbGradesLSample"/>
                    </td>
                </tr>--%>
                <%--<tr valign="top" width="100%">
                   <td align="left" width="25">&nbsp;</td>    
                   <td align="left" width="100%">
                        <asp:Label ID="lblMeasurements" class="fontHead" runat="server" width="150"></asp:Label>
                        <asp:RadioButton ID="rbMetric" runat="server" class="font" Checked="True" GroupName="rbMeasurements" width="130" />
                        <asp:RadioButton ID="rbImperial" runat="server" class="font" GroupName="rbMeasurements" />
                    </td>
                </tr>--%>
            </Table>            	
			<cc2:ystabview id="YSTabView2" runat="server"></cc2:ystabview>			
			<asp:panel id="pnlTemplate" runat="server">
				<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
					<TR>
						<TD vAlign="top">
							<DIV id="div_Grid" runat="server">
								<TABLE class="ms-formlabel DataGridControl" cellSpacing="1" cellPadding="0" width="100%"
									border="0">
									<TR>
										<TD style="height: 27px">
											<cc1:bwimagebutton id="btnPOMLinked" runat="server" 
												WindowName="POMLinkLibrary"></cc1:bwimagebutton>
											<cc1:bwimagebutton id="btnPOMUnLink" runat="server" 
											    WindowName="POMUnLinkLibrary"></cc1:bwimagebutton>
											<cc1:bwimagebutton id="btnPomCritical" runat="server" 
												WindowName="POMCriticalLibrary"></cc1:bwimagebutton>
                                            <cc1:bwimagebutton id="btnWhereUsed" runat="server" 
											WindowName="POMTemplateWhereUsed"></cc1:bwimagebutton>
											<cc1:bwimagebutton id="btnPOMDelete" runat="server" 
												WindowName="POMDeleteLibrary"></cc1:bwimagebutton>
											<cc1:bwimagebutton id="btnPomLibraryTop" runat="server" 
												WindowName="POMTopLibrary"></cc1:bwimagebutton>
											<cc1:bwimagebutton id="btnPOMSort" runat="server"  WindowName="POMSortLibrary"></cc1:bwimagebutton></TD>
									</TR>
								</TABLE>								
								<asp:datagrid id="DataGrid1" runat="server" BorderColor="Silver" 
                                        BorderStyle="Solid" BorderWidth="1px"
					                        PageSize="100" AutoGenerateColumns="False" AllowPaging="true" PagerStyle-Visible="false">
					                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
					                        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
					                        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
					                        <Columns>
					                            <asp:TemplateColumn>
											        <HeaderTemplate>
												        <DIV align="center">
													        <asp:Label id="lblIsLinked" runat="server" CssClass="fontHead"><%#GetSystemText("L")%></asp:Label></DIV>
											        </HeaderTemplate>
											        <ItemTemplate>
												        <asp:Image id="imgIsLinked" runat="server" ImageUrl="../System/Icons/icon_link.gif"></asp:Image>
											        </ItemTemplate>
										        </asp:TemplateColumn>
										        <asp:TemplateColumn>
											        <HeaderTemplate>
												        <div align="center">
													        <asp:Label id="lblCritical" runat="server" CssClass="fontHead"><%#GetSystemText("C")%></asp:Label></div>
											        </HeaderTemplate>
											        <ItemTemplate>
												        <asp:Image id="imgCritical" runat="server" ImageUrl="../System/Icons/icon_warning.gif"></asp:Image>
											        </ItemTemplate>
										        </asp:TemplateColumn>
										        <asp:TemplateColumn>
											        <HeaderTemplate>
												        <div align="center">
													        <asp:Label id="lblHow2MeasText" runat="server" CssClass="fontHead"><%#GetSystemText("H")%></asp:Label></div>
											        </HeaderTemplate>
											        <ItemTemplate>
												        <cc1:BWImageButton id="imgBtnHow2MeasText" runat="server" ImageUrl="../System/Icons/icon_howto.gif" WindowName="POMLibrary"></cc1:BWImageButton>
											        </ItemTemplate>
										        </asp:TemplateColumn>
					                        </Columns>
					                </asp:datagrid>	
								</DIV>
							<TABLE cellSpacing="2" cellPadding="0" border="0">
								<TR class="fontHead">
									<TD>&nbsp;</TD>
									<TD noWrap width="85">
                                        <asp:Label ID="lblNumRows" runat="server"></asp:Label></TD>
									<TD width="35">
										<asp:dropdownlist id="dpNewRow" runat="server" CssClass="fontHead">
											<asp:ListItem Value="1" Selected="True">1</asp:ListItem>
											<asp:ListItem Value="2">2</asp:ListItem>
											<asp:ListItem Value="3">3</asp:ListItem>
											<asp:ListItem Value="4">4</asp:ListItem>
											<asp:ListItem Value="5">5</asp:ListItem>
											<asp:ListItem Value="10">10</asp:ListItem>
											<asp:ListItem Value="15">15</asp:ListItem>
											<asp:ListItem Value="20">20</asp:ListItem>
										</asp:dropdownlist></TD>
									<TD width="50">
										<cc1:confirmedimagebutton id="imgBtnAdd" runat="server" Message="NONE" ></cc1:confirmedimagebutton></TD>
									<TD width="100">
										<cc1:bwimagebutton id="btnPomLibrary" runat="server" 
											WindowName="POMLibrary"></cc1:bwimagebutton></TD>
								</TR>
							</TABLE>
						</TD>
					</TR>
				</TABLE>
			</asp:panel>
			<asp:panel id="pnlHowTo" runat="server">
				<asp:datalist id="DataList1" runat="server" BorderColor="WhiteSmoke" BorderStyle="Solid" BorderWidth="1px"
					Width="100%" BackColor="White">
					<HeaderTemplate>
						<table cellspacing="0" cellpadding="0" width="100%" border="0">
                            <tr class="Toolbar">
                                <td class="fontHead" width="75">
                                    <asp:Label ID="lblPOMCode" runat="server"><%#GetSystemText("POM")%></asp:Label>
                                </td>
                                <td class="fontHead" width="200">
                                    <asp:Label ID="lblPOMDesc" runat="server"><%#GetSystemText("Description")%>
                                    </asp:Label>
                                </td>
                                <td class="fontHead" width="200">
                                    <asp:Label ID="lblHow2MeasText" runat="server"><%#GetSystemText("How to Measure")%></asp:Label>
                                </td>
                                <td class="fontHead" width="200">
                                    <asp:Label ID="lblHow2MeasName" runat="server"><%#GetSystemText("How to Image")%></asp:Label>
                                </td>
                            </tr>
                        </table>
					</HeaderTemplate>
					<AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
					<FooterTemplate>
					</FooterTemplate>
					<ItemStyle BackColor="White"></ItemStyle>
					<ItemTemplate>
						<TABLE width="100%">
							<TR>
								<TD class="font" width="75"><%#Container.DataItem("POMCode")%></TD>
								<TD class="font" width="200"><%#Container.DataItem("POMDesc")%></TD>
								<TD class="font" width="200">
									<asp:Label Runat="server" ID="lblHow2MeasText">
										<%#Container.DataItem("How2MeasText")%>
									</asp:Label></TD>
								<TD class="font" width="200">
									<asp:Image id="imgHow2MeasName" runat="server"></asp:Image>
								</TD>
							</TR>
						</TABLE>
					</ItemTemplate>
				</asp:datalist>
			</asp:panel>
			</form>
		<script language="javascript">

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
		
		    var frm = document.Form1;
		    function CheckAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
		                e.checked = actVar;
		        }
		    }

		    function CheckDeleteAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
		                e.checked = actVar;
		        }
		    }

		    function CheckCriticalAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chkCritical") != -1)
		                e.checked = actVar;
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
