<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sample_TechPack_New_Variation.aspx.vb" Inherits="plmOnApp.Sample_TechPack_New_Variation" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title>Variation</title>
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tab.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<SCRIPT language="JavaScript" type="text/javascript">
		<!--
		    function DoPageLoad() {

		        var Timer = setTimeout('self.focus();', 1000);
		    }
		// -->
		</SCRIPT>
	</HEAD>
	<body onbeforeunload="busyBox.Show();" onload="DoPageLoad();" MS_POSITIONING="GridLayout">
		<script language="javascript" src="../system/jscript/ysbusyscript.js" type="text/javascript"></script>
		<form id="Form1" method="post" runat="server">		
			<br>
			<br>
			<br>

			<cc3:ystabview id="YSTabView1" runat="server"></cc3:ystabview>
			    				<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
					<TR vAlign="middle">
						<TD vAlign="middle" align="center" width="10">
                            <IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
						<td>
							<CC1:CONFIRMEDIMAGEBUTTON id="btnSave" runat="server"   Message="NONE"></CC1:CONFIRMEDIMAGEBUTTON>
							<CC1:CONFIRMEDIMAGEBUTTON id="btnClose" runat="server"  Message="NONE" CausesValidation="False"></CC1:CONFIRMEDIMAGEBUTTON>
						</td>
					</tr>
				</table>
                <asp:panel id="pnlOld" Runat="server">
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
                                                <asp:TextBox Runat="server" ID="hdnStyleID" Visible="False" />
                                                <%-- <table id="tbVariationHeader" runat="server" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
	                                                <tr>
		                                                <td height="25"><asp:Label ID="lblVariation" runat="server" CssClass="fontHead" ></asp:Label></td>
	                                                </tr>			    
                                                </table>
                                                --%>
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
								                                                        BorderWidth="0px" BorderStyle="Solid" BorderColor="Silver" DataKeyField="ReportPageID" OnItemDataBound="dgReports_ItemDataBound">
								                                                        <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
								                                                        <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
								                                                        <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
								                                                        <Columns>
									                                                        <asp:TemplateColumn>
										                                                        <HeaderStyle HorizontalAlign="Center"></HeaderStyle>
										                                                        <ItemStyle Width="50px" HorizontalAlign="Center"></ItemStyle>
										                                                        <ItemTemplate>
											                                                        <asp:CheckBox Runat="server" ID="chkReporte"></asp:CheckBox>
										                                                        </ItemTemplate>
									                                                        </asp:TemplateColumn>
									                                                        <asp:TemplateColumn>
										                                                        <HeaderStyle HorizontalAlign="Left"></HeaderStyle>	
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
					                                                                BorderStyle="Solid" BorderColor="Silver" OnItemDataBound="dlWorkflowItems_ItemDataBound">
					                                                                <ItemStyle BorderWidth="0px" BorderStyle="Solid" BorderColor="LightGray" BackColor="White"></ItemStyle>
									                                                    <ItemTemplate> 
                            												            
									                                                        <table cellpadding="0" cellspacing="0" border="0" class="TableHeaderOver" width="100%">
										                                                        <tr>
											                                                        <td height="25"><font size="5">
													                                                        <asp:label id="lblWorkflowItem" runat="server" CssClass="fontHead">Workflow Item</asp:label></font></td>
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

				
			</asp:panel>
            <asp:datagrid id="dgPredefined" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
				PageSize="100" AutoGenerateColumns="False" Width="100%">
				<AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
				<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
				<HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<asp:Label runat="server" CssClass="fontHead" ID="label1"> <%#GetSystemText("Select")%> </asp:Label>
						</HeaderTemplate>
						<HeaderStyle HorizontalAlign="Center" Width="50px"></HeaderStyle>
						<ItemStyle HorizontalAlign="Center"></ItemStyle>
						<ItemTemplate>
							<asp:Label id="lblRadio" runat="server"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderTemplate>
							<asp:Label runat="server" CssClass="fontHead" ID="label1"><%#GetSystemText("Select page to print")%>...</asp:Label>
						</HeaderTemplate>
						<ItemTemplate>
							<asp:Label id="lblReportPage" runat="server"></asp:Label>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:datagrid>

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
				
			</script>
		</form>
	</body>
</HTML>

