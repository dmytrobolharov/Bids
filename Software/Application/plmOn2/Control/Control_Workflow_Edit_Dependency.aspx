<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_Workflow_Edit_Dependency.aspx.vb" Inherits="plmOnApp.Control_Workflow_Edit_Dependency" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/RadGrid.YPLM.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <!-- custom head section -->
    <style type="text/css">
        .MyImageButton
        {
            cursor: hand;
        }
        .EditFormHeader td
        {
            font-size: 14px;
            padding: 4px !important;
            color: #0066cc;
        }
    </style>
    <!-- end of custom head section -->
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
        </Scripts>
        <CdnSettings TelerikCdn="Disabled" />
    </telerik:RadScriptManager>
    
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script type="text/javascript">
            <!--
            function RowDblClick(sender, eventArgs) {
                sender.get_masterTableView().editItem(eventArgs.get_itemIndexHierarchical());
            }

            function gridCreated(sender, args) {
                if (sender.get_editIndexes && sender.get_editIndexes().length > 0) {
                    document.getElementById("OutPut").innerHTML = sender.get_editIndexes().join();
                }
                else {
                    document.getElementById("OutPut").innerHTML = "";
                }
            }
            -->
        </script>
    </telerik:RadCodeBlock>
    
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="dgrRequirements">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="dgrRequirements" LoadingPanelID="RadAjaxLoadingPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="RadWindowManager1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
    
    <!-- content start -->
    <span id="OutPut" style="font-weight: bold; color: navy; visibility: hidden;"></span>
    
    <telerik:RadGrid ID="dgrRequirements" runat="server" 
        GridLines="None" AllowAutomaticDeletes="True"
        AllowAutomaticInserts="True" AllowAutomaticUpdates="True"
        AutoGenerateColumns="False" OnNeedDataSource="dgrRequirements_NeedDataSource"
        OnItemDataBound="dgrRequirements_OnItemDataBoundHandler"
        
        OnItemCommand="dgrRequirements_ItemCommand"
        OnUpdateCommand="dgrRequirements_UpdateCommand"
        OnInsertCommand="dgrRequirements_InsertCommand"
        OnDeleteCommand="dgrRequirements_DeleteCommand">
        <MasterTableView Width="100%" EditMode="InPlace" CommandItemDisplay="Top" DataKeyNames="WorkflowTemplateItemDepID, DependentOnWorkflowTemplateItemID, WorkflowStatusID" HorizontalAlign="NotSet" AutoGenerateColumns="False" ShowHeader="false">
            <Columns>
            
                <telerik:GridTemplateColumn UniqueName="DependencyRule">
                    <ItemStyle Width="200px" />
                    <ItemTemplate>
                        <asp:Label ID="lblWorkflow" runat="server"></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
            
                <telerik:GridDropDownColumn DataField="WorkflowRuleID" DataSourceID="SqlDataSource4"
                    HeaderText="WorkflowRuleDesc" ListTextField="WorkflowRuleDesc" ListValueField="WorkflowRuleID"
                    UniqueName="WorkflowRuleID" ColumnEditorID="GridDropDownListColumnEditor1">
                </telerik:GridDropDownColumn>
                
                <telerik:GridTemplateColumn UniqueName="When">
                    <ItemStyle Width="50px" />
                    <ItemTemplate>
                        &nbsp;when
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                <telerik:GridTemplateColumn UniqueName="RequirementWorkflow">
                    <ItemStyle Width="200px" />
                    <ItemTemplate>
                        <asp:Label ID="lblRequirementWorkflow" runat="server" Width="200px" style="color: red;"><%#Eval("Workflow")%></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                <%--<telerik:GridTemplateColumn UniqueName="RequirementWorkflow2">
                    <ItemStyle Width="200px" />
                    <ItemTemplate>
                        <asp:Label ID="lblRequirementWorkflow2" runat="server" Width="200px" style="color: red;"><%#Eval("WorkflowTemplateItemID")%></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                <telerik:GridTemplateColumn UniqueName="RequirementWorkflow3">
                    <ItemStyle Width="200px" />
                    <ItemTemplate>
                        <asp:Label ID="lblRequirementWorkflow3" runat="server" Width="200px" style="color: red;"><%#Eval("DependentWorkflowTemplateItemID")%></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                <telerik:GridTemplateColumn UniqueName="RequirementWorkflow4">
                    <ItemStyle Width="200px" />
                    <ItemTemplate>
                        <asp:Label ID="lblRequirementWorkflow4" runat="server" Width="200px" style="color: red;"><%#Eval("DependentOnWorkflowTemplateItemID")%></asp:Label>
                    </ItemTemplate>
                </telerik:GridTemplateColumn>--%>
                
                <%--<telerik:GridDropDownColumn DataField="WorkflowTemplateItemID" DataSourceID="SqlDataSource2"
                    HeaderText="WorkflowTemplateItemID" ListTextField="WorkflowTemplateItemID" ListValueField="WorkflowTemplateItemID"
                    UniqueName="DependentOnWorkflowTemplateItemID" ColumnEditorID="GridDropDownListColumnEditor2">
                </telerik:GridDropDownColumn>--%>
                
                <%--<telerik:GridDropDownColumn DataField="WorkflowTemplateItemID" DataSourceID="SqlDataSource2"
                    HeaderText="WorkflowTemplateItemID" ListTextField="DependentOnWorkflowTemplateItemID" ListValueField="WorkflowTemplateItemID"
                    UniqueName="DependentOnWorkflowTemplateItemID2" ColumnEditorID="GridDropDownListColumnEditor2">
                </telerik:GridDropDownColumn>--%>
                
                <telerik:GridDropDownColumn DataField="dependentOnWorkflowTemplateItemID" DataSourceID="SqlDataSource2"
                    HeaderText="dependentOnWorkflowTemplateItemID" ListTextField="Workflow" ListValueField="dependentOnWorkflowTemplateItemID"
                    UniqueName="DependentOnWorkflowTemplateItemID" ColumnEditorID="GridDropDownListColumnEditor2">
                </telerik:GridDropDownColumn>
                
                <telerik:GridTemplateColumn UniqueName="Is">
                    <ItemStyle Width="50px" />
                    <ItemTemplate>
                        &nbsp;is:&nbsp;
                    </ItemTemplate>
                </telerik:GridTemplateColumn>
                
                <telerik:GridDropDownColumn DataField="WorkflowStatusID" DataSourceID="SqlDataSource3"
                    HeaderText="WorkflowStatusID" ListTextField="WorkflowStatus" ListValueField="WorkflowStatusID"
                    UniqueName="WorkflowStatusID" ColumnEditorID="GridDropDownListColumnEditor3">
                </telerik:GridDropDownColumn>
                
                <telerik:GridEditCommandColumn ButtonType="ImageButton" UniqueName="EditCommandColumn">
                    <ItemStyle CssClass="MyImageButton" />
                </telerik:GridEditCommandColumn>
                <telerik:GridButtonColumn ConfirmDialogType="RadWindow"
                    ConfirmTitle="Delete" ButtonType="ImageButton" CommandName="Delete"
                    UniqueName="DeleteColumn">
                    <ItemStyle HorizontalAlign="Center" CssClass="MyImageButton" />
                </telerik:GridButtonColumn>
            </Columns>
        </MasterTableView>
        
        <FilterMenu EnableImageSprites="False"></FilterMenu>

        <ClientSettings>
            <Selecting CellSelectionMode="None"></Selecting>
            <ClientEvents OnRowDblClick="RowDblClick" OnGridCreated="gridCreated" />
        </ClientSettings>
        
    </telerik:RadGrid>
    
    
    <telerik:GridDropDownListColumnEditor ID="GridDropDownListColumnEditor1" runat="server" />
    <telerik:GridDropDownListColumnEditor ID="GridDropDownListColumnEditor2" runat="server" />
    <telerik:GridDropDownListColumnEditor ID="GridDropDownListColumnEditor3" runat="server" />
    
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server"></telerik:RadWindowManager>
    
    <br />
    
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SQLCACHECONNECTION %>"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:SQLCACHECONNECTION %>" ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSource4" runat="server" ConnectionString="<%$ ConnectionStrings:SQLCACHECONNECTION %>" ProviderName="System.Data.SqlClient" SelectCommand="select * from pWorkflowRule order by WorkflowRuleDesc"></asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
