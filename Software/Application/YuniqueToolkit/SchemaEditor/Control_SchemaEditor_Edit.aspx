
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_SchemaEditor_Edit.aspx.vb" Inherits="YuniFace.Control_SchemaEditor_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc3" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
        <title runat="server" id="PageTitle">Schema</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
		<meta content="JavaScript" name="vs_defaultClientScript" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>

		<script type="text/javascript" language="JavaScript">
			<!--
		    function HeaderSaved() {
		        document.Form1.hdnMethod.value = 'HEADERSAVED';
		        Form1.submit();
		    }
		    function RelatedTableSaved() {
		        document.Form1.hdnMethod.value = 'RELATEDTABLESAVED';
		        Form1.submit();
		    }
		    function ColumnSaved() {
		        document.Form1.hdnMethod.value = 'COLUMNSAVED';
		        Form1.submit();
		    }
		    function ValidatorSaved() {
		        document.Form1.hdnMethod.value = 'VALIDATORSAVED';
		        Form1.submit();
		    }
		    function LookupTableSaved() {
		        document.Form1.hdnMethod.value = 'LOOKUPTABLESAVED';
		        Form1.submit();
		    }
			//-->
		</script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
            <asp:HiddenField ID="hdnMethod" runat="server" Value="" />

		<div id="TheWholeForm" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td>
					    <cc1:confirmedimagebutton id="btnSave" runat="server" ImageUrl="" Message="NONE"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnSaveAndClose" runat="server" ImageUrl="" Message="NONE"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnPreview" runat="server" ImageUrl="" Message="NONE"></cc1:confirmedimagebutton>
					    <cc1:confirmedimagebutton id="btnClose" runat="server" ImageUrl="" Message="NONE" CausesValidation="False"></cc1:confirmedimagebutton>
					</td>
    				<td class="fontHead" align="right" width="100">
    				    &nbsp;<asp:Label ID="lblItemType" runat="server" />
    				</td>
    				<td width="40">
    				    <asp:dropdownlist id="ddlItemType" runat="server" CssClass="font" DataTextField="Value" DataValueField="ID" AutoPostBack="true"/>
    				</td>
				</tr>
			</table>
			
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label></td>
				</tr>
			</table>

			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" cellSpacing="2" cellPadding="0" width="100%" border="0">
				<tr>
					<td>
						<table bgcolor='#FFFFFF' width='100%' border='0' cellspacing='1' cellpadding='0'>
							<tr valign='top'>
								<td width='50%'>
									<table width='100%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
										<tr>
											<td width='125' height='25' class='fonthead' nowrap>
											    <asp:label id="lblName" runat="server">Table Name</asp:label>
											</td>
											<td class='font'>
												<asp:textbox id="txtpkName" runat="server" CssClass="font" Width="200px"></asp:textbox>
											</td>
										</tr>
										<tr>
											<td width='125' height='25' class='fonthead' nowrap>
											    <asp:label id="lblformcolumns" runat="server">Form Columns</asp:label>
											</td>
											<td class='font'>
												<asp:DropDownList ID="drlformcolumns" runat="server" AutoPostBack="true" Width="200px">
													<asp:ListItem Value="1">1</asp:ListItem>
													<asp:ListItem Value="2">2</asp:ListItem>
													<asp:ListItem Value="3">3</asp:ListItem>
												</asp:DropDownList>
											</td>
										</tr>
										<tr>
											<td width='125' height='25' class='fonthead' nowrap>
											    <asp:label id="lblFormTableView" runat="server">Form Table/View</asp:label>
											</td>
											<td class='font'>
												<asp:textbox id="txtFormTableView" runat="server" CssClass="font" Width="200px"></asp:textbox>
											</td>
										</tr>
										<tr>
											<td width='125' height='25' class='fonthead' nowrap>
											    <asp:label id="lblGridColumns" runat="server">Grid Columns</asp:label>
											</td>
											<td class='font'>
												<asp:textbox id="txtgridcolumns" runat="server" CssClass="font" Width="200px"></asp:textbox>
											</td>
										</tr>
										<tr>
											<td width='125' height='25' class='fonthead' nowrap>
											    <asp:label id="lblGridTableView" runat="server">Grid Table/View</asp:label>
											</td>
											<td class='font'>
												<asp:textbox id="txtGridTableView" runat="server" CssClass="font" Width="200px"></asp:textbox>
											</td>
										</tr>
										<tr>
											<td width='125' height='25' class='fonthead' nowrap>
											</td>
											<td class='font'>
											    <asp:Button runat="server" ID="btnEditHeader" Visible="false" OnClientClick="ShowEditHeaderForm(); return false;" Text="edit header" Height="24px" Width="200px" />
											</td>
										</tr>
										<tr>
											<td width='125' height='25' class='fonthead' nowrap>
											</td>
											<td class='font'>
											    <asp:Button runat="server" ID="btnEditRelatedTables" Visible="false" OnClientClick="ShowEditRelatedTablesForm(); return false;" Text="edit related tables" Height="24px" Width="200px" />
											</td>
										</tr>
									</table>
								</td>
								<td width='50%'>
									<table width='100%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
										<tr>
											<td width='125' height='25' class='fonthead' nowrap>
											    <asp:label id="lblFormSQL" runat="server">Form SQL</asp:label>
											</td>
											<td class='font'>
												<asp:textbox TextMode="MultiLine" Rows="4" Columns="20" id="txtFormSQL" runat="server" CssClass="font" Width="200px"></asp:textbox>
											</td>
										</tr>
										<tr>
											<td width='125' height='25' class='fonthead' nowrap>
											    <asp:label id="lblGridReadSQL" runat="server">Grid Read SQL</asp:label>
											</td>
											<td class='font'>
												<asp:textbox TextMode="MultiLine" Rows="4" Columns="20" id="txtGridReadSQL" runat="server" CssClass="font" Width="200px"></asp:textbox>
											</td>
										</tr>
										<tr>
											<td width='125' height='25' class='fonthead' nowrap>
											    <asp:label id="lblGridSQL" runat="server">Grid SQL</asp:label>
											</td>
											<td class='font'>
												<asp:textbox TextMode="MultiLine" Rows="4" Columns="20" id="txtGridSQL" runat="server" CssClass="font" Width="200px"></asp:textbox>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<br />
			<br />

            <telerik:RadScriptManager ID="RadScriptManager1" runat="server" >
                <Scripts>
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
                    <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
                </Scripts>
                <CdnSettings TelerikCdn="Disabled" />
            </telerik:RadScriptManager>
            <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" Runat="server">
                <StyleSheets>
                    <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
                    <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
                    <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
                    <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
                </StyleSheets>
                <CdnSettings TelerikCdn="Disabled" />
            </telerik:RadStyleSheetManager>
            <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1">
                <AjaxSettings>
                    <telerik:AjaxSetting AjaxControlID="grdColumnsSelector">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="grdColumnsSelector" />
                            <telerik:AjaxUpdatedControl ControlID="grdSelectedColumns" />
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                    <telerik:AjaxSetting AjaxControlID="grdSelectedColumns">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="grdColumnsSelector" />
                            <telerik:AjaxUpdatedControl ControlID="grdSelectedColumns" />
                            <telerik:AjaxUpdatedControl ControlID="grdValidatorsDefault" />
                            <telerik:AjaxUpdatedControl ControlID="grdValidatorsSearch" />
                            <telerik:AjaxUpdatedControl ControlID="txtDefaultXMLFileName" />
                            <telerik:AjaxUpdatedControl ControlID="txtSearchXMLFileName" />
                            <telerik:AjaxUpdatedControl ControlID="hdnColumnKey" />
                            <telerik:AjaxUpdatedControl ControlID="txtDefaultAlias" />
                            <telerik:AjaxUpdatedControl ControlID="ddlDefaultDataType" />
                            <telerik:AjaxUpdatedControl ControlID="ddlDefaultColumnType" />
                            <telerik:AjaxUpdatedControl ControlID="txtDefaultLookupQuery" />
                            <telerik:AjaxUpdatedControl ControlID="txtDefaultTextColumn" />
                            <telerik:AjaxUpdatedControl ControlID="txtDefaultValueColumn" />
                            <telerik:AjaxUpdatedControl ControlID="chkDefaultAutoPostBack" />
                            <telerik:AjaxUpdatedControl ControlID="chkDefaultAddNullField" />
                            <telerik:AjaxUpdatedControl ControlID="chkDefaultPK" />
                            <telerik:AjaxUpdatedControl ControlID="txtSearchAlias" />
                            <telerik:AjaxUpdatedControl ControlID="ddlSearchDataType" />
                            <telerik:AjaxUpdatedControl ControlID="ddlSearchColumnType" />
                            <telerik:AjaxUpdatedControl ControlID="txtSearchLookupQuery" />
                            <telerik:AjaxUpdatedControl ControlID="txtSearchTextColumn" />
                            <telerik:AjaxUpdatedControl ControlID="txtSearchValueColumn" />
                            <telerik:AjaxUpdatedControl ControlID="chkSearchAutoPostBack" />
                            <telerik:AjaxUpdatedControl ControlID="chkSearchAddNullField" />
                            <telerik:AjaxUpdatedControl ControlID="chkSearchPK" />
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                    <telerik:AjaxSetting AjaxControlID="grdValidatorsDefault">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="grdSelectedColumns" />
                            <telerik:AjaxUpdatedControl ControlID="grdValidatorsDefault" />
                            <telerik:AjaxUpdatedControl ControlID="grdValidatorsSearch" />
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                    <telerik:AjaxSetting AjaxControlID="grdValidatorsSearch">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="grdSelectedColumns" />
                            <telerik:AjaxUpdatedControl ControlID="grdValidatorsDefault" />
                            <telerik:AjaxUpdatedControl ControlID="grdValidatorsSearch" />
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                    <telerik:AjaxSetting AjaxControlID="txtDefaultXMLFileName">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="grdSelectedColumns" />
                            <telerik:AjaxUpdatedControl ControlID="txtDefaultXMLFileName" />
                            <telerik:AjaxUpdatedControl ControlID="txtSearchXMLFileName" />
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                    <telerik:AjaxSetting AjaxControlID="txtSearchXMLFileName">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="grdSelectedColumns" />
                            <telerik:AjaxUpdatedControl ControlID="txtDefaultXMLFileName" />
                            <telerik:AjaxUpdatedControl ControlID="txtSearchXMLFileName" />
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                    <telerik:AjaxSetting AjaxControlID="grdSelectedColumnsSelector">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="grdSelectedColumnsSelector" />
                            <telerik:AjaxUpdatedControl ControlID="grdColumn1" />
                            <telerik:AjaxUpdatedControl ControlID="grdColumn2" />
                            <telerik:AjaxUpdatedControl ControlID="grdColumn3" />
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                    <telerik:AjaxSetting AjaxControlID="grdColumn1">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="grdSelectedColumnsSelector" />
                            <telerik:AjaxUpdatedControl ControlID="grdColumn1" />
                            <telerik:AjaxUpdatedControl ControlID="grdColumn2" />
                            <telerik:AjaxUpdatedControl ControlID="grdColumn3" />
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                    <telerik:AjaxSetting AjaxControlID="grdColumn2">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="grdSelectedColumnsSelector" />
                            <telerik:AjaxUpdatedControl ControlID="grdColumn1" />
                            <telerik:AjaxUpdatedControl ControlID="grdColumn2" />
                            <telerik:AjaxUpdatedControl ControlID="grdColumn3" />
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                    <telerik:AjaxSetting AjaxControlID="grdColumn3">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="grdSelectedColumnsSelector" />
                            <telerik:AjaxUpdatedControl ControlID="grdColumn1" />
                            <telerik:AjaxUpdatedControl ControlID="grdColumn2" />
                            <telerik:AjaxUpdatedControl ControlID="grdColumn3" />
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                </AjaxSettings>
            </telerik:RadAjaxManager>
            <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
                <Windows>
                    <telerik:RadWindow ID="EditHeaderDialog" runat="server" Title="Dev Edit Header" Height="700px"
                        Width="1200px" ReloadOnShow="true" ShowContentDuringLoad="false" 
                        NavigateUrl="Control_SchemaEditor_EditHeader.aspx?ColumnKey="
                        Top="10px" Left="10px" RestrictionZoneID="TheWholeForm"
                        Behaviors="Close, Move, Resize, Maximize"
                        IconUrl="../System/Icons/icon_edit_file.gif"
                        KeepInScreenBounds="true" Modal="true" />
                    <telerik:RadWindow ID="EditRelatedTablesDialog" runat="server" Title="Dev Edit Related Tables" Height="700px"
                        Width="1200px" ReloadOnShow="true" ShowContentDuringLoad="false" 
                        NavigateUrl="Control_SchemaEditor_EditRelatedTables.aspx?ColumnKey="
                        Top="10px" Left="10px" RestrictionZoneID="TheWholeForm"
                        Behaviors="Close, Move, Resize, Maximize"
                        IconUrl="../System/Icons/icon_edit_file.gif"
                        KeepInScreenBounds="true" Modal="true" />
                    <telerik:RadWindow ID="EditColumnDialog" runat="server" Title="Dev Edit Column" Height="700px"
                        Width="1000px" ReloadOnShow="true" ShowContentDuringLoad="false" 
                        NavigateUrl="Control_SchemaEditor_EditColumn.aspx?ColumnKey="
                        Top="10px" Left="10px" RestrictionZoneID="TheWholeForm"
                        Behaviors="Close, Move, Resize, Maximize"
                        IconUrl="../System/Icons/icon_edit_file.gif"
                        KeepInScreenBounds="true" Modal="true" />
                    <telerik:RadWindow ID="EditValidatorsDialog" runat="server" Title="Dev Edit Validators" Height="700px"
                        Width="1100px" ReloadOnShow="true" ShowContentDuringLoad="false" 
                        NavigateUrl="Control_SchemaEditor_EditValidators.aspx?ColumnKey="
                        Top="10px" Left="10px" RestrictionZoneID="TheWholeForm"
                        Behaviors="Close, Move, Resize, Maximize"
                        IconUrl="../System/Icons/icon_edit_file.gif"
                        KeepInScreenBounds="true" Modal="true" />
                    <telerik:RadWindow ID="EditLookupTablesDialog" runat="server" Title="Dev Edit LookupTables" Height="700px"
                        Width="1100px" ReloadOnShow="true" ShowContentDuringLoad="false" 
                        NavigateUrl="Control_SchemaEditor_EditLookupTables.aspx?ColumnKey="
                        Top="10px" Left="10px" RestrictionZoneID="TheWholeForm"
                        Behaviors="Close, Move, Resize, Maximize"
                        IconUrl="../System/Icons/icon_edit_file.gif"
                        KeepInScreenBounds="true" Modal="true" />
                </Windows>
            </telerik:RadWindowManager>

            <script type="text/javascript">
                //<![CDATA[
                function ShowEditHeaderForm() {
                    window.radopen("<%=GetEditHeaderPopUpURL()%>", "EditHeaderDialog");
                }
                function ShowEditRelatedTablesForm() {
                    window.radopen("<%=GetEditRelatedTablesPopUpURL()%>", "EditRelatedTablesDialog");
                }
                function ShowEditColumnForm()
                {
                    var ColumnKey;
                    ColumnKey = document.getElementById('hdnColumnKey').value;
                    window.radopen("<%=GetEditColumnPopUpURL()%>&ColumnKey=" + ColumnKey, "EditColumnDialog");
                }
                function ShowEditValidatorsForm() {
                    var ColumnKey;
                    ColumnKey = document.getElementById('hdnColumnKey').value;
                    window.radopen("<%=GetEditValidatorsPopUpURL()%>&ColumnKey=" + ColumnKey, "EditValidatorsDialog");
                }
                function ShowEditLookupTablesForm() {
                    var ColumnKey;
                    ColumnKey = document.getElementById('hdnColumnKey').value;
                    window.radopen("<%=GetEditLookupTablesPopUpURL()%>&ColumnKey=" + ColumnKey, "EditLookupTablesDialog");
                }
                //]]>
            </script>

            <cc3:YSTabView ID="YSTabView1" StartTab="2" runat="server"></cc3:YSTabView>

            <asp:Panel runat="server" ID="pnlPerm" Visible="false">
		        <table style="height:50;" cellspacing="0" cellpadding="0" width="100%" bgcolor="#990000" border="1" bordercolor="red">
			        <tr>
				        <td>
                            <table style="height:25;" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td width="25"><div align="center"><asp:image id="Image1" ImageUrl="../System/Icons/icon_lock.gif" runat="server"></asp:image></div></td>
                                    <td><asp:Label ID="lblPerm" runat="server" Text="You might not have permission to edit schema files using your credentials." CssClass="fontHead" ForeColor="White"></asp:Label></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>			
	        </asp:Panel>

            <asp:Panel runat="server" ID="pnlSelectColumns" Visible="false">
                <telerik:RadSplitter ID="RadSplitter0" runat="server" Width="100%" Height="500">
                   <telerik:RadPane ID="LeftPane0" runat="server" Width="22px" Scrolling="none">
                        <telerik:RadSlidingZone ID="RadSlidingZone0" runat="server" Width="22px" ClickToOpen="false">
                            <telerik:RadSlidingPane ID="RadSlidingPane0" Title="Columns" runat="server" Width="200px" CssClass="rgHeaderYPLM" DockOnOpen="true">
                                <telerik:RadGrid runat="server" ID="grdColumnsSelector" OnNeedDataSource="grdColumnsSelector_NeedDataSource"
                                    AllowPaging="false" Width="100%" OnRowDrop="grdColumnsSelector_RowDrop" AllowMultiRowSelection="true" 
                                    HeaderStyle-CssClass="rgHeaderYPLM" ItemStyle-CssClass="rgRowYPLM" AlternatingItemStyle-CssClass="rgAltRowYPLM" 
                                    EnableEmbeddedSkins="false" Skin="YPLM" PageSize="30" Height="450" AutoGenerateColumns="false">
                                    <MasterTableView DataKeyNames="ColumnKey" Width="100%" TableLayout="Auto">
                                        <Columns>
                                            <telerik:GridDragDropColumn HeaderStyle-Width="18px" Visible="true" />
                                            <telerik:GridBoundColumn DataField="ColumnName" HeaderText="Name" UniqueName="ColumnName"/>
                                            <telerik:GridTemplateColumn HeaderText="Type" UniqueName="Type" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                                                <ItemTemplate>
                                                    <asp:Image ID="imgType" runat="server" />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                        <NoRecordsTemplate>
                                            <div style="height: 30px; cursor: pointer;"><%=GetSystemText("No items to view")%></div>
                                        </NoRecordsTemplate>
                                    </MasterTableView>
                                    <ClientSettings AllowRowsDragDrop="True">
                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="false" />
                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="320px" />
                                    </ClientSettings>
                                    <PagerStyle Mode="NumericPages" PageButtonCount="4" />
                                </telerik:RadGrid>
                            </telerik:RadSlidingPane>
                        </telerik:RadSlidingZone>
                    </telerik:RadPane>
                    
                    <telerik:RadSplitBar ID="RadSplitbar0" runat="server" CollapseMode="None" EnableResize="True" Width="20px"></telerik:RadSplitBar>
                    
                    <telerik:RadPane ID="RightPane0" runat="server" Width="100%">
			            <table width="100%" align="center">
				            <tr>
						        <td class="fontHead" align="center" width="1%">
							        <br />
						        </td>
					            <td align="center" width="33%">
					                <font face="Microsoft Sans Serif" color="#000000" size="2"><b class="fontHead"><asp:Label ID="lblSelectedColumns" runat="server"></asp:Label></b></font>
					            </td>
						        <td class="fontHead" align="center" width="3%"></td>
					            <td align="center" width="62%">
						            <table width="100%" align="center">
							            <tr>
					                        <td align="center" width="49%">
										        <font face="Microsoft Sans Serif" color="#000000" size="2"><b class="fontHead">
										        <asp:Label ID="lblSearchHeader1" runat="server">Default Column</asp:Label></b></font>
					                        </td>
						                    <td class="fontHead" align="center" width="2%">
							                    <br />
						                    </td>
					                        <td align="center" width="49%">
										        <font face="Microsoft Sans Serif" color="#000000" size="2"><b class="fontHead">
                                                <asp:Label ID="lblSearchHeader2" runat="server">Search Column</asp:Label></b></font>
					                        </td>
							            </tr>
						            </table>
					            </td>
						        <td class="fontHead" align="center" width="1%">
							        <br />
						        </td>
				            </tr>
				            <tr>
						        <td class="fontHead" align="center" width="1%">
							        <br />
						        </td>
					            <td align="center" valign="top" width="33%">
                                    <telerik:RadGrid runat="server" ID="grdSelectedColumns" OnNeedDataSource="grdSelectedColumns_NeedDataSource"
                                        AllowPaging="false" OnRowDrop="grdSelectedColumns_RowDrop" AllowMultiRowSelection="true" 
                                        HeaderStyle-CssClass="rgHeaderYPLM" ItemStyle-CssClass="rgRowYPLM" AlternatingItemStyle-CssClass="rgAltRowYPLM" 
                                        EnableEmbeddedSkins="false" Skin="YPLM" PageSize="30" Height="440" AutoGenerateColumns="false">
                                        <MasterTableView DataKeyNames="ColumnKey" Width="100%" TableLayout="Fixed">
                                            <Columns>
                                                <telerik:GridDragDropColumn HeaderStyle-Width="18px" Visible="true" />
                                                <telerik:GridBoundColumn DataField="ColumnName" HeaderText="Name" UniqueName="ColumnName"/>
                                                <telerik:GridTemplateColumn HeaderText="Type" UniqueName="Type" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                                                    <ItemTemplate>
                                                        <asp:Image ID="imgType" runat="server" />
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                            <NoRecordsTemplate>
                                                <div style="height: 30px; cursor: pointer;"><%=GetSystemText("No items to view")%></div>
                                            </NoRecordsTemplate>
                                        </MasterTableView>
                                        <ClientSettings EnablePostBackOnRowClick="true" AllowRowsDragDrop="true">
                                            <Selecting AllowRowSelect="true" EnableDragToSelectRows="false" />
                                            <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="320px" />
                                        </ClientSettings>
                                        <PagerStyle Visible="false" Mode="NumericPages" PageButtonCount="4" />
                                    </telerik:RadGrid>
					            </td>
						        <td class="fontHead" align="center" width="3%">
							        <br />
						        </td>
                                <td align="center" valign="top" width="62%">
						            <table bgcolor="#FFFFFF" width="100%">
							            <tr valign='top'>
								            <td width='49%'>
									            <table width='100%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
										            <tr>
											            <td width='125' class='fonthead' nowrap>
											                <asp:label id="lblDefaultAlias" runat="server"><%=GetSystemText("Alias")%></asp:label>
											            </td>
											            <td class='font'>
												            <asp:textbox id="txtDefaultAlias" runat="server" CssClass="font" Width="150px"></asp:textbox>
											            </td>
										            </tr>
										            <tr>
											            <td width='125' class='fonthead' nowrap>
											                <asp:label id="lblDefaultPK" runat="server"><%=GetSystemText("Primary Key")%></asp:label>
											            </td>
											            <td class='font'>
											                <asp:CheckBox ID="chkDefaultPK" runat="server" CssClass="font" />
											            </td>
										            </tr>
										            <tr>
											            <td width='125' class='fonthead' nowrap>
											                <asp:label id="lblDefaultColumnType" runat="server"><%=GetSystemText("Column Type")%></asp:label>
											            </td>
											            <td class='font'>
												            <asp:DropDownList ID="ddlDefaultColumnType" runat="server" AutoPostBack="true" Width="150px">
												            </asp:DropDownList>
											            </td>
										            </tr>
										            <tr>
											            <td width='125' class='fonthead' nowrap>
											                <asp:label id="lblDefaultDataType" runat="server"><%=GetSystemText("Data Type")%></asp:label>
											            </td>
											            <td class='font'>
												            <asp:DropDownList ID="ddlDefaultDataType" runat="server" AutoPostBack="true" Width="150px">
												            </asp:DropDownList>
											            </td>
										            </tr>
										            <tr>
											            <td width='125' class='fonthead' nowrap>
											                <asp:label id="lblDefaultLookupQuery" runat="server"><%=GetSystemText("Lookup Query")%></asp:label>
											            </td>
											            <td class='font'>
												            <asp:textbox id="txtDefaultLookupQuery" runat="server" CssClass="font" Width="150px"></asp:textbox>
											            </td>
										            </tr>
										            <tr>
											            <td width='125' class='fonthead' nowrap>
											                <asp:label id="lblDefaultValueColumn" runat="server"><%=GetSystemText("Value Column")%></asp:label>
											            </td>
											            <td class='font'>
												            <asp:textbox id="txtDefaultValueColumn" runat="server" CssClass="font" Width="150px"></asp:textbox>
											            </td>
										            </tr>
										            <tr>
											            <td width='125' class='fonthead' nowrap>
											                <asp:label id="lblDefaultTextColumn" runat="server"><%=GetSystemText("Text Column")%></asp:label>
											            </td>
											            <td class='font'>
												            <asp:textbox id="txtDefaultTextColumn" runat="server" CssClass="font" Width="150px"></asp:textbox>
											            </td>
										            </tr>
										            <tr>
											            <td width='125' class='fonthead' nowrap>
											                <asp:label id="lblDefaultAutoPostBack" runat="server"><%=GetSystemText("Auto Post Back")%></asp:label>
											            </td>
											            <td class='font'>
											                <asp:CheckBox ID="chkDefaultAutoPostBack" runat="server" CssClass="font" />
											            </td>
										            </tr>
										            <tr>
											            <td width='125' class='fonthead' nowrap>
											                <asp:label id="lblDefaultAddNullField" runat="server"><%=GetSystemText("Add NULL Field")%></asp:label>
											            </td>
											            <td class='font'>
											                <asp:CheckBox ID="chkDefaultAddNullField" runat="server" CssClass="font" />
												            <asp:HiddenField ID="hdnColumnKey" runat="server" />
											            </td>
										            </tr>
									            </table>
								            </td>
						                    <td class="fontHead" align="center" width="2%">
							                    <br />
						                    </td>
								            <td width='49%'>
									            <table width='100%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
										            <tr>
											            <td width='125' class='fonthead' nowrap>
											                <asp:label id="lblSearchAlias" runat="server"><%=GetSystemText("Alias")%></asp:label>
											            </td>
											            <td class='font'>
												            <asp:textbox id="txtSearchAlias" runat="server" CssClass="font" Width="150px"></asp:textbox>
											            </td>
										            </tr>
										            <tr>
											            <td width='125' class='fonthead' nowrap>
											                <asp:label id="lblSearchPK" runat="server"><%=GetSystemText("Primary Key")%></asp:label>
											            </td>
											            <td class='font'>
											                <asp:CheckBox ID="chkSearchPK" runat="server" CssClass="font" />
											            </td>
										            </tr>
										            <tr>
											            <td width='125' class='fonthead' nowrap>
											                <asp:label id="lblSearchColumnType" runat="server"><%=GetSystemText("Column Type")%></asp:label>
											            </td>
											            <td class='font'>
												            <asp:DropDownList ID="ddlSearchColumnType" runat="server" AutoPostBack="true" Width="150px">
												            </asp:DropDownList>
											            </td>
										            </tr>
										            <tr>
											            <td width='125' class='fonthead' nowrap>
											                <asp:label id="lblSearchDataType" runat="server"><%=GetSystemText("Data Type")%></asp:label>
											            </td>
											            <td class='font'>
												            <asp:DropDownList ID="ddlSearchDataType" runat="server" AutoPostBack="true" Width="150px">
												            </asp:DropDownList>
											            </td>
										            </tr>
										            <tr>
											            <td width='125' class='fonthead' nowrap>
											                <asp:label id="lblSearchLookupQuery" runat="server"><%=GetSystemText("Lookup Query")%></asp:label>
											            </td>
											            <td class='font'>
												            <asp:textbox id="txtSearchLookupQuery" runat="server" CssClass="font" Width="150px"></asp:textbox>
											            </td>
										            </tr>
										            <tr>
											            <td width='125' class='fonthead' nowrap>
											                <asp:label id="lblSearchValueolumn" runat="server"><%=GetSystemText("Value Column")%></asp:label>
											            </td>
											            <td class='font'>
												            <asp:textbox id="txtSearchValueColumn" runat="server" CssClass="font" Width="150px"></asp:textbox>
											            </td>
										            </tr>
										            <tr>
											            <td width='125' class='fonthead' nowrap>
											                <asp:label id="lblSearchTextColumn" runat="server"><%=GetSystemText("Text Column")%></asp:label>
											            </td>
											            <td class='font'>
												            <asp:textbox id="txtSearchTextColumn" runat="server" CssClass="font" Width="150px"></asp:textbox>
											            </td>
										            </tr>
										            <tr>
											            <td width='125' class='fonthead' nowrap>
											                <asp:label id="lblSearchAutoPostBack" runat="server"><%=GetSystemText("Auto Post Back")%></asp:label>
											            </td>
											            <td class='font'>
											                <asp:CheckBox ID="chkSearchAutoPostBack" runat="server" CssClass="font" />
											            </td>
										            </tr>
										            <tr>
											            <td width='125' class='fonthead' nowrap>
											                <asp:label id="lblSearchAddNullField" runat="server"><%=GetSystemText("Add NULL Field")%></asp:label>
											            </td>
											            <td class='font'>
											                <asp:CheckBox ID="chkSearchAddNullField" runat="server" CssClass="font" />
											            </td>
										            </tr>
									            </table>
								            </td>
							            </tr>

							            <tr valign='top'>
						                    <td class="fontHead" align="center" colspan="3">
											    <asp:Button runat="server" ID="btnEditColumn" Visible="true" OnClientClick="ShowEditColumnForm(); return false;" Text="edit column" Height="24px" Width="98%" />
						                    </td>
							            </tr>

							            <tr valign='top'>
						                    <td class="fontHead" align="center" colspan="3">
							                    <br />
						                    </td>
							            </tr>

							            <tr>
					                        <td align="center" width="49%">
										        <font face="Microsoft Sans Serif" color="#000000" size="2"><b class="fontHead">
										        <asp:Label ID="lblSearchHeader3" runat="server">Default Validators</asp:Label></b></font>
					                        </td>
						                    <td class="fontHead" align="center" width="2%">
							                    <br />
						                    </td>
					                        <td align="center" width="49%">
										        <font face="Microsoft Sans Serif" color="#000000" size="2"><b class="fontHead">
                                                <asp:Label ID="lblSearchHeader4" runat="server">Search Validators</asp:Label></b></font>
					                        </td>
							            </tr>

							            <tr>
					                        <td align="center" width="49%">
                                                <telerik:RadGrid runat="server" ID="grdValidatorsDefault" OnNeedDataSource="grdValidatorsDefault_NeedDataSource"
                                                    AllowPaging="false" AllowMultiRowSelection="false" ShowHeader="false"
                                                    ItemStyle-CssClass="rgRowYPLM" AlternatingItemStyle-CssClass="rgAltRowYPLM" 
                                                    EnableEmbeddedSkins="false" Skin="YPLM" PageSize="30" Height="60" AutoGenerateColumns="false">
                                                    <MasterTableView DataKeyNames="ValidatorID" Width="100%" TableLayout="Fixed">
                                                        <Columns>
                                                            <telerik:GridBoundColumn DataField="Class" HeaderText="Class" UniqueName="Class"/>
