<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_DesignDetailForm_Edit.aspx.vb" Inherits="plmOnApp.Style.DesignDetailForm.Style_DesignDetailForm_Edit" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow_Edit" Src="Style_Workflow_Edit.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc3" TagName="Style_WorkflowItem" Src="Style_WorkFlowItem.ascx" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Style</title>	
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script src="../System/Jscript/jquery-1.6.2.min.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>

	</head>
	<body>
     <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server">
        <telerik:RadScriptManager runat="server" ID="RadScriptManager1" />
			<table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>

					<td noWrap width="850">
					<cc1:confirmedimagebutton id="btnTextImageGoTo" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					<cc1:bwimagebutton id="btnImageNew" runat="server" ></cc1:bwimagebutton>
					<cc1:bwimagebutton id="btnImageSelect" runat="server" ></cc1:bwimagebutton>
					<cc1:bwimagebutton id="btnImageSort" runat="server" ></cc1:bwimagebutton>
					<cc1:confirmedimagebutton id="btnCopy" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					<cc1:bwimagebutton id="btnImageRemove" runat="server" ></cc1:bwimagebutton>
					<cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
                    <cc1:bwimagebutton id="btnChangeLog" runat="server"  CausesValidation="false" OnClientClick="javascript:Page_ValidationActive = false;"></cc1:bwimagebutton>				
					</td>
					<td class="FontHead" align="right" width="75"><!--&nbsp;<%=GetSystemText("Select Set")%>:--></td>
					<td width="40"><!--<asp:dropdownlist id="dpStyleSet" runat="server" CssClass="font" DataTextField="Value" DataValueField="ID"
							AutoPostBack="true"></asp:dropdownlist>--></td>
					<td><!--<asp:imagebutton id="imgBtnGo" runat="server" ImageUrl="../System/Icons/icon_go.gif"></asp:imagebutton>--></td>
				</tr>
			</table>
			<uc1:style_workflow_edit id="Style_Workflow_Edit1" runat="server"></uc1:style_workflow_edit><asp:panel id="pnlChange" runat="server">
				<uc1:Style_Change_Alert id="Style_Change_Alert1" runat="server"></uc1:Style_Change_Alert>
			</asp:panel><uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
		    <table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
			    <tr>
				    <td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
			    </tr>
		    </table>
		    <uc3:Style_WorkflowItem id="Style_WorkflowItem1" runat="server" />			
			<table cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td id="TD_Detail" valign="top" width="800" runat="server">
						&nbsp;
					</td>
					<td valign="top" bgColor="#ffffff"></td>
				</tr>
			</table>
			<asp:datalist id="DataList1" runat="server" Width="100%" OnItemCommand="DataList1_ItemCommand"
				OnItemDataBound="DataList1_ItemDataBound" DataKeyField="StyleDetailFormID" RepeatColumns="1"
				RepeatDirection="Horizontal" EnableViewState="True">
				<ItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
					VerticalAlign="Top" CssClass="font" BackColor="White">
				</ItemStyle>
				<AlternatingItemStyle HorizontalAlign="Left" BorderWidth="1px" BorderStyle="Solid" BorderColor="LightGray"
					VerticalAlign="Top" CssClass="font" BackColor="AliceBlue">
				</AlternatingItemStyle>	
				<ItemTemplate>
					<table style="border-color:silver" cellspacing="2" cellpadding="2" width="100%" border="0">
						<tr>
							<td align="left" valign="top">
								<cc1:BWImageButton id="btnImageEdit" runat="server" 
									CommandName="Window"></cc1:BWImageButton>
								<cc1:confirmedimagebutton id="btnImageBreak" runat="server" Message='<%# GetSystemText("Break image link from all size class?") %>'
									 CommandName="Break"></cc1:confirmedimagebutton></td>
						
							<td valign="top" style="height:150;" rowspan="2">
							    <telerik:RadEditor runat="server" ID="txtComment" Width="680px" EditModes="Design" spellchecks>
                                    <Tools>
											<telerik:EditorToolGroup >
                                            <telerik:EditorTool Name="Bold" />
                                            <telerik:EditorTool Name="Italic" />
                                            <telerik:EditorTool Name="Underline" />
                                        </telerik:EditorToolGroup>
                                    </Tools>
                                </telerik:RadEditor>
								<asp:HiddenField ID="hdnComment" runat="server" />
								<input id="txtImageVersion" type="hidden" value='<%# DataBinder.Eval(Container.DataItem, "ImageVersion") %>' runat="server" />
								<input id="txtImageID" type="hidden" value='<%# DataBinder.Eval(Container.DataItem, "ImageID") %>' runat="server" />
							</td>						
						
						
						</tr>
						<tr>
							<td style=" height:150; width:350px">
								<cc1:BWImageButton id="btnImgNewWindow" runat="server" 
									CommandName="Window"></cc1:BWImageButton>
							</td>

						</tr>

					</table>
				</ItemTemplate>
				<HeaderStyle HorizontalAlign="Left"></HeaderStyle>
			</asp:datalist></form>
		<SCRIPT language="javascript">
		    var frm = document.Form1;
		    function CheckAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chkDelete") != -1)
		                e.checked = actVar;
		        }
		    }
		</SCRIPT>
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
		<script type="text/javascript" language="javascript">
		    //adjust height of comments textarea wi #11609
		    $(window).load(function () {
		        $("#DataList1>tbody>tr>td").each(function () {
		            var height = $(this).find("input[id$=btnImgNewWindow]").css("height");
		            $(this).find("div[id$=txtComment]").css("height", height + 1)
		        });
		    });
		</script>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
      	</body>
</html>
