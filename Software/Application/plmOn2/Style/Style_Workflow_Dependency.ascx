<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Style_Workflow_Dependency.ascx.vb" Inherits="plmOnApp.Style_Workflow_Dependency" %>

    <style type="text/css">
        .loading
        {
            background-color: #fff;
            height:100%;
            width:100%;
        }
        .WorkflowMessage
        {
            font-weight: bold;
            color: Red;
        }
    </style>
    
    <script language="javascript" src="../System/Jscript/jsganttActualDates.js"></script>

    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="Panel1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="Panel1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>    
    </telerik:RadAjaxManagerProxy>

    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            function RowSelected(sender, eventArgs) {
                var rowElement = eventArgs.get_gridDataItem().get_element();
                var className = rowElement.className;
                if (className.indexOf("rgRow") != -1) {
                    rowElement.className = "rgRow";
                }
                else {
                    rowElement.className = "rgAltRow";
                }
            }
        </script>
    </telerik:RadCodeBlock>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Transparency="20">
        <div class="loading">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/System/Images/loading1.gif" AlternateText="loading" />
        </div>
    </telerik:RadAjaxLoadingPanel>

    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel2" runat="server" Transparency="20">
        <div class="loading">
            <asp:Image ID="Image2" runat="server" ImageUrl="~/System/Images/loading1.gif" AlternateText="loading" />
        </div>
    </telerik:RadAjaxLoadingPanel>

    <div style="background-color: White;">
        <div id="GanttChartDIV"></div>
    </div>
   
    <script type='text/javascript' language='javascript'>
        var g = new JSGantt.GanttChart('g', document.getElementById('GanttChartDIV'), 'day');

        g.setShowRes(0); // Show/Hide Responsible (0/1)
        g.setShowDur(1); // Show/Hide Duration (0/1)
        g.setShowComp(0); // Show/Hide % Complete(0/1)
        g.setCaptionType('None');  // Set to Show Caption (None,Caption,Resource,Duration,Complete)
    </script>
    
    <div class="WorkflowMessage"><asp:Label ID="lblWorkflowMessage" runat="server"></asp:Label></div>
    
    <table cellSpacing="2" cellPadding="0" width="100%" border="0" bgcolor="#FFFFFF">
      <tr>
        <td>

          <table bgcolor='#FFFFFF' width='100%' border='0' cellspacing='1' cellpadding='0' style="margin-left: 10px;">
            <tr valign='top'>
              <td width='33%'>
                <table width='100%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
                  <tr>
                    <td width='125' height='25' class='fonthead' nowrap><span id="lblActive"><%=GetSystemText("Enforce Dependency")%></span></td>
                    <td class='font'><asp:CheckBox ID="chkEnforceDependency" runat="server" Checked="true" AutoPostBack="true" /></td>
                  </tr>
                </table>
              </td>
              <td width='33%'>
                <table width='100%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
                  <tr>
                    <td width='125' height='25' class='fonthead' nowrap><span id="lblTemplateName"><%=GetSystemText("Schedule By")%></span></td>
                    <td class='font'>
                      <asp:RadioButtonList ID="rblDateInd" runat="server" RepeatDirection="Horizontal" AutoPostBack="true">
                        <asp:ListItem Value="S"></asp:ListItem>
                        <asp:ListItem Value="D" Selected="True"></asp:ListItem>
                      </asp:RadioButtonList>
                    </td>
                  </tr>
                </table>
              </td>
              <td width='33%'>
                 <table width='100%' bordercolor='#CCCCCC'  border='0' cellspacing='0' cellpadding='0'>
                   <tr>
                     <td></td>
                   </tr>
                 </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    

    <asp:Panel ID="Panel1" runat="server" Width="100%">
    
    
    <telerik:RadGrid ID="dgrGanttTasks" ShowStatusBar="True" runat="server" Width="100%"
        AutoGenerateColumns="False" AllowSorting="false" AllowPaging="false" GridLines="None"
        CellSpacing="0" OnPreRender="dgrGanttTasks_PreRender"
        OnItemDataBound="dgrGanttTasks_OnItemDataBoundHandler" OnNeedDataSource="dgrGanttTasks_NeedDataSource"
        OnRowDrop="dgrGanttTasks_RowDrop">
        <FilterMenu EnableImageSprites="False">
        </FilterMenu>
        <ClientSettings>
            <Selecting CellSelectionMode="None"></Selecting>
        </ClientSettings>
        <PagerStyle Mode="NumericPages"></PagerStyle>
        <MasterTableView AllowMultiColumnSorting="false" DataKeyNames="WorkflowTemplateID, WorkflowTemplateItemID, WorkflowStatusImage, WorkflowStatus, RequirementNum, WorkflowAccessTypeDesc, PlannedStartDate, PlannedDueDate, PlannedWorkDays, ActualStartDate, ActualDueDate, ActualWorkDays, WorkAssignedTo, WorkEscalateTo, WorkflowAlerts"
            CommandItemDisplay="Top" HierarchyLoadMode="Client" CommandItemSettings-ShowRefreshButton="false" CommandItemSettings-ShowAddNewRecordButton="false">
            <NestedViewTemplate>
                <asp:Panel runat="server" ID="InnerContainer">

                    <%--requirements datagrid--%>
                    <telerik:RadGrid runat="server" ID="dgrRequirements" OnNeedDataSource="dgrRequirements_NeedDataSource"
                        GridLines="None" AutoGenerateColumns="false" ShowHeader="false" OnItemDataBound="dgrRequirements_OnItemDataBoundHandler">
                        <MasterTableView DataKeyNames="WorkflowTemplateItemDepID, DependentWorkflowTemplateItemID, WorkflowRuleDesc">
                            <Columns>
                                <telerik:GridTemplateColumn UniqueName="DependencyRule">
                                    <ItemStyle Width="200px" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblWorkflow" runat="server"></asp:Label>
                                        <asp:Label ID="lblDependencyRule" runat="server"><%#Eval("WorkflowRuleDesc")%></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn UniqueName="When">
                                    <ItemStyle Width="50px" />
                                    <ItemTemplate>
                                        when&nbsp;&nbsp;&nbsp;&nbsp;
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn UniqueName="Workflow">
                                    <ItemStyle Width="200px" />
                                    <ItemTemplate>
                                        <asp:Label ID="lblRequirementWorkflow" runat="server" Width="200px"><%#GetSystemText(Eval("Workflow"))%></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn UniqueName="Is">
                                    <ItemStyle Width="50px" />
                                    <ItemTemplate>
                                        &nbsp;&nbsp;&nbsp;&nbsp;is:&nbsp;&nbsp;&nbsp;&nbsp;
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn UniqueName="WorkflowStatus">
                                    <ItemStyle />
                                    <ItemTemplate>
                                        <asp:Label ID="lblWorkflowStatus" runat="server"><%#GetSystemText(Eval("WorkflowStatus"))%></asp:Label>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                            </Columns>
                        </MasterTableView>
                    </telerik:RadGrid>
                </asp:Panel>
            </NestedViewTemplate>
            <Columns>
                <telerik:GridDragDropColumn HeaderStyle-Width="18px" Visible="true" />
                <telerik:GridTemplateColumn>
                    <ItemStyle Width="20px" />
                    <ItemTemplate>
						<asp:Image id="imgStatus" runat="server"
						     ImageUrl='<%# string.Concat("../System/Icons/"  + DataBinder.Eval(Container.DataItem,"WorkflowStatusImage").tostring ) %>' 
						     ></asp:Image>
					</ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn SortExpression="WorkflowTemplateItemID" HeaderText="WorkflowTemplateItemID"
                    DataField="WorkflowTemplateItemID" UniqueName="WorkflowTemplateItemID" FilterControlAltText="Filter WorkflowTemplateItemID column"
                    ItemStyle-Width="200px" Visible="false">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn SortExpression="Workflow" DataField="Workflow"
                    UniqueName="Workflow" FilterControlAltText="Filter by Workflow" ItemStyle-Width="150px">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn SortExpression="WorkflowStatus" DataField="WorkflowStatus"
                    UniqueName="WorkflowStatus" FilterControlAltText="Filter by Workflow Status" ItemStyle-Width="100px">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn SortExpression="RequirementNum" DataField="RequirementNum"
                    UniqueName="RequirementNum" FilterControlAltText="Filter by Requirement Number" ItemStyle-Width="50px">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn SortExpression="WorkflowAccessTypeDesc"  DataField="WorkflowAccessTypeDesc"
                    UniqueName="WorkflowAccessTypeDesc" FilterControlAltText="Filter by Access Type" ItemStyle-Width="100px">
                </telerik:GridBoundColumn>
                
                <%--<telerik:GridBoundColumn SortExpression="StartDate" HeaderText="Planned Start Date" DataField="StartDate"
                    UniqueName="StartDate" FilterControlAltText="Filter Workflow column" ItemStyle-Width="127px">
                </telerik:GridBoundColumn>--%>
                
                
                <%--<telerik:GridBoundColumn SortExpression="PlannedStartDateLabel" HeaderText="Planned Start Date" DataField="WorkflowStatus"
                    UniqueName="PlannedStartDateLabel" FilterControlAltText="Filter by Planned Start Date" ItemStyle-Width="127px">
                </telerik:GridBoundColumn>
                
                <telerik:GridBoundColumn SortExpression="PlannedDueDateLabel" HeaderText="Planned Due Date" DataField="WorkflowStatus"
                    UniqueName="PlannedDueDateLabel" FilterControlAltText="Filter by Planned Due Date" ItemStyle-Width="127px">
                </telerik:GridBoundColumn>--%>
                <telerik:GridTemplateColumn UniqueName="PlannedStartDate">
                    <ItemStyle Width="84px" />
                    <ItemTemplate>
                        <asp:Label ID="lblPlannedStartDate" runat="server"></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn UniqueName="PlannedDueDate">
                    <ItemStyle Width="84px" />
                    <ItemTemplate>
                        <asp:Label ID="lblPlannedDueDate" runat="server"></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn SortExpression="PlannedWorkDays" DataField="PlannedWorkDays"
                    UniqueName="PlannedWorkDays" FilterControlAltText="Filter by Planned Work Day(s)" ItemStyle-Width="50px">
                </telerik:GridBoundColumn>
                <telerik:GridTemplateColumn HeaderText="Actual Start" UniqueName="ActualStartDate">
                    <ItemStyle Width="130px" />
                    <ItemTemplate>  
                        <telerik:RadDatePicker ID="rdpActualStartDate" runat="server" Width="95px" AutoPostBack="True" />
                        <asp:ImageButton ID="btnUpdateActualStartDate" runat="server" ImageUrl="~/System/Button/MailFlagRed.png" Style="cursor: pointer;" OnClick="btnUpdateActualStartDate_Click" />
                    </ItemTemplate>  
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn UniqueName="ActualDueDate">
                    <ItemStyle Width="130px" />
                    <ItemTemplate>  
                        <telerik:RadDatePicker ID="rdpActualDueDate" runat="server" Width="95px" AutoPostBack="True" />
                        <asp:ImageButton ID="btnUpdateActualDueDate" runat="server" ImageUrl="~/System/Button/MailFlagRed.png" Style="cursor: pointer;" OnClick="btnUpdateActualDueDate_Click" />
                    </ItemTemplate>  
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn UniqueName="ActualWorkDays">
                    <ItemTemplate>
                        <asp:TextBox ID="txtActualWorkDays" runat="server" Width="50px" AutoPostBack="True"></asp:TextBox>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                <telerik:GridTemplateColumn UniqueName="ActualCompletedDate">
                    <ItemStyle Width="95px" />
                    <ItemTemplate>  
                    <div style="width: 95px;">
                        <telerik:RadDatePicker ID="rdpActualCompletedDate" runat="server" style="width: 95px;" Width="95px" EnableViewState="false" />
                    </div>
                    </ItemTemplate>  
                </telerik:GridTemplateColumn>
                <telerik:GridBoundColumn SortExpression="WorkAssignedToName" DataField="WorkAssignedToName"
                    UniqueName="WorkAssignedToName" FilterControlAltText="Filter by Assigned To" ItemStyle-Width="100px">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn SortExpression="WorkEscalateToName" DataField="WorkEscalateToName"
                    UniqueName="WorkEscalateToName" FilterControlAltText="Filter by Escalate To" ItemStyle-Width="100px">
                </telerik:GridBoundColumn>
                <telerik:GridBoundColumn SortExpression="WorkflowAlerts" DataField="WorkflowAlerts"
                    UniqueName="WorkflowAlerts" FilterControlAltText="Filter by Workflow Alerts" ItemStyle-Width="30px">
                </telerik:GridBoundColumn>
                <%--<telerik:GridTemplateColumn HeaderText="Rules" UniqueName="Rules">
                    <ItemTemplate>
                        <asp:HyperLink ID="EditLink" runat="server" Text="Edit"></asp:HyperLink>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>--%>
            </Columns>
            <CommandItemTemplate>
                <div style="position: absolute; top: 2px; left: 12px; padding: 0px;"><asp:LinkButton ID="btnSaveGanttChart" runat="server" CommandName="SaveGanttChart" Visible = <%#IIF(LoadPermissionAccess(),true,false)%> ><img src="<%=workFlowSaveImage%>" border="0" /></asp:LinkButton></div>
            </CommandItemTemplate>
            <EditFormSettings>
                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                </EditColumn>
            </EditFormSettings>
        </MasterTableView>
        <ClientSettings AllowRowsDragDrop="true">
            <ClientEvents OnRowSelected="RowSelected" />
            <Selecting AllowRowSelect="true" EnableDragToSelectRows="true" />
        </ClientSettings>
    </telerik:RadGrid>
    <%--<div style="border: solid 1px #828282; border-top: none; padding: 2px; font-size: 10px;"><asp:HyperLink ID="lnkWorkflowTemplate" runat="server"></asp:HyperLink></div>--%>
    
</asp:Panel>