<%--
                                                            <telerik:GridBoundColumn DataField="Type" HeaderText="Type" UniqueName="Type"/>
                                                            <telerik:GridBoundColumn DataField="Minimum" HeaderText="Minimum" UniqueName="Minimum"/>
                                                            <telerik:GridBoundColumn DataField="Maximum" HeaderText="Maximum" UniqueName="Maximum"/>
                                                            <telerik:GridBoundColumn DataField="Text" HeaderText="Text" UniqueName="Text"/>
                                                            <telerik:GridBoundColumn DataField="Dataformat" HeaderText="Dataformat" UniqueName="Dataformat"/>
--%>
                                                        </Columns>
                                                        <NoRecordsTemplate>
                                                            <div style="height: 30px; cursor: pointer;"><%=GetSystemText("No items to view")%></div>
                                                        </NoRecordsTemplate>
                                                        <ItemTemplate>
                                                            <asp:Panel ID="ItemContainer" CssClass='<%# IIf(CType(Container, GridItem).ItemType = GridItemType.Item, "rgRowYPLM", "rgAltRowYPLM") %>' runat="server">
                                                                <table border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td><b><%=GetSystemText("Class")%></b></td>
                                                                        <td>&nbsp;<%#Eval("Class")%></td>
                                                                    </tr>
