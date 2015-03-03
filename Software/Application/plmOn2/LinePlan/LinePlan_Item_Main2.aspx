<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_Item_Main2.aspx.vb" Inherits="plmOnApp.LinePlan_Item_Main2" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
	<script language="javascript" src="../System/Jscript/System.js"></script>
	<script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server" >

			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><asp:imagebutton id="btnInvSearch" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton>
					<cc1:confirmedimagebutton id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:bwimagebutton id="btnNew" runat="server"  Message="NONE">
				        </cc1:bwimagebutton>
				        <cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE" CausesValidation="false" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></TD>
					<td>&nbsp;</td>
				</TR>
			</TABLE>
			<table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="#cddeee" border="0">
				<tr>
					<td></td>
				</tr>
			</table>
			<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Testing</asp:label></td>
				</tr>
			</table>
			<table cellSpacing="1" cellPadding="0" width="100%" border="0">
				<tr>
					<td vAlign="top">
						<table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
							<tr>
								<td><asp:placeholder id="plhControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		
		    <BR/><BR/>
		    
            <cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>
            

       
            
            <asp:Panel  runat ="server" ID="pnlStyles" visible="false">
                <TABLE class="TableHeader" id="TABLE1" cellSpacing="0" cellPadding="0" width="100%" border="0"
			            runat="server">
			        <TR vAlign="middle">
				        <TD vAlign="middle" align="center" width="10">
                            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
				        <TD>&#160;</TD>
			         </TR>
		         </TABLE>
            
	                
                 
                <table class="TableHeader"  cellSpacing="0" cellPadding="0" width="100%" border="0"  runat="server" id="tbNoGroupStyles">
                <tr  height="25"><td ><asp:Label ID="lbNoGroupName" runat="server" ></asp:Label></td></tr>
                <tr><td valign="top">
                    &nbsp;</td></tr>
                </table>

            </asp:Panel>
      
            <asp:DataList ID="DataList1" runat="server" BackColor="White">
                <ItemTemplate>
                <table style="width:100%;" border="0" cellpadding="0" cellspacing="0">
                <tr class="TableHeaderYellow">
					<td align="center" width="0%" height="23"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                    <td width="100%">
                        <asp:Label ID="Label1" runat="server"><%#(DataBinder.Eval(Container.DataItem, "TableText"))%></asp:Label>
                    </td>
                </tr>
                </table>                 
                <asp:DataList ID="DataList2" runat="server" Width="100%">
                        <ItemTemplate>
                            <table style="width:100%;" border="0" cellpadding="0" cellspacing="0">
                                <tr vAlign="middle" class="TableHeaderOver">
                                    <td vAlign="middle" align="center" width="0%" height="23"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                                     <td width="100%"><asp:Label ID="Label2" runat="server"><%#(DataBinder.Eval(Container.DataItem, "TableText"))%></asp:Label></td>
                                </tr>
                             </table>
                            <asp:DataList ID="DataList3" runat="server" Width="100%">
                                <ItemTemplate>
                                    <table style="width:100%;" border="0" cellpadding="0" cellspacing="0">
                                        <tr vAlign="middle" class="TableHeaderOver">
                                            <td vAlign="middle" align="center" width="1%" height="23"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                                            <td width="99%"><asp:Label ID="Label3" runat="server"><%#(DataBinder.Eval(Container.DataItem, "TableText"))%></asp:Label></td>
                                        </tr>
                                     </table>
                                    <asp:DataList ID="DataList4" runat="server" Width="100%">
                                        <ItemTemplate>
                                             <table style="width:100%;" border="0" cellpadding="0" cellspacing="0">
                                                    <tr vAlign="middle" class="TableHeaderOver">
                                                        <td vAlign="middle" align="center" width="1%" height="23"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                                                        <td width="99%"><asp:Label ID="Label4" runat="server"><%#(DataBinder.Eval(Container.DataItem, "TableText"))%></asp:Label></td>
                                                    </tr>
                                              </table>
                                             <asp:DataList ID="DataList5" runat="server" Width="100%">
                                                    <ItemTemplate>
                                                        <table style="width:100%;" border="0" cellpadding="0" cellspacing="0">
                                                            <tr vAlign="middle" class="TableHeaderOver">
                                                                <td vAlign="middle" align="center" width="10" height="23"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
                                                                <td colspan="2"><asp:Label ID="Label5" runat="server"><%#(DataBinder.Eval(Container.DataItem, "TableText"))%></asp:Label></td>
                                                            </tr>
                                                            </table>
                                                          
                                                         <asp:PlaceHolder ID="plhData5" runat="server" ></asp:PlaceHolder>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                             <asp:PlaceHolder ID="plhData4" runat="server" ></asp:PlaceHolder>
                                        </ItemTemplate>
                                    </asp:DataList>
                                    <asp:PlaceHolder ID="plhData3" runat="server" ></asp:PlaceHolder>
                                </ItemTemplate>
                            </asp:DataList>
                            <asp:PlaceHolder ID="plhData2" runat="server" ></asp:PlaceHolder>
                        </ItemTemplate>
                      </asp:DataList> 
                <asp:PlaceHolder ID="plhData1" runat="server" ></asp:PlaceHolder>
                </ItemTemplate>
            </asp:DataList>
       

       
            
    </form>
    
		<script language="javascript">
		var frm = document.Form1 ;
		function CheckAll( checkAllBox )
		{
		var actVar = checkAllBox.checked ;
		for(i=0;i< frm.length;i++)
		{
			e=frm.elements[i];
			if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
			e.checked= actVar ;
		}
		}
		</script>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>  
</body>
</html>
