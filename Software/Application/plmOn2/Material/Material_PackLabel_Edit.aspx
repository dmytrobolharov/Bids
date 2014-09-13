<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Material_PackLabel_Edit.aspx.vb" Inherits="plmOnApp.Material_PackLabel_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Packaging and Label</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
	<script language="javascript" SRC="../System/Jscript/YSCalendarFunctions.js"></script>
</head>
<body>
    <form id="form1" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				runat="server">
				<tr vAlign="middle">
					<td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnAddMaterial" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btmDelete" runat="server" 
							></cc1:confirmedimagebutton></td>
					<td class="FontHead" align="right" width="75"></td>
					<td width="40"></td>
					<td></td>
				</tr>
			</table>
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"></asp:label></td>
				</tr>
			</table>
			<table cellSpacing="2" cellPadding="0" width="100%" border="0">
				<tr>
					<td><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				</tr>
			</table>
			
			<br/>
			<cc2:ystabview id="YSTabView1" runat="server"></cc2:ystabview>
			<asp:Panel ID="pnlList" runat ="server" > 
                <asp:datagrid id="dgComponent" runat="server" ShowHeader="False" AutoGenerateColumns="false" BorderColor="Silver"
				    Width="100%" DataKeyField="ComponentTypeID">
				    <Columns>
					    <asp:TemplateColumn>
						    <ItemTemplate>
							    <table cellspacing="0" cellPadding="0" width="100%" border="0">
								    <TR class="TableHeader">
									    <TD width="10" bgColor="white" height="24"></TD>
									    <TD class="fontHead" bgColor="white"><%# DataBinder.Eval(Container.DataItem, "ComponentDescription") %></TD>
								    </TR>
							    </table>
							    <TABLE cellSpacing="1" cellPadding="1" width="100%" border="0">
								    <TR>
									    <TD width="100%">
										    <asp:datagrid id="dgComponentType" runat="server" Width="100%"  DataKeyField="MaterialPackLabelGroupItemID"
										        OnItemDataBound="dgComponentType_ItemDataBound" BorderColor="#E0E0E0">
											    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
											    <ItemStyle CssClass="ItemTemplate"></ItemStyle>
											    <HeaderStyle Height="25px" CssClass="TableHeaderOver"></HeaderStyle>
											    <Columns>
												    <asp:TemplateColumn HeaderStyle-Width="20">
												        <HeaderTemplate>
    												        
												        </HeaderTemplate>
													    <ItemTemplate>
													        <asp:checkbox runat ="server" ID="chkDelete" />
													    </ItemTemplate>
												    </asp:TemplateColumn>
	                                                <asp:TemplateColumn HeaderStyle-Width="75">
    												    <ItemTemplate>
													        <asp:Image id="imgMaterial" runat="server" ></asp:Image>
													    </ItemTemplate>
												    </asp:TemplateColumn>

											    </Columns>
										    </asp:datagrid></TD>
									    <TD width="99%"></TD>
								    </TR>
							    </TABLE>
						    </ItemTemplate>
					    </asp:TemplateColumn>
				    </Columns>
			    </asp:datagrid>			
                <asp:label id="SortOrder" runat="server" Visible="False"></asp:label>		
            </asp:Panel>	
            
            <asp:Panel ID="pnlImages" runat ="server" >

                 <table class="TableHeader" id="Table1" cellSpacing="0" cellPadding="0" width="100%" border="0" 
				    runat="server">
				    <tr vAlign="middle">
					    <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					    <td><cc1:BWImageButton id="btnNewImage" runat="server" Message="NONE" >
					    </cc1:BWImageButton></td>
				    </tr>
			    </table>				
    				
                <asp:DataList runat="server" ID="dlImages"  RepeatDirection="horizontal" RepeatColumns ="4" 
                    DataKeyField="MaterialPackLabelGroupImageID" >
				    <ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="Gainsboro"  VerticalAlign="Top"></ItemStyle>
				    <ItemTemplate>
				        <table cellpadding="0" cellspacing="0" border="0"  style="height:300px; width:300px; border:solid 1px #cccccc"  >
				        <tr valign="top">
				            <td> <cc1:confirmedimagebutton id="btnRemove" runat="server" Message="NONE" 
					             CommandName="Remove" /><cc1:confirmedimagebutton 
					            id="btnEdit" runat="server" Message="NONE" 
					             CommandName="Edit" />
                            </td>
				        </tr>
				        <tr align="center" height="250">
				            <td><cc1:bwimagebutton id="btnImage" runat="server" ></cc1:bwimagebutton></td>
				        </tr>
				        <tr><td>&nbsp;<input type="hidden" runat="server" id="txtImageID" /></td></tr>
				        
				        <tr  align="center">
				            <td><asp:Label runat="server" ID="lblDescription" CssClass="fontHead" ></asp:Label></td>
				        </tr>
				        </table>
				    </ItemTemplate>
                </asp:DataList>
            </asp:Panel>
            
		<script type="text/javascript" language="javascript" >
    		var frm = document.form1;
	    	function CheckAll( checkAllBox ) {
		        var actVar = checkAllBox.checked ;
		        for(i=0;i< frm.length;i++) {
			        e=frm.elements[i];
			       if ( e.type=='checkbox' && e.name.indexOf("chkDelete") != -1 )
			        e.checked= actVar ;
		        }
		    }
		</script>
            
    </form>
</body>
</html>
