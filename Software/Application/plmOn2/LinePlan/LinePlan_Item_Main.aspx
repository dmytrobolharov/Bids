<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_Item_Main.aspx.vb" Inherits="plmOnApp.LinePlan_Item_Main" %>
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
	
</head>
<body>
    <form id="form1" runat="server" >

			<TABLE class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<TR vAlign="middle">
					<TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
					<TD><asp:imagebutton id="btnInvSearch" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton>
					<cc1:confirmedimagebutton  id="btnSave" runat="server"  Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton  id="btnClose" runat="server"  Message="NONE" CausesValidation="false" ></cc1:confirmedimagebutton></TD>
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
				        <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
				        <TD><cc1:bwimagebutton id="btnNew" runat="server"  Message="NONE">
				        </cc1:bwimagebutton></TD>
			         </TR>
		         </TABLE>
            
	                
                 
		         <asp:DataList ID="dlGroups" runat ="server"  RepeatDirection="Vertical" Width="100%" RepeatColumns="1" >
		                 <ItemTemplate>
                
	                 
		                    <table class="TableHeader" id="TABLE1" cellSpacing="0" cellPadding="0" width="100%" border="0" >
			                    <tr  height="25">
			                        <td ><asp:Label ID="lbGroupName" runat="server" ><%#GetSystemText("GroupName")%></asp:Label></td>
			                    </tr>
			                 </table>

                            <table cellSpacing="0" cellPadding="0" width="100%" border="0"  >
                            <tr >
                                <td  valign="top" style="width:100px;">
                                    <asp:PlaceHolder ID="pnlFinance" runat ="server" ></asp:PlaceHolder>
                                    <input type="hidden" id="txtLinePlanGroupTypeItemID" runat="server" />
                                </td>

                                <td>
                                    <asp:Panel ID="Panel1" runat="Server"
                                     Height="100%" Width="850px" ScrollBars="Horizontal" >
                                    <asp:datalist id="dlStyles" runat="server" DataKeyField="LinePlanItemID" RepeatLayout="Table" RepeatDirection="Horizontal" EnableViewState="false"  
                                    OnItemDataBound="dlStyles_ItemDataBound " CellPadding="0" CellSpacing="0"  >
                                    <ItemStyle VerticalAlign="top" />
                                    <AlternatingItemStyle VerticalAlign="top"   />
                                    <ItemTemplate>
                                        <table id="tbItem" runat="server" bordercolor='#CCCCCC'  border="1"  cellpadding="0" cellspacing="0" >
                                            <tr>
                                               <td ><table  class="TableHeader"  width ="100%" >
                                                    <tr><td><cc1:bwimagebutton id="btnEditItem" runat="server"  /></td></tr>
                                                    </table>
                                               </td>
                                             </tr>
                                            <tr align="center"  height="200"  ><td><cc1:bwimagebutton id="imgDesign" runat="server" /></td></tr>
                                            <tr><td><asp:PlaceHolder ID="pnlHeader" runat="server" ></asp:PlaceHolder></td></tr>
                                       </table>
                                    </ItemTemplate>
                                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                                    </asp:datalist>					                    
                                   </asp:Panel>
                                </td>
                                 
                             </tr>
                            </table>		                                    
                        
		                </ItemTemplate>
		         </asp:DataList>
		         
		              
       		                
                <table class="TableHeader"  cellSpacing="0" cellPadding="0" width="100%" border="0"  runat="server" id="tbNoGroupStyles">
                <tr  height="25"><td ><asp:Label ID="lbNoGroupName" runat="server" ></asp:Label></td></tr>
                <tr><td valign="top">
                    <asp:datalist id="dlStylesNoGroup" runat="server" DataKeyField="LinePlanItemID" RepeatLayout="Table" RepeatColumns="4"
	                RepeatDirection="Horizontal" EnableViewState="false"  OnItemDataBound="dlStyles_ItemDataBound" >
	                    <ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="Gainsboro"
		                    VerticalAlign="Top" BackColor="White"></ItemStyle>
	                    <ItemTemplate>
	                        <table id="tbItem" runat="server" bordercolor='#CCCCCC'  border="1"  cellpadding="0" cellspacing="0" >
	                            <tr>
	                               <td ><table  class="TableHeader"  width ="100%" >
	                                    <tr><td><cc1:bwimagebutton id="btnEditItem" runat="server" /></td></tr>
	                                    </table>
	                               </td>
	                             </tr>
	                            <tr align="center" height="200"  ><td><cc1:bwimagebutton id="imgDesign" runat="server" /></td></tr>
	                            <tr><td><asp:PlaceHolder ID="pnlHeader" runat="server" ></asp:PlaceHolder></td></tr>
	                            
	                       </table><br/>
	                    </ItemTemplate>
	                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    </asp:datalist>		                
                
                </td></tr>
                </table>

            </asp:Panel>
            
            
            
            <asp:Panel  runat ="server" ID="pnlMaterials"  visible="false">
                <br/>
                
                
                
                    <asp:DataList ID="dlGroupMaterials" runat ="server"  RepeatDirection="Vertical" Width="100%" RepeatColumns="1" >
		                 <ItemTemplate>
		                    <table class="TableHeader" id="TABLE1" cellSpacing="0" cellPadding="0" width="100%" border="0" >
			                    <tr  height="25">
			                        <td ><asp:Label ID="lbGroupName" runat="server" ><%#GetSystemText("GroupName")%></asp:Label></td>
			                    </tr>
			                 </table>

                            <table cellSpacing="0" cellPadding="0" width="100%" border="0"  >
                            <tr>
                                <td>

                <asp:datalist id="dlMaterials" runat="server" DataKeyField="StyleMaterialID" RepeatLayout="Table" RepeatColumns="4"
                    RepeatDirection="Horizontal" EnableViewState="false"   OnItemDataBound="dlMaterials_ItemDataBound">
                    <ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="Gainsboro"
                        VerticalAlign="Top" BackColor="White" ></ItemStyle>
                    <ItemTemplate>
                        <table id="tbItem" runat="server"  border="1"  cellpadding="0" cellspacing="0" >
                            <tr><td>
                            
                                <asp:PlaceHolder runat ="server"  ID="phStyleMaterial"></asp:PlaceHolder>

    		                                    
                            </td></tr>
                            <tr align="center" height="250" ><td><cc1:bwimagebutton id="imgMaterial" runat="server"  /></td></tr>
                            <tr><td width="100%" align="center">
                                <br/>
                                <asp:datalist id="dlColors" runat="server" DataKeyField="MaterialColorID" RepeatLayout="Table" RepeatColumns="5"
                                     OnItemDataBound="dlColors_ItemDataBound" RepeatDirection="Horizontal" EnableViewState="false"  >
                                    <ItemStyle HorizontalAlign="Center"  Width="40"/>
                                    <ItemTemplate>
                                            <asp:Image runat="server" id="imgColor" />
                                    </ItemTemplate>
                                </asp:datalist>
                             </td></tr>
                         </table><br/>
                    </ItemTemplate>
                </asp:datalist>	
                                    
                                </td>
                             </tr>
                            </table>		                                    
		                </ItemTemplate>
		         </asp:DataList>                
                
                
                <asp:datalist id="dlMaterialsNoGroupType" runat="server" DataKeyField="StyleMaterialID" RepeatLayout="Table" RepeatColumns="4"
                    RepeatDirection="Horizontal" EnableViewState="false"  >
                    <ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="Gainsboro"
                        VerticalAlign="Top" BackColor="White" Width="280px"></ItemStyle>
                    <ItemTemplate>
                        <table id="tbItem" runat="server"  border="0"  cellpadding="0" cellspacing="0" >
                            <tr><td>
                                <TABLE class="TableHeader" id="TABLE1" cellSpacing="0" cellPadding="0" width="100%" border="0"
			                    runat="server">
			                        <TR vAlign="middle">
				                        <TD vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></TD>
				                        <TD><asp:Label ID="lblStyleMaterial" runat="server"></asp:Label></TD>
			                        </TR>
    		                    </TABLE>                
                            </td></tr>
                            <tr align="center" height="250" ><td><cc1:bwimagebutton id="imgMaterial" runat="server"  /></td></tr>
                            <tr><td width="100%" align="center">
                                <br/>
                                <asp:datalist id="dlColors" runat="server" DataKeyField="MaterialColorID" RepeatLayout="Table" RepeatColumns="5"
                                     OnItemDataBound="dlColors_ItemDataBound" RepeatDirection="Horizontal" EnableViewState="false"  >
                                    <ItemStyle HorizontalAlign="Center"  Width="40"/>
                                    <ItemTemplate>
                                            <asp:Image runat="server" id="imgColor" />
                                    </ItemTemplate>
                                </asp:datalist>
                             </td></tr>
                         </table><br/>
                    </ItemTemplate>
                </asp:datalist>	                

             </asp:Panel>	                
            


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
</body>
</html>
