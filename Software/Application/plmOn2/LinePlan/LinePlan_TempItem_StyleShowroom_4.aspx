<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_TempItem_StyleShowroom_4.aspx.vb" Inherits="plmOnApp.LinePlan_TempItem_StyleShowroom_4" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" >

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Showroom</title>
	<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
	<LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">    
</head>
<body>
    <form id="form1" runat="server">
    		<table class="TableHeader" id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE"></cc1:confirmedimagebutton>
					<cc1:confirmedimagebutton id="btnCancel" runat="server" Message="NONE" ></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75"></td>
				</tr>
			</table>
			
            <table cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0" >
			    <TR>
				    <TD>&nbsp;
					    <asp:label id="lbHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0">Vendor</asp:label></TD>
			    </TR>
		    </table>			
		
		<asp:datagrid id="dgMatrix" runat="server" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
				AutoGenerateColumns="false"   DataKeyField="LinePlanTempItemShowroomStyleColorID" >
				<AlternatingItemStyle BackColor="AliceBlue"></AlternatingItemStyle>
				<Columns > 
                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <ItemTemplate>
                            <input id="hdnStyleColorID" type="hidden" runat="server" value='<%# Container.DataItem("StyleColorID").ToString() %>' />
                            <asp:Image runat="server" ID="imgStyle"  />
                         </ItemTemplate>
                    </asp:TemplateColumn>
                    
                    <asp:TemplateColumn >
                        <HeaderStyle CssClass="TableHeader" />
                        <ItemStyle Width="30" HorizontalAlign="Center" />
                        <ItemTemplate>
                            <asp:Image runat="server" ID="imgColor" />
                         </ItemTemplate>
                    </asp:TemplateColumn>

                    <asp:TemplateColumn>
                        <ItemStyle Width = "30"  HorizontalAlign="Center"/>
                        <HeaderStyle  CssClass="fontHead"/>
                        <HeaderTemplate><%#GetSystemText("StyleNo")%></HeaderTemplate>
		                <ItemTemplate>
		                    <asp:Label runat="server" ID="lblStyleNo" Text='<%# Convert.ToString(Container.DataItem("StyleNo")) %>' ></asp:Label>
		                </ItemTemplate>
		            </asp:TemplateColumn>
    		        
		            <asp:TemplateColumn>
                        <ItemStyle Width = "30"  HorizontalAlign="Center"/>
                        <HeaderStyle  CssClass="fontHead"/>
                        <HeaderTemplate><%#GetSystemText("Description")%></HeaderTemplate>
		                <ItemTemplate>
		                    <asp:Label runat="server" ID="lblDescription" Text='<%# Convert.ToString(Container.DataItem("Description")) %>' ></asp:Label>
		                </ItemTemplate>
		            </asp:TemplateColumn>
		                            
                 </Columns>
				
		</asp:datagrid>
				
		    
		    <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />  
		    
		    
		    
		    
		    
		    
            <asp:DataGrid  ID="dgStyles" runat="server"  AutoGenerateColumns="false" BorderWidth="0"> 
			<HeaderStyle CssClass="TableHeader" Height="25px"></HeaderStyle>
			<PagerStyle Visible="False"></PagerStyle>
		    <Columns >

		        <asp:TemplateColumn>
		            <ItemTemplate>
		                <input type="hidden" runat="server"  id="hdnStyleColorID" />
		                <input type="hidden" runat="server"  id="hdnShowroomID" />
		                <asp:Image runat="server" ID="imgDesign"   />
		            </ItemTemplate>
		        </asp:TemplateColumn>
		        
    		    <asp:TemplateColumn>
		            <ItemStyle Width = "30"  HorizontalAlign="Center"/>
		            <ItemTemplate>
		                <asp:Image runat="server" ID="imgColor"/>
		            </ItemTemplate>
		        </asp:TemplateColumn>
		        

		    </Columns>
		    
		    </asp:DataGrid>		    
		    
		    
		    
		    

    </form>
</body>
</html>
