<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow_Edit" Src="Style_Workflow_Edit.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_DevelopmentMeas_Edit.aspx.vb" Inherits="plmOnApp.Style.Measurements.Style_DevelopmentMeas_Edit" ResponseEncoding="UTF-8" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc3" TagName="Style_WorkflowItem" Src="Style_WorkFlowItem.ascx" %>
<%@ Register TagPrefix="uc4" TagName="Style_FabricGrid" Src="Style_FabricGrid.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
	<head>
		<title>Style</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	    <link href="../System/CSS/jquery-ui.css" rel="stylesheet" type="text/css" />

        <style type="text/css">
            #DataGrid1 .TableHeader {background-repeat: repeat;}
            #DataGrid1 .TableHeaderGreen {background-repeat: repeat;}
            #DataGrid1 .TableHeaderRed {background-repeat: repeat;}
            #DataGrid1 .TableHeader table {
                font-size: inherit;
                font-weight: inherit;
            }
        </style>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10" style="height: 28px"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td width="600" style="height: 28px"><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="imgBtnCopy" visible=false runat="server" Message="Are you sure you want to copy from style spec ?"
							></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnSamplesize" runat="server" visible=false Message="NONE" 
							ToolTip="Change Sample Size..."></cc1:confirmedimagebutton><cc1:bwimagebutton id="btnSizeRange" runat="server" visible=false ToolTip="Change Size Range..."
							WindowName="Sizerange"></cc1:bwimagebutton><cc1:confirmedimagebutton id="btnGradeRules"  runat="server" visible=false Message="NONE" ></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnEditSample" runat="server" visible="false" Message="NONE" ></cc1:confirmedimagebutton>							
							<cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                            <cc1:confirmedimagebutton id="btnUnLinkWorkflowItem" OnClientClick="return MeasUnLinkConfirm();" runat="server"  Message="NONE" Visible="false"></cc1:confirmedimagebutton>
                            <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>
							<asp:CheckBox valign="top" align="center" ID="ChbShowHide" autopostback="true" runat="server" Text="Show Sort ID" />						
					</td>					
					<td class="FontHead" align="right" width="75" style="height: 28px"><!--&nbsp;<asp:Label id="lblSelectSet" runat="server" >Select Set:</asp:Label>--></td>
					<td width="40" style="height: 28px"><!--<asp:dropdownlist id="dpStyleSet" runat="server" AutoPostBack="true" DataValueField="ID" DataTextField="Value"
							CssClass="font"></asp:dropdownlist>--></td>
					<td style="height: 28px"><!--<asp:imagebutton id="imgBtnGo" runat="server" ImageUrl="../System/Icons/icon_go.gif"></asp:imagebutton>--></td>
				</tr>
			</table>
			<uc1:style_workflow_edit id="Style_Workflow_Edit1" runat="server"></uc1:style_workflow_edit><asp:panel id="pnlChange" runat="server">
				<uc1:Style_Change_Alert id="Style_Change_Alert1" runat="server"></uc1:Style_Change_Alert>
			</asp:panel><uc2:style_header id="Style_Header1" runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>
			<uc4:Style_FabricGrid ID="Style_FabricGrid1" runat="server" IsReadOnly="false" />
			<uc3:Style_WorkflowItem id="Style_WorkflowItem1" runat="server" />					
			<table borderColor="whitesmoke" cellspacing="0" cellpadding="0" width="100%" border="1">
				<tr>
					<td valign="top" width="100%" bgColor="#ffffff">					    
							<table class="TableHeader" style="display:none" cellspacing="0" cellpadding="0" width="100%" border="0">
								<tr>
									<td valign="middle" align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
									<td><asp:label id="lblMeasHeader" runat="server">Worksheet Information</asp:label></td>
								</tr>
							</table>							
							<asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder>						
					</td>
				</tr>
			</table>
			<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" height="24" border="0">
				<tr class="fontHead">
					<td>
					<cc1:bwimagebutton id="btnPOMLinked" visible="true" runat="server" WindowName="POMLink"></cc1:bwimagebutton>
							<cc1:bwimagebutton id="btnPOMLink" visible="true" runat="server"  WindowName="POMBreakLink"></cc1:bwimagebutton>
							<cc1:bwimagebutton id="btnPomCritical" visible="true" runat="server" WindowName="POMCritical"></cc1:bwimagebutton>
							<cc1:bwimagebutton id="btnOnQA" visible="true" runat="server" WindowName="POMShowOnQA"></cc1:bwimagebutton>
							<cc1:confirmedimagebutton id="imgBtnRemove" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnChangeTemplate" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
							<cc1:bwimagebutton id="btnPOMTemplate" visible="false" runat="server" WindowName="POMTemplate"></cc1:bwimagebutton>
							<cc1:bwimagebutton id="btnPOMDelete" visible="false" runat="server" WindowName="POMDelete"></cc1:bwimagebutton>							
							<cc1:bwimagebutton id="btnPomLibraryTop" Visible="true" runat="server" WindowName="POMLibrary"></cc1:bwimagebutton>										
							<cc1:bwimagebutton id="btnPOMSort" visible="true" runat="server"  WindowName="POMLibrary"></cc1:bwimagebutton>
					</td>
				</tr>
			</table>
			<table id="tblPomTemplate"  height="24" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></td>
					<td class="TableBar" valign="middle" align="center" width="20"><IMG src="../System/icons/icon_template.gif"></td>
					<td class="TableBar"><cc1:bwhyperlink id="lnkPomTemplate" visible="true" runat="server" WindowName="PomTemplate"></cc1:bwhyperlink></td>
					<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></td>
				</tr>
			</table>			
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="top">															
						<table class="TableHeader" style="display:none" cellspacing="0" cellpadding="0" width="100%" border="0">
				            <tr>
					            <td valign="middle" align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					            <td><asp:label id="Label1" runat="server">PoM Search</asp:label></td>
				            </tr>
			            </table>					
					    <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
						    <tr>							    
							    <td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>								
							    <td vAlign="top" width="100%">
								    <table height="45">
									    <tr>
										    <td><asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>											
									    </tr>
								    </table>
							    </td>																
						    </tr>
					    </table>														
			            <table class="TableHeader" height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
				            border="0">
				            <tr vAlign="middle">
					            <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					            <td class="fontHead" width="10"></td>
					            <td width="20"><asp:imagebutton id="btnImgFirst" runat="server"  ImageUrl="../System/Icons/icon_first_disable.gif"></asp:imagebutton></td>
					            <td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"  ImageUrl="../System/Icons/icon_Previous_disable.gif"></asp:imagebutton></td>
					            <td nowrap align="center" width="100"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
					            <td width="20"><asp:imagebutton id="btnImgNext" runat="server"  ImageUrl="../System/Icons/icon_next_disable.gif"></asp:imagebutton></td>
					            <td width="20"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last_disable.gif"></asp:imagebutton></td>
					            <td width="10">&nbsp;</td>
					            <td nowrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>
					            <td class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></td>
					            <td width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
							            <asp:ListItem Value="5">5</asp:ListItem>
							            <asp:ListItem Value="10">10</asp:ListItem>
							            <asp:ListItem Value="15">15</asp:ListItem>
							            <asp:ListItem Value="20">20</asp:ListItem>
							            <asp:ListItem Value="25">25</asp:ListItem>
							            <asp:ListItem Value="30">30</asp:ListItem>
							            <asp:ListItem Value="40">40</asp:ListItem>
							            <asp:ListItem Value="50" Selected="True">50</asp:ListItem>
						            </asp:dropdownlist></td>
					            <td width="10"><asp:button id="btnRepage" onclick="RePage" runat="server" CssClass="fontHead" ></asp:button></td>
				            </tr>
			            </table>				
						
						<asp:datagrid id="DataGrid1" runat="server" DataKeyField="AMLMeasPomID" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
							AllowPaging="true" PagerStyle-Visible="false" >
							<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
							<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
							<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
							<Columns>
                                <asp:TemplateColumn HeaderStyle-CssClass="TableHeaderRed" ItemStyle-CssClass="TableHeaderRed" HeaderStyle-BorderWidth="0" ItemStyle-BorderWidth="0">
                                    <HeaderTemplate >
                                        <input type="checkbox" onclick="SelectAll(this)" id="chkSelectAll" />
                                    </HeaderTemplate>                                                   
                                </asp:TemplateColumn>
                                <asp:TemplateColumn>
					                <HeaderTemplate>
						                <DIV align="center">
							                <asp:Label id="lblIsLinked" runat="server" CssClass="fontHead"><%#GetSystemText("L")%></asp:Label></DIV>
					                </HeaderTemplate>
					                <ItemTemplate>
						                <asp:Image id="ImgIsLinked" runat="server" ImageUrl="../System/Icons/icon_link.gif"></asp:Image>
					                </ItemTemplate>
				                </asp:TemplateColumn>
				                <asp:TemplateColumn>
					                <HeaderTemplate>
						                <div align="center">
							                <asp:Label id="lblCritical" runat="server" CssClass="fontHead"><%#GetSystemText("C")%></asp:Label></div>
					                </HeaderTemplate>
					                <ItemTemplate>
						                <asp:Image id="ImgCritical" runat="server" ImageUrl="../System/Icons/icon_warning.gif"></asp:Image>
					                </ItemTemplate>
				                </asp:TemplateColumn>
				                <asp:TemplateColumn>
					                <HeaderTemplate>
						                <div align="center">
							                <asp:Label id="lblFlagQA" runat="server" CssClass="fontHead"><%#GetSystemText("QA")%></asp:Label></div>
					                </HeaderTemplate>
					                <ItemTemplate>
						                <asp:Image id="ImgFlagQA" runat="server" ImageUrl="../System/Icons/Control_CheckBox.gif"></asp:Image>
					                </ItemTemplate>
				                </asp:TemplateColumn>
				                <asp:TemplateColumn>
					                <HeaderTemplate>
						                <div align="center">
							                <asp:Label id="lblHow2MeasText" runat="server" CssClass="fontHead"><%#GetSystemText("H")%></asp:Label></div>
					                </HeaderTemplate>
					                <ItemTemplate>
						                <cc1:BWImageButton id="ImgBtnHow2MeasText" runat="server" ImageUrl="../System/Icons/icon_howto.gif" WindowName="POMLibrary"></cc1:BWImageButton>
					                </ItemTemplate>
				                </asp:TemplateColumn>
                            </Columns>					
						</asp:datagrid>
						<table cellspacing="2" cellpadding="0" width="100%" border="0">
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
								<td style="height: 24px"><cc1:confirmedimagebutton id="imgBtnAdd" runat="server" Message="NONE" ></cc1:confirmedimagebutton>								
								<cc1:confirmedimagebutton id="imgBtnLibrary" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
								<cc1:bwimagebutton id="btnPOMTemp"  runat="server"  WindowName="POMTemplate"></cc1:bwimagebutton>								
								<cc1:confirmedimagebutton id="imgBtnAccumarkImport"  runat="server" Message="NONE" ></cc1:confirmedimagebutton>																
								<cc1:ConfirmedImageButton ID="btnPomreconvert" visible="true" runat="server" Message="NONE" />                                       
								<cc1:bwimagebutton id="btnPomLibrary" visible="false" runat="server"  WindowName="POMLibrary"></cc1:bwimagebutton></td> 
							</tr>
						</table>							
					</td>
					<td style="display:none" valign="top" bgColor="#ffffff">
						<table>
							<tr>
								<td height="3"></td>
							</tr>
						</table>
						<cc2:ystabview id="YSTabView2" runat="server"></cc2:ystabview><asp:panel id="pnlImage" runat="server">
							<cc1:confirmedimagebutton id="imgBtnEdit1" runat="server" Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="imgBtnSelect1" runat="server" 
								Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="imgBtnDeleteImage" runat="server" 
							ToolTip="Delete Image From Style..." Message="Do you want to remove this image from this Style?"></cc1:confirmedimagebutton>
							<BR>
							<asp:image id="imgDesign" runat="server" BorderColor="Transparent"></asp:image>
						</asp:panel><asp:panel id="pnlHowTo" runat="server">
							<asp:datalist id="DataList1" runat="server" Width="100%" BorderWidth="1px" BorderStyle="Solid"
								BorderColor="WhiteSmoke" BackColor="White">
								<HeaderTemplate>
									<table cellspacing="0" cellpadding="0" width="100%" border="0">
										<tr class="TableHeader">
											<td class="fonthead" width="75"><asp:Label id="lblCode" runat="server"><%#GetSystemText("Code")%></asp:Label></td>
											<td class="fonthead" width="200"><asp:Label id="Label1" runat="server"><%#GetSystemText("Point of Measure")%></asp:Label></td>
											<td class="fonthead" width="200"><asp:Label id="Label2" runat="server"><%#GetSystemText("How To Measure")%></asp:Label></td>
											<td class="fonthead" width="200"><asp:Label id="Label3" runat="server"><%#GetSystemText("How To Image")%></asp:Label></td>
										</tr>
									</table>
								</HeaderTemplate>
								<AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
								<FooterTemplate>
								</FooterTemplate>
								<ItemStyle BackColor="White"></ItemStyle>
								<ItemTemplate>
									<table width="100%">
										<tr>
											<td class="font" width="75"><%#Container.DataItem("RefCode")%></td>
											<td class="font" width="200"><%#Container.DataItem("Description")%></td>
											<td class="font" width="200"><%#Container.DataItem("How2MeasText")%></td>
											<td class="font" width="200">
												<asp:Image id=Image1 runat="server" ImageUrl='<%# GetImageThumbnail(DataBinder.Eval(Container.DataItem, "ImageSerialNumber").ToString,"50","jpg") %>'>
												</asp:Image></td>
										</tr>
									</table>
								</ItemTemplate>
							</asp:datalist>
						</asp:panel></td>
				</tr>
			</table>
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
		</form>
		<script type="text/javascript">
		    var searchFocus = false;
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

		                    if (!(KEYCODE == "13" && searchFocus)) {
		                        evt.returnValue = false;
		                        evt.keyCode = 0;
		                    }
		                    //window.status = msg;
		                } else if (!(KEYCODE == "13" && searchFocus)) {
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

		    $(document).ready(function () {
		        $('#txtDescription, #txtRefcode').blur(function () {
		            searchFocus = false;
		        })
                .focus(function () {
                    searchFocus = true;
                });
		    });
        </script>		

        
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
        <script language="javascript" type="text/javascript" src="../System/Jscript/jquery-ui-1.8.21.custom.min.js"></script>
        <script type="text/javascript" language="javascript">

            function MeasUnLinkConfirm() {

                var $confirmDialog = $("<div></div>");
                $confirmDialog.html('<p> <%= GetSystemText("You are about to break the page link for the following measurement workflow:") %> </p>' +
                                    '<p style="padding: 0 5 0 5;"><table cellspacing="0" cellpadding="0" border="0">' +
                                    '   <tr><td width="50px"><%= GetSystemText("Name") %>:</td><td style="white-space:nowrap;"><%= MeasName %></td></tr>' +
                                    '   <tr><td width="50px"><%= GetSystemText("Source") %>:</td><td style="white-space:nowrap;"><%= SourceStyle %></td></tr>' +
                                    '</table></p>' +
                                    '<p> <%= GetSystemText("Are you sure you want to continue?") %> </p>');
                $confirmDialog.dialog({
                    autoOpen: false,
                    modal: true,
                    resizable: false,
                    width: 350,
                    title: '<%= GetSystemText("Break Page Link") %>',
                    buttons: {
                        '<%= GetSystemText("Yes") %>': function () {
                            $(this).dialog("close");
                            <%= ClientScript.GetPostBackEventReference(New PostBackOptions(btnUnLinkWorkflowItem) With {.PerformValidation = False}) %>;
                            return true;
                        },
                        '<%= GetSystemText("No") %>': function () {
                            $(this).dialog("close");
                            return false;
                        }
                    }
                });

                $confirmDialog.dialog('open');
                return false;
            }	    
        </script>   

	</body>
</html>