<%--
                                                                    <tr>
                                                                        <td><b><%=GetSystemText("Type")%></b></td>
                                                                        <td>&nbsp;<%#Eval("Type")%></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td><b><%=GetSystemText("Minimum")%></b></td>
                                                                        <td>&nbsp;<%#Eval("Minimum")%></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td><b><%=GetSystemText("Maximum")%></b></td>
                                                                        <td>&nbsp;<%#Eval("Maximum")%></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td><b><%=GetSystemText("Text")%></b></td>
                                                                        <td>&nbsp;<%#Eval("Text")%></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td><b><%=GetSystemText("Data Format")%></b></td>
                                                                        <td>&nbsp;<%#Eval("Dataformat")%></td>
                                                                    </tr>
--%>
                                                                </table>
                                                            </asp:Panel>
                                                        </ItemTemplate>
                                                    </MasterTableView>
                                                    <ClientSettings EnablePostBackOnRowClick="false" AllowRowsDragDrop="false">
                                                        <Selecting AllowRowSelect="false" EnableDragToSelectRows="false" />
                                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="120px" />
                                                    </ClientSettings>
                                                    <PagerStyle Visible="false" Mode="NumericPages" PageButtonCount="4" />
                                                </telerik:RadGrid>
					                        </td>
						                    <td class="fontHead" align="center" width="2%">
							                    <br />
						                    </td>
					                        <td align="center" width="49%">
                                                <telerik:RadGrid runat="server" ID="grdValidatorsSearch" OnNeedDataSource="grdValidatorsSearch_NeedDataSource"
                                                    AllowPaging="false" AllowMultiRowSelection="false" ShowHeader="false"
                                                    ItemStyle-CssClass="rgRowYPLM" AlternatingItemStyle-CssClass="rgAltRowYPLM" 
                                                    EnableEmbeddedSkins="false" Skin="YPLM" PageSize="30" Height="60" AutoGenerateColumns="false">
                                                    <MasterTableView DataKeyNames="ValidatorID" Width="100%" TableLayout="Fixed">
                                                        <Columns>
                                                            <telerik:GridBoundColumn DataField="Class" HeaderText="Class" UniqueName="Class"/>
