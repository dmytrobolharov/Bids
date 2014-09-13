<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_ConstructionDetail.aspx.vb" Inherits="srmOnApp.Style_ConstructionDetail" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc3" TagName="Style_WorkflowItem" Src="Style_WorkFlowItem.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
	<title>Process Details</title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />

</head>
<body>
    <form id="form1" runat="server">
		<uc1:style_workflow id="Style_Workflow1" runat="server"></uc1:style_workflow><asp:panel id="pnlChange" runat="server">
		</asp:panel><uc2:style_header id=Style_Header1 runat="server">
		</uc2:style_header>
		<table class="ToolbarShort" cellspacing="0" cellpadding="0" width="100%" border="0">
			<tr>
				<td height="20"><uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment></td>
			</tr>
		</table>
		<uc3:Style_WorkflowItem id="Style_WorkflowItem1" runat="server" />

	    <asp:datagrid id="DataGrid1" runat="server" AllowSorting="False" DataKeyField="ConstructionDetailID">
		    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
		    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
		    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                <Columns>
                <asp:TemplateColumn >
                    <ItemStyle Width="75" />
                    <ItemTemplate>
                        <table cellspacing="0" cellpadding="0" width="75" border="0" >
                        <tr><td><table cellspacing="0" cellpadding="0" width="25" border="0">
                                <tr>														
                                    <td>
                                        <asp:Image id="ImgLinked" runat="server" ImageUrl="../System/Icons/icon_link.gif" Visible='<%# DisplayLinkedVisible(Container.DataItem("Linked")) %>' ToolTip='<%#GetSystemText("Construction Linked") & "..." %>'>
                                        </asp:Image>
                                    </td>
                                </tr>
                            </table>
                            <table cellspacing="0" cellpadding="0" width="25" border="0">
                                <tr>
                                    <td>
                                        <cc1:BWImageButton id="imgConstructionDetail" runat="server"></cc1:BWImageButton></td>
                                </tr>
                            </table>
                        </td></tr>
                        </table>
                        

                    </ItemTemplate>
                </asp:TemplateColumn>
            </Columns>

	    </asp:datagrid>   
		
    </form>
</body>
</html>
