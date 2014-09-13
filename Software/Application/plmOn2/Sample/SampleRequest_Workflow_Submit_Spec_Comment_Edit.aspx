<%@ Page Language="vb" AutoEventWireup="false" Codebehind="SampleRequest_Workflow_Submit_Spec_Comment_Edit.aspx.vb" Inherits="plmOnApp.SampleRequest_Workflow_Submit_Spec_Comment_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle"></title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
		<style type="text/css" > 
		    .expcol-body 
		    {
	            position: absolute;
	            z-index: 106;
	            min-height: 1em;
	            background: #e9f3f8;
	            padding: .1em;
	            display: block;	            
	            display: none;
	            margin-top: -1px;
	            border: 1px solid #999;
            }
		    .text-font
		    {
		        font-family: Tahoma, Geneva, Arial, Helvetica, sans-serif;
	            font-size: 11px;
	            font-weight: bold;
	            padding:2px;
		    }
		</style>
		
		<script type="text/javascript">
		    function OpenCommentOptions(checkAllBox)		
		    {
		        var frm = document.Form1;
		        var actVar = checkAllBox.checked;		        
		        if (actVar==true) {
		            document.getElementById("divCommentFormats").className = 'expcol-body';     
		            document.getElementById("divCommentFormats").style.display = 'block'; 
		        }
		        else {
		            document.getElementById("divCommentFormats").style.display = 'none';
		            frm.reset();
		        }
		    }	    
		    
		</script>		
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        <Scripts>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
        </Scripts>
        <CdnSettings TelerikCdn="Disabled" />
    </telerik:RadScriptManager>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server">
        <StyleSheets>
            <telerik:StyleSheetReference Path="../System/CSS/RadCalendar.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadComboBox.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadGrid.YPLM.css" />
            <telerik:StyleSheetReference Path="../System/CSS/RadInput.YPLM.css" />
        </StyleSheets>
        <CdnSettings TelerikCdn="Disabled" />
    </telerik:RadStyleSheetManager>
    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1"></telerik:RadAjaxManager>
			<cc1:ystabview id="YSTabView1" runat="server"></cc1:ystabview>
			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD width="80"><asp:imagebutton id="btnSave" runat="server"></asp:imagebutton></TD>
					<td width="300px">
					<table  cellSpacing="0" cellPadding="0" width="100%" border="0">
					    <tr>
					        <td class="text-font">
					            <asp:checkbox id="cbAutoFitComment" runat="server" Checked="false" onclick="javascript:OpenCommentOptions(this)" ></asp:checkbox>					
					        </td>
					    </tr>
					    <tr>
					        <td class="text-font">					           
					            <div id="divCommentFormats">  
                                    <asp:RadioButton ID="RadioSimpleComments" AutoPostBack="true" GroupName="CommentFormat" Text="Simple Comments" runat="server" /><br />                                                     
                                    <asp:RadioButton ID="RadioFullComments" AutoPostBack="true"  GroupName="CommentFormat" Text="Full Comments" runat="server" /><br />
                                    <asp:RadioButton ID="RadioAbbrComments"  AutoPostBack="true" GroupName="CommentFormat" class="a9multiselect" Text="Abbreviated Comments" runat="server" />                                
                                </div>
					        </td>
					    </tr>
					</table>						
                    </td>  	
					<td width="75">&nbsp;</td>
					<td>&nbsp;</td>
				</TR>
			</TABLE>
            <telerik:RadEditor id="txtFitComment" runat="server" MaxLength="4000" Width="790px"
				Height="550px"></telerik:RadEditor>
			<INPUT id="txtNoTOL" type="hidden" name="txtTOL" runat="server">	          

	    </form>	   			
	</body>
	
	<script language="javascript" type="text/javascript">
	    document.getElementById("divCommentFormats").style.display = 'none';	
	</script>
</HTML>