<%--
                                                            <telerik:GridBoundColumn DataField="Type" HeaderText="Type" UniqueName="Type"/>
                                                            <telerik:GridBoundColumn DataField="Minimum" HeaderText="Minimum" UniqueName="Minimum"/>
                                                            <telerik:GridBoundColumn DataField="Maximum" HeaderText="Maximum" UniqueName="Maximum"/>
                                                            <telerik:GridBoundColumn DataField="Text" HeaderText="Text" UniqueName="Text"/>
                                                            <telerik:GridBoundColumn DataField="Dataformat" HeaderText="Dataformat" UniqueName="Dataformat"/>
--%>
                                                        </Columns>
                                                        <NoRecordsTemplate>
                                                            <div style="height: 30px; cursor: pointer;"><%=GetSystemText("No items to view")%></div>
                                                        </NoRecordsTemplate>
                                                        <ItemTemplate>
                                                            <asp:Panel ID="ItemContainer" CssClass='<%# IIf(CType(Container, GridItem).ItemType = GridItemType.Item, "rgRowYPLM", "rgAltRowYPLM") %>' runat="server">
                                                                <table border="0" cellspacing="0" cellpadding="0">
                                                                    <tr>
                                                                        <td><b><%=GetSystemText("Class")%></b></td>
                                                                        <td>&nbsp;<%#Eval("Class")%></td>
                                                                    </tr>
