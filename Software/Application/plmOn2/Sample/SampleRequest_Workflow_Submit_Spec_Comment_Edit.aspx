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
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
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
            <telerik:RadEditor id="txtFitComment" runat="server" MaxLength="4000" Width="790px" Height="550px" NewLineMode="Br" OnClientLoad="OnClientLoad" ContentFilters="MakeUrlsAbsolute,FixEnclosingP" ></telerik:RadEditor>
			<INPUT id="txtNoTOL" type="hidden" name="txtTOL" runat="server">	          

	    </form>	   			
	</body>
	
	<script language="javascript" type="text/javascript">
	    document.getElementById("divCommentFormats").style.display = 'none';
	    //this code is a custom filter to convert <span style="text-decoration: underline;"> to <u>
        function OnClientLoad(editor, args) {
            editor.get_filtersManager().add(new FixUnderline());
        }

        FixUnderline = function() {
        FixUnderline.initializeBase(this);
            this.IsDom = true;
            this.Enabled = true;
            this.Name = "FixUnderline";
            this.Description = "This filter changes CSS underline to u tag";
        };
        FixUnderline.prototype = { _getElements: function(a, c) {
            var b = a.getElementsByTagName(c);
            if (!b) {
                b = a.ownerDocument.getElementsByTagName(c);
            } return b;
        }, _replaceElementWithSpan: function(l, h, k) {
            var m = this._getElements(l, h);
            var d = [];
            for (var b = m.length - 1; b >= 0; b--) {
                Array.add(d, m[b]);
            } for (var a = 0, c = d.length; a < c; a++) {
                var e = l.ownerDocument.createElement("span");
                e.style.cssText = k;
                var f = d[a];
                var g = f.innerHTML;
                if ($telerik.isIE && g == " ") {
                    e.innerText = g;
                } else {
                    Telerik.Web.UI.Editor.Utils.setElementInnerHtml(e, g);
                } f.parentNode.replaceChild(e, f);
            }
        }, _replaceSpanWithElement: function(o, n, f) {
            var q = this._getElements(o, "span");
            var e = [];
            for (var b = q.length - 1; b >= 0; b--) {
                Array.add(e, q[b]);
            } for (var a = 0, c = e.length; a < c; a++) {
                var m = [];
                var g = e[a];
                for (var p = 0; p < g.childNodes.length; p++) {
                    Array.add(m, g.childNodes[p].cloneNode(true));
                } if (g.style.cssText.toLowerCase() == f || g.style.cssText.toLowerCase() == (f + ";")) {
                    var h = o.ownerDocument.createElement(n);
                    for (var d = 0; d < m.length; d++) {
                        h.appendChild(m[d]);
                    } g.parentNode.replaceChild(h, g);
                }
            }
        }, getHtmlContent: function(a) {
            this._replaceSpanWithElement(a, "u", "text-decoration: underline");
            return a;
        }, getDesignContent: function(a) {
            this._replaceElementWithSpan(a, "u", "text-decoration: underline");
            return a;
        }
        };
    FixUnderline.registerClass("FixUnderline", Telerik.Web.UI.Editor.Filter);
        //end custom filter
	</script>
</HTML>

