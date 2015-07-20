<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_WorkflowItems_Custom.aspx.vb" Inherits="srmOnApp.Style_WorkflowItems_Custom" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
	<title>Work Flow Items</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" method="post" runat="server">
		<uc1:Style_Workflow ID="Style_Workflow1" runat="server"></uc1:Style_Workflow>
		<uc2:style_header id="Style_Header1" runat="server">
		</uc2:style_header>
        <table cellspacing="0" cellpadding="0" width="100%" border="0">
            <tr>
                <td>
                &nbsp;
                </td>
                <td>
                    <asp:datagrid id="DataGrid1" runat="server" AllowSorting="False" DataKeyField="WorkFlowItemID">
                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
                        <ItemStyle Height="20px" Wrap="false" CssClass="ItemTemplate"></ItemStyle>
                        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                        <PagerStyle Visible="False"></PagerStyle>
                        <Columns>         
                            <asp:TemplateColumn >
                            <HeaderTemplate >
                                <asp:Label runat="server" ID="lblAction" Text="Action" />
                            </HeaderTemplate>                            
                            <ItemStyle Width="75" />
                            <ItemTemplate>

                                <table cellspacing="0" cellpadding="0" width="75" border="0" >
                                    <tr>
                                        <td>
                                            <table cellspacing="0" cellpadding="0" width="25" border="0">
                                                <tr>
                                                    <td>
                                                    
                                                        <cc1:confirmedimagebutton id="btnView" runat="server" OnCommand="DoAction"  Message="NONE" Visible="true" />
                                                    </td>                                       
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>                  

                            </ItemTemplate>
                        </asp:TemplateColumn>     
                    </Columns>
                    </asp:datagrid>   
                </td>
            </tr>
        </table>

		
    </form>

</body>
</html>

