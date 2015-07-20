<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Component_Multimaterial.aspx.vb" Inherits="plmOn2Report.Style_Component_Multimaterial" %>
<%@ Register TagPrefix="uc1" TagName="Style_Component_Multimaterial" Src="Style_Component_Multimaterial.ascx" %>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
    <head>
    	<meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie3-2nav3-0">
    	<style type="text/css">
            BODY { BORDER-RIGHT: 1px; BORDER-TOP: 1px; FONT-SIZE: 11px; MARGIN: 2px; BORDER-LEFT: 1px; BORDER-BOTTOM: 1px; FONT-FAMILY: Tahoma, Geneva, Arial, Helvetica, sans-serif }
        </style>
    </head>

	<body>
		<form id="Form1" method="post" runat="server">
	
			

	        <table cellspacing="1" cellpadding="0" width="100%" border="0" bordercolor="black" style="border-collapse:collapse;"  >
    	        <tr><td><asp:placeholder id="plhMainMaterial" runat="server" ></asp:placeholder></td></tr>
    	        <tr><td><asp:datagrid id="dgComponent" runat="server" ShowHeader="False" AutoGenerateColumns="false" 
                         Width="100%" CellPadding="0" CellSpacing="0"  >
	                <Columns>
		                <asp:TemplateColumn>
			                <ItemTemplate>
				                <TABLE cellspacing="0" cellpadding="0" width="100%" border="0" style="border-collapse:collapse;"  >
					                <TR >
						                <TD >&nbsp;&nbsp; <span style="font-family:Tahoma, Geneva, Arial, Helvetica, sans-serif;font-size: 11px;font-weight: bold;"><%# DataBinder.Eval(Container.DataItem, "ComponentDescription") %></span></TD>
					                </TR>
				                </TABLE>
				                <uc1:Style_Component_Multimaterial id="Style_Component_Multimaterial1" runat="server"  
				                    CTID='<%# DataBinder.Eval(Container.DataItem, "ComponentTypeID") %>' 
				                    SID='<%# Request.Querystring("SID") %>' 
				                    SN='<%# Request.Querystring("SN") %>'
				                    SYSCID='<%# Request.Querystring("SYSCID") %>'>
				                </uc1:Style_Component_Multimaterial>
			                </ItemTemplate>
		                </asp:TemplateColumn>
	                </Columns>
                </asp:datagrid></td></tr>	    
	        </table>
    			
    	    
	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

			
			
			
		</form>
	</body>
</HTML>


