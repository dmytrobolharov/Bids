<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Task_Item_Edit.aspx.vb" Inherits="plmOnApp.Task_Item_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Task Folder</title>
   	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
	    <TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
		    runat="server">
		    <TR vAlign="middle">
			    <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
			    <TD><cc1:confirmedimagebutton 
			    id="btnAdd" runat="server"  Message="NONE" style="height: 24px"></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
			    id="btnSave" runat="server" Message="NONE" style="height: 24px"></cc1:confirmedimagebutton><cc1:confirmedimagebutton 
			    id="btnClose" runat="server" Message="NONE" style="height: 24px" OnClientClick="return btnClose_Click()"></cc1:confirmedimagebutton>
			    </TD>
		    </TR>
	    </TABLE>
	    
	    <table width="100%" height="10" border="0" cellpadding="0" cellspacing="0" bgcolor="#cddeee">
		    <tr>
			    <td></td>
		    </tr>
	    </table>
	    <br/>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#ffffff">
		    <tr>
			    <td>&nbsp;<asp:Label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="XX-Large" ForeColor="#E0E0E0">Task Folder...</asp:Label></td>
		    </tr>
	    </table>
        <br/>
    
        <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
		    <tr>
			    <td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
		    </tr>
	    </table>
	    
	    <br />
	    <br />
       
  
        <asp:datalist id="dlTask" runat="server" BorderWidth="0" BackColor="White" Width="100%" 
			Datakeyfield="TaskItemID" ShowFooter="False" BorderStyle="None" CellSpacing="1" CellPadding="0">
			<AlternatingItemStyle Height="20px" CssClass="font" BackColor="White"></AlternatingItemStyle>
			<ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
			<ItemTemplate>
			    <table border="0" cellpadding="0" cellspacing ="0" width="100%" class="TableHeader">
			        <tr>
			            <td width="20"><asp:imagebutton id="imbBtnExpand" runat="server" ImageUrl="../System/Icons/icon_Next.gif" 
			                        CausesValidation="False"   CommandName="edit" /></td>
			            <td width="10" valign="middle" align="center" ><img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
			            <td> <asp:Label runat="server" id="lblTitle" ></asp:Label></td>
			        </tr>
			    </table>
			</ItemTemplate>
			<EditItemTemplate>
			    
                <table border="0" cellpadding="0" cellspacing ="0" width="100%" class="TableHeader">
                    <tr>
                        <td width="20">&nbsp;<asp:imagebutton id="imgBtnCollapse" runat="server" ImageUrl="../System/Icons/icon_Down.gif" 
                                    CausesValidation="False" CommandName="collapse" /></td>
                        <td width="10" valign="middle" align="center" ><img alt="" height="15" src="../System/Images/bbTbSCnr.gif" width="3" /></td>
                        <td><asp:Label runat="server" id="lblTitle" ></asp:Label></td>			            
                    </tr>
                </table>
                
                <table border="0" cellpadding="0" cellspacing ="0" width="100%" >
			        <tr>
			            <td width="2%">&nbsp;</td>
			            <td width="98%"><asp:TextBox ID="txtComment" runat="server" Rows="15" TextMode="MultiLine"  
                            Width="98%"></asp:TextBox>
			            </td>
			            <td width="2%">&nbsp;</td>
			        </tr>
			     </table>
			     


                <table border="0" cellpadding="0" cellspacing ="0"  class="font">
                    <tr>
                        <td width="20">&nbsp;</td>
                        <td><asp:Label id="lblModifiedBy" runat="server"><%#GetSystemText("Modified By")%>:</asp:Label></td>
                        <td width="20">&nbsp;</td>
                        <td ><asp:Label  id="lblMUser" runat ="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td width="20">&nbsp;</td>
                        <td colspan="3">
                           <br /> 
                            <asp:linkbutton CommandName="update"  id="Linkbutton2" CausesValidation="False" runat="Server" NAME="Linkbutton2"  Text='<IMG border="0" alt="Save" src="../System/Icons/icon_save.gif">'></asp:linkbutton>
			                <cc1:ConfirmedLinkButton CommandName="delete"  id="Linkbutton4"  CausesValidation="False"  runat="Server" NAME="Linkbutton4" Text='<IMG border="0" alt="Delete" src="../System/Icons/icon_delete.gif">' Visible="TRUE" Message='<%#GetSystemText("Are you sure you want to continue?")%>'></cc1:ConfirmedLinkButton>
			                <asp:linkbutton CommandName="cancel"  id="Linkbutton3" runat="Server"  CausesValidation="False"  NAME="Linkbutton3" Text='<IMG border="0" alt="Cancel" src="../System/Icons/icon_close.gif">'></asp:linkbutton>
                        </td>
                    </tr>
                </table>

			</EditItemTemplate>
			
			
		</asp:datalist>   
    
    </div>
    
    </form>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</body>
</html>
