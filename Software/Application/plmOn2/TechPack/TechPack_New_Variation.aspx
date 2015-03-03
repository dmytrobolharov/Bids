<%@ Page Language="vb" AutoEventWireup="false" Codebehind="TechPack_New_Variation.aspx.vb" Inherits="plmOnApp.TechPack_New_Variation" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Tech Pack</title>
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tab.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<SCRIPT language="JavaScript" type="text/javascript">
		<!--
		    function DoPageLoad() {

		        var Timer = setTimeout('self.focus();', 0);
		    }
		// -->
		</SCRIPT>
	</HEAD>
	<body onbeforeunload="busyBox.Show();" onload="DoPageLoad();" MS_POSITIONING="GridLayout">
		<script language="javascript" src="../system/jscript/ysbusyscript.js" type="text/javascript"></script>
		<form id="Form1" method="post" runat="server">		
			<br />
			<br />
			<br />

			<cc3:ystabview id="YSTabView1" runat="server"></cc3:ystabview>
			    <asp:panel id="pnlOld" Runat="server">
				<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
					<TR vAlign="middle">
						<TD vAlign="middle" align="center" width="10">
                            <IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td>
							<CC1:confirmedimagebutton id="btnSave" runat="server"   Message="NONE"></CC1:confirmedimagebutton>
							<CC1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" CausesValidation="False" OnClientClick="return btnClose_Click()"></CC1:confirmedimagebutton>
						</td>
					</tr>
				</table>
		    
			    <table cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0" runat="server" id="table1">
				    <tr>
					    <td><asp:PlaceHolder ID="plhSourcingHeader1" runat ="server" ></asp:PlaceHolder></td>
				    </tr>			    
			    </table>	
			    <table cellspacing="0" cellpadding="0" width="100%" border="0">
				    <tr runat="server" id="tbSeasonYear2"  visible ="false">
                        <td valign="top" visible="true">
                            <table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
                                border="0">
                                <tr valign="middle">
                                    <td valign="middle" align="center" width="10">
                                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                    </td>
                                    <td width="20"><img src="../System/Icons/icon_season.gif" /></td>
                                    <td width="125" align="right" nowrap="nowrap">
                                        <asp:Label runat="server" ID="lblSeasonYear" class="fontHead" >Select Season / Year</asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlSeasonYear2" runat="server"  AutoPostBack="true"></asp:DropDownList>
                                    </td>
                                </tr>
                            </table>                              					    
                        </td>
				    </tr>				    
                    </table>			    
			    						
	    	    <table cellspacing="0" cellpadding="0" width="100%" border="0" bgcolor="White">
			            <tr>
	                        <td width="50">&nbsp;</td>	
	                        <td width="120"></td>	
	                        <td>&nbsp;</td>
	                    </tr>    
				        <tr>
				            <td width="50">&nbsp;</td>
					        <td>
						        <asp:Label id="lblTechpackName" Runat="server" CssClass="fontHead">Tech Pack Name:</asp:Label></td>
					        <td>
						        <asp:TextBox id="txtTechpackName" Runat="server" CssClass="font" MaxLength="100" Width="200"></asp:TextBox></td>
				        </tr>
						<tr>
							<td width="50">&nbsp;</td>
                            <td>
								<asp:Label id="lblTechPackLanguage2" Runat="server" CssClass="fontHead">Language:</asp:Label>
							</td>
							<td>
                                <asp:DropDownList ID="ddlLanguage2" runat="server" AutoPostBack="false" Width="200"></asp:DropDownList>
							</td>
						</tr>
				        <tr>
				            <td width="50"></td>
					        <td>
						        <asp:Label id="lblTechPackRelease" Runat="server" CssClass="fontHead"></asp:Label></td>
					        <td>
						        <asp:CheckBox id="chkTechPackRelease" Runat="server"></asp:CheckBox></td>
				        </tr>
				        <tr>
				            <td width="50"></td>
					        <td>
						        <asp:Label id="lblSizeClassHeader" Runat="server" CssClass="fontHead">Select Size...</asp:Label></td>
					        <td>
						        <asp:radiobuttonlist id="rbSizeList" runat="server" CssClass="font" AutoPostBack="True"></asp:radiobuttonlist></td>
				        </tr>
	                    <tr>
	                        <td width="50"></td>
	                        <td><asp:Label ID="lblSelectAll" runat="server" Text="Select All..." CssClass="fontHead"></asp:Label></td>
		                    <td><INPUT onclick="CheckAll(this);" type="checkbox"></td>
	                    </tr>	
	                    <tr>
	                        <td>&nbsp;</td>	
	                        <td></td>	
	                        <td>&nbsp;</td>
	                    </tr>    					    
			        </table>  
		        <table cellspacing="0" cellpadding="0" border="0">
		            <tr valign="top" align="left">
		                <td>
	                        <asp:datalist id="dlVariation" runat="server" Width="100%" DataKeyField="StyleDevelopmentItemID" BorderWidth="0px"
			                    BorderStyle="Solid" BorderColor="Silver" RepeatDirection="Horizontal">
			                    <ItemStyle BorderWidth="0px" BorderStyle="Solid" BorderColor="LightGray" BackColor="White" VerticalAlign="Top"></ItemStyle>
			                     <ItemTemplate>
			                        <table cellspacing="0" cellpadding="0" style="border: 1px solid #C0C0C0; background-color: #FFFFFF">
			                            <tr valign="top">
			                                <td valign="top" >
                                                <table id="tbVariationHeader" runat="server" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
	                                                <tr>
		                                                <td height="25"><asp:Label ID="lblVariation" runat="server" CssClass="fontHead" ></asp:Label><asp:TextBox Runat="server" ID="hdnStyleID" Visible="False" /></td>
	                                                </tr>			    
                                                </table>
                                                 <table cellspacing="0" cellpadding="0" border="0">
		                                            <tr>
			                                            <td valign="top">
			                                                <asp:datalist id="dlWorkflows" runat="server" Width="100%" DataKeyField="WorkflowID" BorderWidth="1"
					                                            BorderStyle="Solid" BorderColor="Silver" OnItemDataBound="dlWorkflows_ItemDataBound">
					                                            <ItemStyle BorderWidth="0px" BorderStyle="Solid" BorderColor="LightGray" BackColor="White"></ItemStyle>
					                                            <ItemTemplate>
						                                            <table cellspacing="0" cellpadding="0" width="100%" border="0">
							                                            <tr valign="top">
								                                            <td width="300px" valign="top">
									                                            <table cellpadding="0" cellspacing="0" border="0" class="TableHeader" width="100%" runat="server" id ="tbWorkflows">
										                                            <tr>
										                                                <td width="20"><img alt="" src="../System/icons/icon_next.gif" /></td>
											                                            <td height="25">
													                                            <asp:label id="lblWorkflow" runat="server" CssClass="fontHead">Workflow</asp:label></td>
										                                            </tr>
									                                            </table>
							                                                        <asp:datagrid id="dgReports" runat="server" Width="100%" AutoGenerateColumns="False" PageSize="100"
								                                                        BorderWidth="0px" BorderStyle="Solid" BorderColor="Silver" DataKeyField="ReportPageID" OnItemDataBound="dgReports_ItemDataBound" SelectedItemStyle-VerticalAlign="NotSet" ShowHeader="False">
								                                                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
								                                                        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
								                                                        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
								                                                        <Columns>
									                                                        <asp:TemplateColumn>
										                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
										                                                        <HeaderTemplate>
											                                                        <asp:Label Runat="server" id="lblHeaderCheck" Text='<%#GetSystemText("Select") %>'></asp:Label>
										                                                        </HeaderTemplate>
										                                                        <ItemStyle Width="50px" HorizontalAlign="Center"></ItemStyle>
										                                                        <ItemTemplate>
											                                                        <asp:CheckBox Runat="server" ID="chkReporte"></asp:CheckBox>
										                                                        </ItemTemplate>
									                                                        </asp:TemplateColumn>
									                                                        <asp:TemplateColumn>
										                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
										                                                        <HeaderTemplate>
											                                                        <asp:Label Runat="server" id="lblHeaderDesc" Text='<%#GetSystemText("Select page(s) to print") & "..." %>'></asp:Label>
										                                                        </HeaderTemplate>
										                                                        <ItemStyle Width="450px"></ItemStyle>
										                                                        <ItemTemplate>
											                                                        <asp:Label Runat="server" ID="lblDesc"></asp:Label>
											                                                        <asp:TextBox Runat="server" ID="hdnWorkflowItemID" Visible="False" />
										                                                        </ItemTemplate>
									                                                        </asp:TemplateColumn>
								                                                        </Columns>
							                                                        </asp:datagrid>
								                                            </td>
							                                            </tr>
							                                            <tr valign="top">
								                                            <td width="300px" valign="top">

                            								                
			                                                                    <asp:datalist id="dlWorkflowItems" runat="server" Width="100%" DataKeyField="WorkflowItemID" BorderWidth="1px"
					                                                                BorderStyle="Solid" BorderColor="Silver" OnItemDataBound="dlWorkflowItems_ItemDataBound" ShowHeader="False" ShowFooter="False">
					                                                                <ItemStyle BorderWidth="0px" BorderStyle="Solid" BorderColor="LightGray" BackColor="White"></ItemStyle>
									                                                    <ItemTemplate> 
                            												            
									                                                        <table cellpadding="0" cellspacing="0" border="0" class="TableHeaderOver" width="100%">
										                                                        <tr>
											                                                        <td height="25">
													                                                    <font size="5"><asp:label id="lblWorkflowItem" runat="server" CssClass="fontHead">Workflow Item</asp:label></font>
													                                                    <asp:HiddenField runat="server" ID="hdnLinkedMeasStyleID" />
											                                                        </td>
										                                                        </tr>
									                                                        </table>
                            								                        
									                                                        <asp:datagrid id="dgReports" runat="server" Width="100%" AutoGenerateColumns="False" PageSize="100"
										                                                        BorderWidth="0px" BorderStyle="Solid" BorderColor="Silver" DataKeyField="ReportPageID" OnItemDataBound="dgReports_ItemDataBound">
										                                                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
										                                                        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
										                                                        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
										                                                        <Columns>
											                                                        <asp:TemplateColumn>
												                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
												                                                        <HeaderTemplate>
													                                                        <asp:Label Runat="server" id="lblHeaderCheck" Text='<%#GetSystemText("Select") %>'></asp:Label>
												                                                        </HeaderTemplate>
												                                                        <ItemStyle Width="50px" HorizontalAlign="Center"></ItemStyle>
												                                                        <ItemTemplate>
													                                                        <asp:CheckBox Runat="server" ID="chkReporte"></asp:CheckBox>
												                                                        </ItemTemplate>
											                                                        </asp:TemplateColumn>
											                                                        <asp:TemplateColumn>
												                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
												                                                        <HeaderTemplate>
													                                                        <asp:Label Runat="server" id="lblHeaderDesc" Text='<%#GetSystemText("Select page(s) to print") & "..." %>'></asp:Label>
												                                                        </HeaderTemplate>
												                                                        <ItemStyle Width="450px"></ItemStyle>
												                                                        <ItemTemplate>
													                                                        <asp:Label Runat="server" ID="lblDesc"></asp:Label>
													                                                        <asp:TextBox Runat="server" ID="hdnWorkflowItemID" Visible="False" />
												                                                        </ItemTemplate>
											                                                        </asp:TemplateColumn>
                            														                
										                                                        </Columns>
									                                                        </asp:datagrid>
									                                                    </ItemTemplate>
				                                                                </asp:datalist>

                            				                                    
									                                            <br>
								                                            </td>
							                                            </tr>
						                                            </table>
					                                            </ItemTemplate>
				                                            </asp:datalist>

                                                        </td>
                                                        
		                                            </tr>
	                                            </table>
	                                        </td>
			                            </tr>
			                        </table>
	                            </ItemTemplate>
	                        </asp:datalist>
	                    </td>
		            </tr>
		        </table>

				
			</asp:panel><asp:panel id="pnlNew" Runat="server">
				<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
					<TR vAlign="middle">
						<TD vAlign="middle" align="center" width="10">
                            <IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td>
							<cc1:confirmedimagebutton id="btnSaveNew" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
							<cc1:confirmedimagebutton id="btnCloseNew" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
						</td>
					</tr>
				</table>
			    <table cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0" runat="server" id="table2">
				    <tr>
					    <td><asp:PlaceHolder ID="plhSourcingHeader2" runat ="server" ></asp:PlaceHolder></td>
				    </tr>
				    <tr><td>
				        <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				            cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0" >
				            <tr>
					            <td>&nbsp;</td>
				            </tr>
			            </table>				
				    </td></tr>
			    </table>							
				<table class="TableHeaderGreen" cellspacing="0" cellpadding="0" width="100%" border="0">
                    <tr valign="middle">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
						<TD class="fontHead" height="25">&nbsp;<asp:Label ID="lblNewTechPack" 
                                runat="server" Text="New Tech Pack"></asp:Label>
                        </td>
					</tr>
				</table>
                <table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
                    border="0" id="tbSeasonYear" runat="server" visible="false">
                    <tr valign="middle">
                        <td valign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                        </td>
                        <td width="20"><img src="../System/Icons/icon_season.gif" /></td>
                        <td width="125" align="right" nowrap="nowrap">
                            <asp:Label runat="server" ID="lblSelectSeasonYear" class="fontHead" >Select Season / Year:</asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlSeasonYearID" runat="server"  AutoPostBack="true"></asp:DropDownList>
                        </td>
                    </tr>
                </table>

			    <table cellSpacing="0" cellPadding="0" width="500" border="0">
				    <tr>
                        <td vAlign="middle" align="center" width="20" height="25">
                        </td>
					    <td width="100">
						    <asp:Label id="lblTechPackLanguage1" Runat="server" CssClass="fontHead">Language:</asp:Label>
						</td>
					    <td width="400">
                            <asp:DropDownList ID="ddlLanguage1" runat="server" AutoPostBack="false" Width="200"></asp:DropDownList>
						</td>
				    </tr>
			    </table>

				<table height="500" cellspacing="0" cellpadding="0" width="100%" border="0">
					<tr>
					    
						<td vAlign="top" width="150" bgColor="#ffffff">
							<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
								<tr vAlign="middle">
									<td vAlign="middle" align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
									<td class="FontHead">&nbsp;<asp:Label ID="lblSelectSize" runat="server" 
                                            Text="Select Size..."></asp:Label>
                                    </td>
									<td>&nbsp;</td>
								</tr>
							</table>
							<asp:radiobuttonlist id="rbSizeClass" runat="server" CssClass="font" AutoPostBack="True"></asp:radiobuttonlist></td>
						<td vAlign="top" bgColor="#ffffff">
							<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
								<tr vAlign="middle">
									<td vAlign="middle" align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
									<td class="FontHead">&nbsp;<asp:Label ID="lblSelectTechPack" runat="server" 
                                            Text="Select Tech Pack..."></asp:Label>
                                    </td>
									<td>&nbsp;</td>
								</tr>
							</table>
                            <asp:ListView runat="server" ID="lstTechPack" DataKeyNames="ReportTechPackFolderID">
                                <ItemTemplate>
                                    <label class="fontHead">
                                        <input type="radio" name="rbTechPacks" value='<%# DataBinder.Eval(Container.DataItem, "ReportTechPackFolderID")%>'/>
                                        <%# DataBinder.Eval(Container.DataItem, "ReportTechPackFolderName")%>
                                    </label>
                                    <%-- <asp:RadioButton ID="rbTechPacks" runat="server" class="font" Text='<%# DataBinder.Eval(Container.DataItem, "ReportTechPackFolderName")%>' Value='<%# DataBinder.Eval(Container.DataItem, "ReportTechPackFolderID")%>' /> --%>
                                    <br />
                                    <asp:ListView runat="server" id="lstWorkflow" OnItemDataBound="lstWorkflow_DataBound">
                                        <ItemTemplate>
                                            <asp:CheckBox class="font" style="padding-left:20px" ID="chkWorkflows" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "MapDetail")%>' value='<%# DataBinder.Eval(Container.DataItem, "ReportMapID")%>'/>
                                            <asp:HiddenField ID="hdnTeckPackFolder" runat="server" Value='<%# DataBinder.Eval(Container.DataItem, "ReportTechPackFolderID")%>' />
                                            <br />
                                            <asp:ListView runat="server" id="lstWorkflowItem" OnItemDataBound="lstWorkflowItem_DataBound">
                                                <ItemTemplate>
                                                    <label class="font" style="padding-left:40px">                                                        
                                                        <input type="checkbox" ID="chkWorkflowItem" runat="server" value='<%# DataBinder.Eval(Container.DataItem, "WorkFlowItemID")%>' />