<%--
                                                                    <tr>
                                                                        <td><b><%=GetSystemText("Type")%></b></td>
                                                                        <td>&nbsp;<%#Eval("Type")%></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td><b><%=GetSystemText("Minimum")%></b></td>
                                                                        <td>&nbsp;<%#Eval("Minimum")%></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td><b><%=GetSystemText("Maximum")%></b></td>
                                                                        <td>&nbsp;<%#Eval("Maximum")%></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td><b><%=GetSystemText("Text")%></b></td>
                                                                        <td>&nbsp;<%#Eval("Text")%></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td><b><%=GetSystemText("Data Format")%></b></td>
                                                                        <td>&nbsp;<%#Eval("Dataformat")%></td>
                                                                    </tr>
--%>
                                                                </table>
                                                            </asp:Panel>
                                                        </ItemTemplate>
                                                    </MasterTableView>
                                                    <ClientSettings EnablePostBackOnRowClick="false" AllowRowsDragDrop="false">
                                                        <Selecting AllowRowSelect="false" EnableDragToSelectRows="false" />
                                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="120px" />
                                                    </ClientSettings>
                                                    <PagerStyle Visible="false" Mode="NumericPages" PageButtonCount="4" />
                                                </telerik:RadGrid>
					                        </td>
							            </tr>

							            <tr valign='top'>
						                    <td class="fontHead" align="center" colspan="3">
											    <asp:Button runat="server" ID="btnEditValidators" Visible="true" OnClientClick="ShowEditValidatorsForm(); return false;" Text="edit validators" Height="24px" Width="98%" />
						                    </td>
							            </tr>

							            <tr valign='top'>
						                    <td class="fontHead" align="center" colspan="3">
							                    <br />
						                    </td>
							            </tr>

							            <tr>
					                        <td align="center" width="49%">
										        <font face="Microsoft Sans Serif" color="#000000" size="2"><b class="fontHead">
										        <asp:Label ID="lblSearchHeader5" runat="server">Default Lookup Table</asp:Label></b></font>
					                        </td>
						                    <td class="fontHead" align="center" width="2%">
							                    <br />
						                    </td>
					                        <td align="center" width="49%">
										        <font face="Microsoft Sans Serif" color="#000000" size="2"><b class="fontHead">
                                                <asp:Label ID="lblSearchHeader6" runat="server">Search Lookup Table</asp:Label></b></font>
					                        </td>
							            </tr>

							            <tr>
					                        <td align="center" width="49%">
									            <table width='100%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
										            <tr>
											            <td width='125' class='fonthead' nowrap>
											                <asp:label id="lblDefaultXMLFileName" runat="server"><%=GetSystemText("XMLFileName")%></asp:label>
											            </td>
											            <td class='font'>
												            <asp:textbox id="txtDefaultXMLFileName" runat="server" CssClass="font" Width="150px"></asp:textbox>
											            </td>
										            </tr>
									            </table>
					                        </td>
						                    <td class="fontHead" align="center" width="2%">
							                    <br />
						                    </td>
					                        <td align="center" width="49%">
									            <table width='100%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
										            <tr>
											            <td width='125' class='fonthead' nowrap>
											                <asp:label id="lblSearchXMLFileName" runat="server"><%=GetSystemText("XMLFileName")%></asp:label>
											            </td>
											            <td class='font'>
												            <asp:textbox id="txtSearchXMLFileName" runat="server" CssClass="font" Width="150px"></asp:textbox>
											            </td>
										            </tr>
									            </table>
					                        </td>
							            </tr>

							            <tr valign='top'>
						                    <td class="fontHead" align="center" colspan="3">
											    <asp:Button runat="server" ID="btnEditLookupTables" Visible="true" OnClientClick="ShowEditLookupTablesForm(); return false;" Text="Edit Lookup Table" Height="24px" Width="98%" />
						                    </td>
							            </tr>
						            </table>
					            </td>
						        <td class="fontHead" align="center" width="1%">
							        <br />
						        </td>
				            </tr>
			            </table>
                    </telerik:RadPane>
                </telerik:RadSplitter>
	        </asp:Panel>

            <asp:Panel runat="server" ID="pnlColumns" Visible="true">
                <telerik:RadSplitter ID="RadSplitter1" runat="server" Width="100%" Height="500">
                   <telerik:RadPane ID="LeftPane1" runat="server" Width="22px" Scrolling="none">
                        <telerik:RadSlidingZone ID="RadSlidingZone1" runat="server" Width="22px" ClickToOpen="false">
                            <telerik:RadSlidingPane ID="RadSlidingPane1" Title="Columns" runat="server" Width="200px" CssClass="rgHeaderYPLM" DockOnOpen="true">
                                <telerik:RadGrid runat="server" ID="grdSelectedColumnsSelector" OnNeedDataSource="grdSelectedColumnsSelector_NeedDataSource"
                                    AllowPaging="false" Width="100%" OnRowDrop="grdSelectedColumnsSelector_RowDrop" AllowMultiRowSelection="true" 
                                    HeaderStyle-CssClass="rgHeaderYPLM" ItemStyle-CssClass="rgRowYPLM" AlternatingItemStyle-CssClass="rgAltRowYPLM" 
                                    EnableEmbeddedSkins="false" Skin="YPLM" PageSize="30" Height="450" AutoGenerateColumns="false">
                                    <MasterTableView DataKeyNames="ColumnKey" Width="100%" TableLayout="Auto">
                                        <Columns>
                                            <telerik:GridDragDropColumn HeaderStyle-Width="18px" Visible="true" />
                                            <telerik:GridBoundColumn DataField="ColumnKey" HeaderText="Column Key" UniqueName="ColumnKey" Visible="false"/>
                                            <telerik:GridBoundColumn DataField="ColumnName" HeaderText="Name" UniqueName="ColumnName"/>
                                            <telerik:GridBoundColumn DataField="ColumnType" HeaderText="Column Type" UniqueName="ColumnType" Visible="false"/>
                                            <telerik:GridBoundColumn DataField="Custom" HeaderText="Custom" UniqueName="Custom" Visible="false"/>
                                            <telerik:GridTemplateColumn HeaderText="Type" UniqueName="Type" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                                                <ItemTemplate>
                                                    <asp:Image ID="imgType" runat="server" />
                                                </ItemTemplate>
                                            </telerik:GridTemplateColumn>
                                        </Columns>
                                        <NoRecordsTemplate>
                                            <div style="height: 30px; cursor: pointer;"><%=GetSystemText("No items to view")%></div>
                                        </NoRecordsTemplate>
                                    </MasterTableView>
                                    <ClientSettings AllowRowsDragDrop="True">
                                        <Selecting AllowRowSelect="True" EnableDragToSelectRows="false" />
                                        <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="320px" />
                                    </ClientSettings>
                                    <PagerStyle Mode="NumericPages" PageButtonCount="4" />
                                </telerik:RadGrid>
                            </telerik:RadSlidingPane>
                        </telerik:RadSlidingZone>
                    </telerik:RadPane>
                    
                    <telerik:RadSplitBar ID="RadSplitbar1" runat="server" CollapseMode="None" EnableResize="True" Width="20px"></telerik:RadSplitBar>
                    
                    <telerik:RadPane ID="RightPane1" runat="server" Width="100%">
			            <table width="100%" align="center">
				            <tr>
						        <td class="fontHead" align="center" width="1%">
						        </td>
					            <td align="center" width="30%">
					                <font face="Microsoft Sans Serif" color="#000000" size="2"><b class="fontHead"><asp:Label ID="lblColumn1" runat="server"></asp:Label></b></font>
					            </td>
						        <td class="fontHead" align="center" width="3%">
						        </td>
					            <td align="center" width="30%">
					                <font face="Microsoft Sans Serif" color="#000000" size="2"><b class="fontHead"><asp:Label ID="lblColumn2" runat="server"></asp:Label></b></font>
					            </td>
						        <td class="fontHead" align="center" width="3%">
						        </td>
					            <td align="center" width="30%">
					                <font face="Microsoft Sans Serif" color="#000000" size="2"><b class="fontHead"><asp:Label ID="lblColumn3" runat="server"></asp:Label></b></font>
					            </td>
						        <td class="fontHead" align="center" width="1%">
						        </td>
				            </tr>
				            <tr>
						        <td class="fontHead" align="center" width="1%">
							        <br />
						        </td>
					            <td align="center" valign="middle" width="30%">
                                    <telerik:RadGrid runat="server" ID="grdColumn1" OnNeedDataSource="grdColumn1_NeedDataSource"
                                        AllowPaging="false" OnRowDrop="grdColumn1_RowDrop" AllowMultiRowSelection="true" 
                                        HeaderStyle-CssClass="rgHeaderYPLM" ItemStyle-CssClass="rgRowYPLM" AlternatingItemStyle-CssClass="rgAltRowYPLM" 
                                        EnableEmbeddedSkins="false" Skin="YPLM" PageSize="30" Height="440" AutoGenerateColumns="false">
                                        <MasterTableView DataKeyNames="ColumnKey" Width="100%" TableLayout="Auto">
                                            <Columns>
                                                <telerik:GridDragDropColumn HeaderStyle-Width="18px" Visible="true" />
                                                <telerik:GridBoundColumn DataField="ColumnKey" HeaderText="Column Key" UniqueName="ColumnKey" Visible="false"/>
                                                <telerik:GridBoundColumn DataField="ColumnName" HeaderText="Name" UniqueName="ColumnName"/>
                                                <telerik:GridBoundColumn DataField="ColumnType" HeaderText="Column Type" UniqueName="ColumnType" Visible="false"/>
                                                <telerik:GridBoundColumn DataField="Custom" HeaderText="Custom" UniqueName="Custom" Visible="false"/>
                                                <telerik:GridTemplateColumn HeaderText="Type" UniqueName="Type" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                                                    <ItemTemplate>
                                                        <asp:Image ID="imgType" runat="server" />
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                            <NoRecordsTemplate>
                                                <div style="height: 30px; cursor: pointer;"><%=GetSystemText("No items to view")%></div>
                                            </NoRecordsTemplate>
                                        </MasterTableView>
                                        <ClientSettings AllowRowsDragDrop="True">
                                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="false" />
                                            <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="320px" />
                                        </ClientSettings>
                                        <PagerStyle Mode="NumericPages" PageButtonCount="4" />
                                    </telerik:RadGrid>
					            </td>
						        <td class="fontHead" align="center" width="3%">
							        <br />
						        </td>
					            <td align="center" valign="middle" width="30%">
                                    <telerik:RadGrid runat="server" ID="grdColumn2" OnNeedDataSource="grdColumn2_NeedDataSource"
                                        AllowPaging="false" OnRowDrop="grdColumn2_RowDrop" AllowMultiRowSelection="true"
                                        HeaderStyle-CssClass="rgHeaderYPLM" ItemStyle-CssClass="rgRowYPLM" AlternatingItemStyle-CssClass="rgAltRowYPLM" 
                                        EnableEmbeddedSkins="false" Skin="YPLM" PageSize="30" Height="440" AutoGenerateColumns="false">
                                        <MasterTableView DataKeyNames="ColumnKey" Width="100%" TableLayout="Auto">
                                            <Columns>
                                                <telerik:GridDragDropColumn HeaderStyle-Width="18px" Visible="true" />
                                                <telerik:GridBoundColumn DataField="ColumnKey" HeaderText="Column Key" UniqueName="ColumnKey" Visible="false"/>
                                                <telerik:GridBoundColumn DataField="ColumnName" HeaderText="Name" UniqueName="ColumnName"/>
                                                <telerik:GridBoundColumn DataField="ColumnType" HeaderText="Column Type" UniqueName="ColumnType" Visible="false"/>
                                                <telerik:GridBoundColumn DataField="Custom" HeaderText="Custom" UniqueName="Custom" Visible="false"/>
                                                <telerik:GridTemplateColumn HeaderText="Type" UniqueName="Type" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                                                    <ItemTemplate>
                                                        <asp:Image ID="imgType" runat="server" />
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                            <NoRecordsTemplate>
                                                <div style="height: 30px; cursor: pointer;"><%=GetSystemText("No items to view")%></div>
                                            </NoRecordsTemplate>
                                        </MasterTableView>
                                        <ClientSettings AllowRowsDragDrop="True">
                                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="false" />
                                            <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="320px" />
                                        </ClientSettings>
                                        <PagerStyle Mode="NumericPages" PageButtonCount="4" />
                                    </telerik:RadGrid>
					            </td>
						        <td class="fontHead" align="center" width="3%">
							        <br />
						        </td>
					            <td align="center" valign="middle" width="30%">
                                    <telerik:RadGrid runat="server" ID="grdColumn3" OnNeedDataSource="grdColumn3_NeedDataSource"
                                        AllowPaging="false" OnRowDrop="grdColumn3_RowDrop" AllowMultiRowSelection="true"
                                        HeaderStyle-CssClass="rgHeaderYPLM" ItemStyle-CssClass="rgRowYPLM" AlternatingItemStyle-CssClass="rgAltRowYPLM" 
                                        EnableEmbeddedSkins="false" Skin="YPLM" PageSize="30" Height="450" AutoGenerateColumns="false">
                                        <MasterTableView DataKeyNames="ColumnKey" Width="100%" TableLayout="Auto">
                                            <Columns>
                                                <telerik:GridDragDropColumn HeaderStyle-Width="18px" Visible="true" />
                                                <telerik:GridBoundColumn DataField="ColumnKey" HeaderText="Column Key" UniqueName="ColumnKey" Visible="false"/>
                                                <telerik:GridBoundColumn DataField="ColumnName" HeaderText="Name" UniqueName="ColumnName"/>
                                                <telerik:GridBoundColumn DataField="ColumnType" HeaderText="Column Type" UniqueName="ColumnType" Visible="false"/>
                                                <telerik:GridBoundColumn DataField="Custom" HeaderText="Custom" UniqueName="Custom" Visible="false"/>
                                                <telerik:GridTemplateColumn HeaderText="Type" UniqueName="Type" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px">
                                                    <ItemTemplate>
                                                        <asp:Image ID="imgType" runat="server" />
                                                    </ItemTemplate>
                                                </telerik:GridTemplateColumn>
                                            </Columns>
                                            <NoRecordsTemplate>
                                                <div style="height: 30px; cursor: pointer;"><%=GetSystemText("No items to view")%></div>
                                            </NoRecordsTemplate>
                                        </MasterTableView>
                                        <ClientSettings AllowRowsDragDrop="True">
                                            <Selecting AllowRowSelect="True" EnableDragToSelectRows="false" />
                                            <Scrolling AllowScroll="true" UseStaticHeaders="true" ScrollHeight="320px" />
                                        </ClientSettings>
                                        <PagerStyle Mode="NumericPages" PageButtonCount="4" />
                                    </telerik:RadGrid>
					            </td>
						        <td class="fontHead" align="center" width="1%">
							        <br />
						        </td>
				            </tr>
			            </table>
                    </telerik:RadPane>
                </telerik:RadSplitter>
	        </asp:Panel>
        </div>
		</form>
	</body>
</html>
