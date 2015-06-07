<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="sw1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Component.aspx.vb" Inherits="plmOnApp.Style.Material.Style_Component"  %>
<%@ Register TagPrefix="uc1" TagName="Style_Component" Src="Style_Component.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

    <html xmlns="http://www.w3.org/1999/xhtml" >
    <head id="Head1" runat="server">
		<title>Style</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
        <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>

			<sw1:style_workflow id="Style_Workflow1" runat="server"></sw1:style_workflow>
			<asp:panel id="pnlChange" runat="server">
				<uc1:Style_Change_Alert id="Style_Change_Alert1" runat="server"></uc1:Style_Change_Alert>
			</asp:panel>
			<uc2:style_header id="Style_Header1" runat="server" StyleID='<%Request("SID")%>'></uc2:style_header>
			
			<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>
			
			<table id="tblTemplate" height="24" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></td>
					<td class="TableBar" valign="middle" align="center" width="20"><IMG src="../System/icons/icon_template.gif"></td>
					<td class="TableBar"><cc1:bwhyperlink id="lnkTemplate" runat="server" WindowName="PackLabelTemplate"></cc1:bwhyperlink></td>
					<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></td>
				</tr>
			</table>
			<asp:placeholder id="plhMainMaterial" runat="server" ></asp:placeholder>
			
			<table cellspacing="0" cellpadding="0" border="0" width="100%">
				<tr bgColor="#ffffff">
					<td valign="top"><asp:datagrid id="dgComponent" runat="server" ShowHeader="False" AutoGenerateColumns="false" BorderColor="Silver"
							Width="100%">
							<Columns>
								<asp:TemplateColumn>
									<ItemTemplate>
										<table cellspacing="0" cellpadding="0" width="100%" border="0">
											<tr class="TableHeader">
												<td width="10" bgColor="white" height="24"></td>
												<td class="fontHead" bgColor="white"><%# DataBinder.Eval(Container.DataItem, "ComponentDescription") %></td>
											</tr>
										</table>
										<uc1:Style_Component id="Style_Component1" runat="server"  CTID='<%# DataBinder.Eval(Container.DataItem, "ComponentTypeID") %>' SID='<%# Request.Querystring("SID") %>' SN='<%# Request.Querystring("SN") %>'>
										</uc1:Style_Component>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
				</tr>
			</table>
			
			<BR>
			<table height="24" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="middle">
					<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif" /></td>
					<td class="TableBar" valign="middle" align="center" width="20"><IMG src="../System/icons/icon_changeobject.gif"></td>
					<td class="TableBar"><asp:label id="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:label>&nbsp;/
						<asp:label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:label></td>
					<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif" /></td>
				</tr>
			</table>
		</form>

<script language="javascript"  type="text/javascript"> 

    function showItem( icName, ieName , dName ){
        var oIc, oIe , oD  ;
        
        try {
            oIc = document.getElementById(icName) ;
            oIe = document.getElementById(ieName) ;
            oD = document.getElementById(dName) ;
            oD.style.display = 'block' ;
            oIe.style.display = 'none' ; 
            oIc.style.display = 'block' ; 
        }catch (e) {
            alert (e.description) ;
        }
        
        oIc = document.getElementById(icName) ;
        oIe = document.getElementById(ieName) ;
        oD = document.getElementById(dName) ;
        oD.style.display = 'block' ;
        oIe.style.display = 'none' ; 
        oIc.style.display = 'block' ; 
    }

    function hideItem( icName, ieName , dName ){
        var oIc, oIe , oD  ;
        oIc = document.getElementById(icName) ;
        oIe = document.getElementById(ieName) ;
        oD = document.getElementById(dName) ;
        oD.style.display = 'none' ;
        oIe.style.display = 'block' ; 
        oIc.style.display = 'none' ; 
    }    
    
    function expandall (opt){
        var e,s ; 
        var coll = document.getElementsByTagName("DIV");
        var ele ; 
        
        if (coll!=null){
            for (i=0; i<coll.length; i++){
                if ( coll[i].id.indexOf("divSubMaterials") != -1 ) {
                    s = coll[i].id.indexOf("divSubMaterials") ;
                    ele = coll[i].id.substring(0,s) ; 
                    if (opt == 1  )
                        showItem( ele + 'DataGrid1_ctl02_imgExpColCom' ,  ele + 'DataGrid1_ctl02_imgExpSubCom' , ele + 'divSubMaterials' );
                    else 
                        hideItem( ele + 'DataGrid1_ctl02_imgExpColCom' ,  ele + 'DataGrid1_ctl02_imgExpSubCom' , ele + 'divSubMaterials' );
                }
            }
        }
        
        if (opt == 1 ) {
            var img1, img2;
            img1 = document.getElementById('<%= Style_Workflow1.ClientID %>_btnExpandAll');
            img2 = document.getElementById('<%= Style_Workflow1.ClientID %>_btnCollapseAll');
            img1.style.display ='none';
            img2.style.display='block';
        }
        else{
            var img1, img2;
            img1 = document.getElementById('<%= Style_Workflow1.ClientID %>_btnExpandAll');
            img2 = document.getElementById('<%= Style_Workflow1.ClientID %>_btnCollapseAll');
            img1.style.display ='block';
            img2.style.display='none';
        } 
        
    }
    //var new_window    
    function open_new_window(url,n) {
        new_window = window.open(url, n, 'top=100, left=300, width=600,height=600,location=yes, menubar=no, status=no, toolbar=no, scrollbars=no, resizable=no')
        new_window.focus();
    }

    function close_window(url) {
        if (!new_window) {
            new_window.close(url);
        }
    }

</script>
		
	</body>
</html>
