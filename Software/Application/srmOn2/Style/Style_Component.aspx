<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Component" Src="Style_Component.ascx" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_Component.aspx.vb" Inherits="srmOnApp.Style_Component" %>
<%@ Register TagPrefix="uc1" TagName="Style_Component_Main" Src="Style_Component_Main.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
	<HEAD>
		<title runat="server" id="PageTitle">Style</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">
		<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
		<LINK href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
        <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
	</HEAD>
	<body>
		<form id="Form1" method="post" runat="server">
			<uc1:style_workflow id="Style_Workflow1" runat="server"></uc1:style_workflow>
			<uc2:style_header id=Style_Header1 runat="server" StyleID='<%Request("SID")%>'>
			</uc2:style_header>
			<table class="ToolbarShort" cellSpacing="0" cellPadding="0" width="100%" border="0">
				<tr>
					<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
				</tr>
			</table>
			
			
			<table id="tblTemplate" height="24" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></TD>
					<TD class="TableBar" vAlign="middle" align="center" width="20"><IMG src="../System/icons/icon_template.gif"></TD>
					<TD class="TableBar"><cc1:bwhyperlink id="lnkTemplate" runat="server" WindowName="PackLabelTemplate"></cc1:bwhyperlink></TD>
					<TD vAlign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></TD>
				</TR>
			</table>
			<asp:placeholder id="plhMainMaterial" runat="server" ></asp:placeholder>
			
			<table cellSpacing="0" cellPadding="0" border="0" width="100%">
				<tr bgColor="#ffffff">
					<td vAlign="top"><asp:datagrid id="dgComponent" runat="server" ShowHeader="False" AutoGenerateColumns="false" BorderColor="Silver"
							Width="100%">
							<Columns>
								<asp:TemplateColumn>
									<ItemTemplate>
										<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0">
											<TR class="TableHeader">
												<TD width="10" bgColor="white" height="24"></TD>
												<TD class="fontHead" bgColor="white"><%# DataBinder.Eval(Container.DataItem, "ComponentDescription") %></TD>
											</TR>
										</TABLE>
										<uc1:Style_Component id="Style_Component1" runat="server"  CTID='<%# DataBinder.Eval(Container.DataItem, "ComponentTypeID") %>' SID='<%# Request.Querystring("SID") %>' SN='<%# Request.Querystring("SN") %>'>
										</uc1:Style_Component>
									</ItemTemplate>
								</asp:TemplateColumn>
							</Columns>
						</asp:datagrid></td>
				</tr>
			</table>
			

			
		</form>
		
<script language="javascript"  type="text/javascript"> 

    function showItem( icName, ieName , dName ){
        var oIc, oIe , oD  ;
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
    
    
</script>
		
	</body>
</HTML>