<%--                                                        <asp:CheckBox class="font" style="padding-left:40px" ID="chkWorkflowItem" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "WorkFlowItemName")%>' /> --%>
                                                        <%# DataBinder.Eval(Container.DataItem, "WorkFlowItemName")%>
                                                    </label>
                                                    <br />
                                                </ItemTemplate>
                                            </asp:ListView>
                                        </ItemTemplate>
                                    </asp:ListView>
                                    <input type="hidden" id="hdnCheckedWorkflowItems_<%# DataBinder.Eval(Container.DataItem, "ReportTechPackFolderID") %>" name="hdnCheckedWorkflowItems_<%# DataBinder.Eval(Container.DataItem, "ReportTechPackFolderID") %>" />
                                </ItemTemplate>
                            </asp:ListView>
<%--                            <br/><br/>
							<asp:RadioButtonList id="rbTechPack" runat="server" CssClass="font"></asp:RadioButtonList>
--%>                        </td>
					</tr>
				</table>
			</asp:panel>
			<div id="BusyBoxDiv" style="BORDER-RIGHT: gainsboro 0px solid; PADDING-RIGHT: 5px; BORDER-TOP: gainsboro 0px solid; PADDING-LEFT: 5px; PADDING-BOTTOM: 5px; BORDER-LEFT: gainsboro 0px solid; PADDING-TOP: 5px; BORDER-BOTTOM: gainsboro 0px solid; POSITION: absolute; BACKGROUND-COLOR: transparent; TEXT-ALIGN: center">
				<p style="WIDTH: 220px; TEXT-ALIGN: center">
					<table cellspacing="1" cellpadding="1" width="100%" border="0">
						<tr>
							<TD width="50" height="32"><IMG id="BusyBoxImg" height="32" src="../system/images/busy_Layer_0.gif" width="32"></td>
							<TD class="fontHead"><asp:Label ID="lblPleaseWait" runat="server" 
                                    Text="Please Wait..."></asp:Label>
                                <br>
								<asp:Label ID="lblTechPackLoading" runat="server" Text="Tech Pack Loading"></asp:Label></td>
						</tr>
					</table>
				</p>
			</div>
			<script language="javascript" type="text/javascript">
			    // Instantiate our BusyBox object
			    var busyBox = new BusyBox("busyBox", 12, "busy_Layer_", ".gif", 120);

			    var frm = document.Form1;

			    function CheckAll(obj) {
			        var e, rd;

			        var actVar = obj.checked;
			        for (i = 0; i < frm.length; i++) {
			            e = frm.elements[i];
			            try {
			                if (e.type == 'checkbox' && e.name.indexOf("chkReporte") != -1) {
			                    e.checked = actVar;
			                }

			                if (e.type == 'checkbox' && e.name.indexOf("chkReportSourcing") != -1) {
			                    e.checked = actVar;
			                }

			            } catch (err) { }
			        }
			    }

			    var wichecked = {};

			    function CheckWorkflowItem(chb, tpfid) {
			        if (wichecked[tpfid] == null) {
			            wichecked[tpfid] = [];
			        }
			        var checked = wichecked[tpfid];

                    if (chb.checked) {
                        checked.push(chb.value);
                    } else {
                        for (var i = 0; i < checked.length; i++) {
                            if (checked[i] == chb.value) {
                                checked.splice(i, 1);
                                break;
                            }
                        }
                    }

                    document.getElementById('hdnCheckedWorkflowItems_' + tpfid).value = checked.join(',');
                }

                function CheckAllWorkflowItems(chb, tpfid) {
                    var parent_id = chb.id.replace('chkWorkflows', '');
                    for (var i = 0; i < frm.length; i++) {
                        var e = frm.elements[i];
                        try {
                            if (e.type == 'checkbox' && e.id.indexOf(parent_id) != -1 && e.id.indexOf('chkWorkflows') == -1 ) {
                                e.checked = chb.checked;
                                CheckWorkflowItem(e, tpfid);
                            }
                        } catch (err) { }
                    }
                }


                function CheckWorkflowItemIfOne() {
                    for (var i = 0; i < frm.length; i++) {
                        var e = frm.elements[i];
                        if (e.type == 'checkbox' && e.id.indexOf('chkWorkflows') != -1) {
                            var parent_id = e.id.replace('chkWorkflows', '');
                            var TechPackFolderId = document.getElementById(parent_id + "hdnTeckPackFolder").value;
                            var mas_child = [];
                            for (var j = 0; j < frm.length; j++) {
                                var x = frm.elements[j];
                                try {
                                    if (x.type == 'checkbox' && x.id.indexOf(parent_id) != -1 && x.id.indexOf('chkWorkflows') == -1) {
                                        mas_child.push(x.id)
                                    }
                                } catch (err) { }
                            }
                            if (mas_child.length == 1) {
                                e.checked = "checked";
                                CheckAllWorkflowItems(e, TechPackFolderId)
                            }
                        }
                    }
                }
                CheckWorkflowItemIfOne();

                for (var i = 0; i < frm.length; i++) {
                    var e = frm.elements[i];
                    try {
                        if (e.type == "radio" && e.name.indexOf("rbTechPacks") != -1) {
                            e.checked = "checked";
                            break;
                        }
                    } catch (err) { }
                }

			</script>
		</form>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
	</body>
</HTML>
