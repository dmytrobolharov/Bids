<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<%@ Page Language="vb" AutoEventWireup="false" Codebehind="Style_DimensionalBOMSelect.aspx.vb" Inherits="plmOnApp.Style.DimensionalBOM.Style_DimensionalBOMSelect" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head runat="server">
		<title></title>
		<META http-equiv="Content-Type" content="text/html; charset=windows-1252">	
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Grid_Y.css" type="text/css" rel="stylesheet" />
		<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet"/>
		<link href="../System/CSS/CheckListDropDown.css" type="text/css" rel="stylesheet"/>		
		<script language="javascript" src="../System/Jscript/arc90_multiselect.js"></script>	
		<script language="javascript" type="text/javascript">
		    // change the default options for all multiselects
		    a$.NO_SELECTION = 'No selection'; 	// TEXT for 'No selection' when nothing selected
		    a$.SELECTED = 'items selected'; // TEXT for 'XX Options selected' when over 1 selected
		    a$.SELECT_ALL = 'Select All'; 		// TEXT for 'Select All' for checkboxes
		    a$.SelectAllMin = 6; 				// minimum number of options needed to show 'Select All'
		    a$.WhenToUse = 'class'; 			// class | multiple | all : for how to make selects become multiselects
		    a$.msSeparator = '|'; 				// separator for values (can be multiple characters)
		</script>	
	    <style type="text/css">
            .style2
            {
                width: 490px;
            }
            #tblDim3
            {
                height: 85px;
            }
            #divQty
            {
                width:100%;overflow:auto;height:435px;
            }
            #divColor
            {
                width:100%;overflow:auto;height:435px;
            }              
            #divTreatment
            {
                width:100%;overflow:auto;height:435px;
            }    
            
            .HeaderText
            {
                font-family: Tahoma, Geneva, Arial, Helvetica, sans-serif;
	            font-size: 11px;
	            font-weight: bold; 	                
	              
	        }
            
        </style>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr valign="middle">
					<td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					<td><cc1:confirmedimagebutton id="btnSave" visible="false" runat="server" Message="NONE" ></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" ></cc1:confirmedimagebutton></td>					
				</tr>
			</table>
			
			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td valign="middle">
					    <asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large" ForeColor="#E0E0E0"></asp:label>
					</td>					
				</tr>
			</table>				
			
			<table  id="tblDim3" visible="false"  cellSpacing="0" cellpadding="0" 
                width="100%" border="0" runat="server" class="TableHeader">
		        <tr>
		            <td valign=top width="30%" >                        
	                  <asp:label id="lblDimTab" runat="server" visible="false" CssClass="fontHead"></asp:label>
	                  <asp:DropDownList ID="drDimTab" runat="server" AutoPostBack="true" visible="false" CssClass="fontHead"></asp:DropDownList>  
	                  <asp:Checkbox id="chbDimTab" runat="server" visible="false" text="Select All" CssClass="fontHead"></asp:Checkbox>		            	
                    </td>                               		            
		            <td valign=top>	            
                        <div class="examples">
	                        <label id="lbldrpTab" runat="server" class="examples"></label>                                
	                        <select id="chbdrpTab" name="chbdrpTab" class="arc90_multiselect"  multiple="true" size="4"  title="" runat="server"></select>				                        				                        
                        </div> 
                    </td>                                           			         
		        </tr>
			</table>	
					
			<cc2:ystabview id="YSTabView2" class="TableHeader" runat="server"></cc2:ystabview>&nbsp;&nbsp;
			
			<asp:Panel ID="pnlQuantity"  runat="server" >	
			    <table class="TableHeader" height="30" cellSpacing="0" cellpadding="0" width="100%" border="0">
			        <tr>                                           
                        <td>
                            <cc1:confirmedimagebutton id="btnQty" runat="server" Message="NONE"></cc1:confirmedimagebutton>&nbsp;&nbsp;
                            <cc1:confirmedimagebutton id="btnQtyClearAll" runat="server"></cc1:confirmedimagebutton>&nbsp;&nbsp;                             
                            <asp:label id="lblQtyApply" runat="server" CssClass="fontHead"></asp:label>&nbsp;
                            <asp:textbox id="txtApplyQty" runat="server" width='50' CssClass="fontHead"></asp:textbox>&nbsp
                            <asp:RegularExpressionValidator ID="valApplyQty" runat="server" ControlToValidate="txtApplyQty"
                            Display="Dynamic" EnableClientScript="true" Text="<IMG height='17' src='../System/Icons/icon_warning.gif' border='0'>" />
                            <cc1:confirmedimagebutton id="btnQtyApplyAll" runat="server" Message="NONE"></cc1:confirmedimagebutton>&nbsp;&nbsp;                               
                        </td>
                    </tr>
                    
			    </table>
			    <%--<table cellspacing="0" cellpadding="0" width="100%" border="0">
			        <tr><td valign="top" width="450">--%>
			    <div id="divQty">
			         <asp:datagrid id="DataGrid1" runat="server"  BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
						    PageSize="100">				   
						    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
						    <ItemStyle Height="20px"  CssClass="ItemTemplate"></ItemStyle>
						    <HeaderStyle Height="25px"  CssClass="TableHeader"></HeaderStyle>																		
				    </asp:datagrid>			
				</div>        
				   <%-- </td>
				    </tr>
			    </table>--%>	
			</asp:Panel>	
			<asp:Panel ID="pnlPrice"  runat="server"> 
			    <table class="TableHeader" height="30" cellSpacing="0" cellpadding="0" width="100%" border="0">
			        <tr>
                        <td>
                            <cc1:confirmedimagebutton id="btnPrice" runat="server" Message="NONE"></cc1:confirmedimagebutton>&nbsp;&nbsp;
                            <cc1:confirmedimagebutton id="btnPriceClearAll" runat="server"></cc1:confirmedimagebutton>&nbsp;&nbsp;
                            <asp:label id="lblPriceApply" runat="server" CssClass="fontHead"></asp:label>&nbsp;
                            <asp:textbox id="txtApplyPrice" runat="server" width='50' CssClass="fontHead"></asp:textbox>&nbsp
                            <asp:RegularExpressionValidator ID="valApplyPrice" runat="server" ControlToValidate="txtApplyPrice"
                            Display="Dynamic" EnableClientScript="true" Text="<IMG height='17' src='../System/Icons/icon_warning.gif' border='0'>" />
                            <cc1:confirmedimagebutton id="btnPriceApplyAll" runat="server" Message="NONE"></cc1:confirmedimagebutton>&nbsp;&nbsp;
                        </td>
                    </tr>
			    </table>
			    <div id="divPrice">
			         <asp:datagrid id="DataGridPrice" runat="server"  BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
						    PageSize="100">				   
						    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
						    <ItemStyle Height="20px"  CssClass="ItemTemplate"></ItemStyle>
						    <HeaderStyle Height="25px"  CssClass="TableHeader"></HeaderStyle>																		
				    </asp:datagrid>			
				</div>        
			</asp:Panel>	
			<asp:Panel ID="pnlColor"  runat="server" >	
			    <table class="TableHeader" height="30px" cellSpacing="0" cellpadding="0" width="100%" border="0">
			        <tr valign="top">                                           
                        <td valign="top">
                            <cc1:confirmedimagebutton id="btnColor" runat="server" Message="NONE"></cc1:confirmedimagebutton>&nbsp&nbsp;                            
                            <cc1:confirmedimagebutton id="btnColorClear" runat="server"></cc1:confirmedimagebutton>&nbsp;&nbsp;                      
                            <asp:label id="lblColorApply" runat="server" CssClass="fontHead" Message="NONE"></asp:label>&nbsp;                            
                            <input type="hidden" id="hdnColorName"  runat="server"/>
                            <input type="text" readOnly="readOnly" id="txtColorSel" name="txtColorSel" runat="server"/>                            
                            <cc1:bwimagebutton id="imgColorSelect" runat="server" ></cc1:bwimagebutton>&nbsp;&nbsp;                           
                            <cc1:confirmedimagebutton id="btnColorApply" runat="server" Message="NONE"></cc1:confirmedimagebutton>&nbsp;&nbsp;                          
                        </td>
                    </tr>
			    </table>
			 <%--   <table cellspacing="0" cellpadding="0" width="100%" border="0">
			        <tr><td valign="top" width="450">--%>
			        
			        <div id="divColor">  
				    <asp:datagrid id="DataGrid2" runat="server"  BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
							    PageSize="100" >
							    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>																		
				    </asp:datagrid>		
				    </div>
				    	
				   <%-- </td>
				    </tr>
			    </table>	--%>
			</asp:Panel>	
			<asp:Panel ID="pnlTreatment"  runat="server" >	
			    <table class="TableHeader" height="30" cellSpacing="0" cellpadding="0" width="100%" border="0">
			        <tr>                                           
                        <td>
                        <cc1:confirmedimagebutton id="btnTreatment" runat="server" Message="NONE"></cc1:confirmedimagebutton>&nbsp;&nbsp;
                        <cc1:confirmedimagebutton id="btnTreatmentClear" runat="server"></cc1:confirmedimagebutton>&nbsp;&nbsp;                      
                        <asp:label id="lblTreatmentApply" runat="server" CssClass="fontHead"></asp:label>&nbsp;
                        <input type="hidden" id="hdnTreatmentName"  runat="server"/>
                        <input type="text" readOnly="readOnly" id="txtTreatmentSel"  name="txtTreatmentSel" runat="server"/>                            
                        <cc1:bwimagebutton id="imgTreatmentSelect" runat="server" ></cc1:bwimagebutton>&nbsp;&nbsp;
                        <cc1:confirmedimagebutton id="btnTreatmentApply" runat="server" Message="NONE"></cc1:confirmedimagebutton>&nbsp;&nbsp;                           
                        </td>
                    </tr>
			    </table>
			    <%--<table cellspacing="0" cellpadding="0" width="100%" border="0">
			        <tr>
			        <td valign="top" width="450">--%>
			        <div id="divTreatment">
				    <asp:datagrid id="DataGrid3" runat="server"  BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px"
							    PageSize="100">
							    <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
							    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>																		
				    </asp:datagrid>	
				    </div>		
				   <%-- </td>
				    </tr>
			    </table>	--%>
			</asp:Panel>		
		</form>		
        <script language="javascript">
             var frm = document.Form1;
             function CheckAll(checkAllBox) {
                 var actVar = checkAllBox.checked;
                 for (i = 0; i < frm.length; i++) {
                     e = frm.elements[i];
                     if (e.type == 'checkbox' && (e.name.indexOf("chbDimRow") != -1 || e.name.indexOf("chbDimColorRow") != -1 || e.name.indexOf("chbDimSizeRow") != -1 
                     || e.name.indexOf("ChbDimCol") != -1 || e.name.indexOf("ChbDimColorCol") != -1 || e.name.indexOf("ChbDimSizeCol") != -1))
                         e.checked = actVar;
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
