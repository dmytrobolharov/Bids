<%@ Register TagPrefix="uc2" TagName="Style_Header" Src="Style_Header.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Workflow" Src="Style_Workflow.ascx" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_DevelopmentMeas.aspx.vb" Inherits="plmOnApp.Style.Measurements.Style_DevelopmentMeas" %>
<%@ Register TagPrefix="uc1" TagName="Style_Comment" Src="Style_Comment.ascx" %>
<%@ Register TagPrefix="uc1" TagName="Style_Change_Alert" Src="Style_Change_Alert.ascx" %>
<%@ Register TagPrefix="uc3" TagName="Style_WorkflowItem" Src="Style_WorkFlowItem.ascx" %>
<%@ Register TagPrefix="uc4" TagName="Style_FabricGrid" Src="Style_FabricGrid.ascx" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">
<html>
	<head>
		<title>Style Development Spec</title>
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
        <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
	    <script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	    <script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
        <style type="text/css">
            #DataGrid1 .TableHeader {background-repeat: repeat;}
            #DataGrid1 .TableHeaderGreen {background-repeat: repeat;}
            #DataGrid1 .TableHeader table {
                font-size: inherit;
                font-weight: inherit;
            }
        </style>
	</head>
	<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
		<form id="Form1" method="post" runat="server" defaultbutton="imgBtnSearch">		    
			<uc1:style_workflow id="Style_Workflow1" runat="server" WFIID='<%Request("WFIID")%>'></uc1:style_workflow>			
			<asp:panel id="pnlChange" runat="server">
				<uc1:Style_Change_Alert id="Style_Change_Alert2" runat="server"></uc1:Style_Change_Alert>
			</asp:panel>
			<uc2:style_header id="Style_Header1" runat="server" StyleID='<%Request("SID")%>'></uc2:style_header>
			<uc1:style_comment id="Style_Comment1" runat="server"></uc1:style_comment>
			<uc4:Style_FabricGrid ID="Style_FabricGrid1" runat="server" IsReadOnly="true" />
			<uc3:Style_WorkflowItem id="Style_WorkflowItem1" runat="server" />
            <table>
                <tr>
                    <td height="3"></td>
                </tr>
            </table>
  			    <asp:Panel runat="server" ID="pnlBtn" Visible="true">
			        <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" height="30" border="0">
				        <tr>
					        <td valign="middle" align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					        <td nowrap="nowrap">
					            <cc1:confirmedimagebutton id="btnLink" visible="false" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                                <cc1:confirmedimagebutton id="btnBreakLink" visible="false" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
                                <cc1:BWImageButton id="btnCritical" visible="false" runat="server" Message="NONE" ></cc1:BWImageButton>
					            <cc1:BWImageButton id="btnSamplesize" visible="true" runat="server" Message="NONE" ></cc1:BWImageButton>
                                <cc1:BWImageButton id="btnshowhidesizes"  visible="true" runat="server" Message="NONE" ></cc1:BWImageButton>	
                                <cc1:confirmedimagebutton id="btnHowtoMeas"  visible="true" runat="server" Message="NONE" > </cc1:confirmedimagebutton>    
                                <cc1:confirmedimagebutton id="btnEditSample" visible="true" runat="server" Message="NONE" ></cc1:confirmedimagebutton> 
                                <cc1:BWImageButton id="btnBeforeTreat" visible="true" runat="server" Message="NONE" ></cc1:BWImageButton>                                                 
                                <cc1:confirmedimagebutton id="btnChangeMeasInfo" visible="false" runat="server" Message="NONE" ></cc1:confirmedimagebutton>     
					        </td>
					        <td valign="middle" align="right" height="25" width="100%">
					            <IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3">
					        </td>
					        <td valign="middle" align="center" height="25" nowrap="nowrap">
					            <asp:Panel runat="server" ID="pnlImageBtn" Visible="true">
    					            <asp:imagebutton ID="btn_update" runat="server" />
    					            <asp:imagebutton ID="btn_cancel" runat="server" />
                                    <asp:imagebutton ID="btn_createimage" runat="server" />
    					            <asp:imagebutton ID="btn_editimage" runat="server" />
    					            <asp:imagebutton ID="btn_selectimage" runat="server" />
    					            <asp:imagebutton ID="btn_save" runat="server" />
    					            <asp:imagebutton ID="btn_remove" runat="server" />
    					        </asp:Panel> 
					        </td>
				        </tr>
			        </table>
			    </asp:Panel>          
                        			
			<cc2:ystabview id="YSTabView2" runat="server"></cc2:ystabview>			     			
			<%--<table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
				<tr>
					<td valign="middle" align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><asp:label id="lblMeasHeader" runat="server">Worksheet Information</asp:label></td>
				</tr>
			</table>--%>
			<asp:Panel runat="server" ID="pnlContent" Visible="true">
	
        	    <table cellspacing="0" cellpadding="0" width="100%" border="0">	
                <tr>
                <td valign="top" width="50%">
			    <table cellspacing="0" cellpadding="0" width="100%" border="0">
				    <tr>
					    <td valign="top" width="100%" bgColor="#ffffff">					    
    						
							    <asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder>						
					    </td>
				    </tr>
			    </table>	
			    <table cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
				    <tr vAlign="top">
					    <td>	
			            <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
				            <tr>
					            <td valign="middle" align="center" width="10" height="25"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					            <td><asp:label id="lblPoMSearch" runat="server"></asp:label></td>
				            </tr>
			            </table>					
					    <table height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="white" border="0">
						    <tr>
							    <td><asp:CheckBox ID="ChbShowHide" width="120" CssClass="fontHead" autopostback="true" runat="server" 
                                        Text="Show Sort ID" /></td>
							    <td><asp:placeholder id="plhSearchControl" runat="server" EnableViewState="False"></asp:placeholder></td>								
							    <td vAlign="top" width="100%">
								    <table height="45">
									    <tr>
										    <td><asp:imagebutton id="imgBtnSearch" runat="server" /></td>											
									    </tr>
								    </table>
							    </td>																
						    </tr>
					    </table>														
			            <table class="TableHeader" height="15" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff"
				            border="0">
				            <tr vAlign="middle">
					            <td vAlign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					            <td class="fontHead" width="10"></td>
					            <td width="20"><asp:imagebutton id="btnImgFirst" runat="server"  ImageUrl="../System/Icons/icon_first_disable.gif"></asp:imagebutton></td>
					            <td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"  ImageUrl="../System/Icons/icon_Previous_disable.gif"></asp:imagebutton></td>
					            <td noWrap align="center" width="100"><asp:label id="lblPageCount" runat="server" CssClass="fontHead"></asp:label></td>
					            <td width="20"><asp:imagebutton id="btnImgNext" runat="server"  ImageUrl="../System/Icons/icon_next_disable.gif"></asp:imagebutton></td>
					            <td width="20"><asp:imagebutton id="btnImgLast" runat="server" ImageUrl="../System/Icons/icon_last_disable.gif"></asp:imagebutton></td>
					            <td width="10">&nbsp;</td>
					            <td noWrap><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>
					            <td class="fontHead" align="right" width="110"><asp:Label ID="lblRecordsPerPage" runat="server" ></asp:Label></td>
					            <td width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fontHead">
							            <asp:ListItem Value="5">5</asp:ListItem>
							            <asp:ListItem Value="10">10</asp:ListItem>
							            <asp:ListItem Value="15">15</asp:ListItem>
							            <asp:ListItem Value="20">20</asp:ListItem>
							            <asp:ListItem Value="25">25</asp:ListItem>
							            <asp:ListItem Value="30">30</asp:ListItem>
							            <asp:ListItem Value="40">40</asp:ListItem>
							            <asp:ListItem Value="50" Selected="True">50</asp:ListItem>
						            </asp:dropdownlist></td>
					            <td width="10"><asp:button id="btnRepage" onclick="RePage" runat="server" CssClass="fontHead" ></asp:button></td>
				            </tr>
			            </table>												
    						        
			            <asp:datagrid id="DataGrid1" runat="server" BorderColor="Silver" 
                            BorderStyle="Solid" BorderWidth="1px"
					            PageSize="100" AutoGenerateColumns="False" AllowPaging="true" PagerStyle-Visible="false">
					            <AlternatingItemStyle Height="20px" BackColor="AliceBlue"></AlternatingItemStyle>
					            <ItemStyle Height="20px" CssClass="font" BackColor="White"></ItemStyle>
					            <HeaderStyle Height="20px" CssClass="TableHeader"></HeaderStyle></asp:datagrid>	
					    </td>					        
					            
					    <td valign="top"><asp:label id="SortOrder" runat="server" Visible="False"></asp:label><asp:image id="imgDesign" style="display:none" runat="server" BorderColor="Transparent"></asp:image></td>
 		        
			        </tr>  
			    </table>
			    </td>
				       <td  id="imagepnl" runat="server" align="left" valign="top" width="50%">
				       <!-- <cc2:YSTabView ID="YSTabView3" runat="server" /> -->
       				   
				       <asp:label ID="lblFileLocked" runat="server" Visible="false"></asp:label>
				       <cc1:bwimagebutton id="imgDesignMeas" runat="server" /> <br />
				       <!-- <asp:TextBox ID="TextBMeas" runat="server"  /><asp:imagebutton ID="btn_size_fix" runat="server" /> -->
				        </td>
				       </tr>
			    </table>
			</asp:Panel>
			<asp:Panel runat="server" ID="pnlPerm" Visible="false">
                <table style="height:50;" cellspacing="0" cellpadding="0" width="100%"  bgColor="#990000" border="1" borderColor="red">
                    <tr>
                        <td>
                            <table style="height:25;" cellspacing="0" cellpadding="0" width="100%" border="0">
                                <tr>
                                    <td width="25"><div align="center"><asp:image id="imgWorkStatus" ImageUrl="../System/Icons/icon_lock.gif" runat="server"></asp:image></div></td>
                                    <td>
                                          <asp:Label ID="lblPerm" runat="server" 
                                        Text="You might not have permission to access this tab using your credentials." 
                                        CssClass="fontHead" ForeColor="White"></asp:Label>                         
                                    
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:Panel> 	
			<table id="Table5" height="24" cellspacing="0" cellpadding="0" width="100%" border="0"
				runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_left.gif"></td>
					<td class="TableBar" valign="middle" align="center" width="20"><IMG src="../System/icons/icon_changeobject.gif"></td>
					<td class="TableBar">
						<asp:label id="lblCreatedBy" runat="server" CssClass="fontHead" ForeColor="Gray"></asp:label>&nbsp;/
						<asp:label id="lblModifiedBy" runat="server" CssClass="fontHead"></asp:label></td>
					<td valign="middle" align="center" width="7"><IMG src="../System/Images/table_bar_right.gif"></td>
				</tr>
			</table>			

  

		</form>
	</body>
</html>
