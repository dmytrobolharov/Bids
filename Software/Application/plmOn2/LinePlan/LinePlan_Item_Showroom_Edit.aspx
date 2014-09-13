<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="LinePlan_Item_Showroom_Edit.aspx.vb" Inherits="plmOnApp.LinePlan_Item_Showroom_Edit" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register src="LinePlanningHeader.ascx" tagname="LinePlanningHeader" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Showroom</title>
    <LINK href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
	<LINK href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
    <script language="JavaScript">

	<!--

	if (window.screen) {
		var aw = screen.availWidth;
		var ah = screen.availHeight;
		window.moveTo(0, 0);
		window.resizeTo(aw, ah);
	}
	if (self != top) top.location.replace(self.location);	
	self.focus();
	//-->    
    
	<!--

        function findPosY(obj) {
            var curtop = 0;
            if (obj.offsetParent) {
                while (1) {
                    curtop += obj.offsetTop;
                    if (!obj.offsetParent)
                        break;
                    obj = obj.offsetParent;
                }
            } else if (obj.y) {
                curtop += obj.y;
            }
            return curtop;
        }
        
        function setPos(dv) {
            var oDiv = document.getElementById(dv)
            var pos = findPosY(oDiv);
            document.getElementById('form1').style.height
            var yPos = document.documentElement.clientHeight - pos - 15;
            oDiv.style.height = yPos ;
            //oDiv.style.Width = document.documentElement.clientWidth - 40+ 'px' ;
        }



        function lockCol(tblID) {
            var table = document.getElementById(tblID);
            var cTR = table.getElementsByTagName('tr');  //collection of rows

            var th = table.getElementsByTagName('th');
            th[0].className = 'lockedH'
            th[1].className = 'lockedH'
            th[2].className = 'lockedH'
            th[3].className = 'lockedH'
            th[4].className = 'lockedH'
            th[5].className = 'lockedH'
            th[6].className = 'lockedH'

            var sel = table.getElementsByTagName('select');
            for (i = 0; i < sel.length; i++) {
                sel[i].style.position = 'relative';
                sel[i].style.zIndex = 0;
            }
            
                      

            for (i = 1; i < cTR.length; i++) {

                var tr = cTR.item(i);
                tr.cells[0].className = 'locked'
                tr.cells[1].className = 'locked'
                tr.cells[2].className = 'locked'
                tr.cells[3].className = 'locked'
                tr.cells[4].className = 'locked'
                tr.cells[5].className = 'locked'
                tr.cells[6].className = 'locked'
                //alert(i);
            }

        }        
        
        


	//-->
    </script>		
	
	
    <style type="text/css">
        .DataGridHeader 
        {
            PADDING-RIGHT: 2px; 
            PADDING-LEFT: 2px; 
            FONT-WEIGHT: bold; 
            FONT-SIZE: 11px; 
            BACKGROUND-IMAGE: url(../System/Images/table_header.gif); 
            PADDING-BOTTOM: 2px; 
            PADDING-TOP: 2px; 
            BACKGROUND-REPEAT: repeat-x; 
            FONT-FAMILY: Tahoma, Geneva, Arial, Helvetica, sans-serif; 
            POSITION: relative; 
            TOP: expression(this.offsetParent.scrollTop) 
        }
                          
	    .DataGridControl 
	    { 
            FONT-FAMILY: Tahoma, Geneva, Arial, Helvetica, sans-serif; 
            POSITION: relative; 
	        TOP: expression(this.offsetParent.scrollTop); 
	        BACKGROUND-COLOR: #f5f5f5 
        }
        
        .locked
        {
            FONT-FAMILY: Tahoma, Geneva, Arial, Helvetica, sans-serif;
            FONT-WEIGHT: normal;
            FONT-SIZE: 11px; 
            COLOR: Black;	        
	        position:relative;
            left: expression(this.parentElement.parentElement.parentElement.parentElement.parentElement.parentElement.scrollLeft-2);
            border-width: 0;
            background-color: #CCFFFF;
        }


        .lockedH
        {
	        background-image: url(../System/Icons/table_header_blue.gif); 
	        background-repeat: repeat-x;
            FONT-FAMILY: Tahoma, Geneva, Arial, Helvetica, sans-serif;
            FONT-WEIGHT: bold;
            FONT-SIZE: 11px; 
            COLOR: Black;	        
	        position:relative;
	        padding:2px;
            cursor: default;
            border-width: 0;
            left: expression(this.parentElement.parentElement.parentElement.parentElement.parentElement.parentElement.scrollLeft-2);
            z-index: 999999999999;
        }
        
        
	</style>
			
</head>
<body  >
    <form id="form1" runat="server">
        <div class="FreezePane">
			    <table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0"
				    runat="server">
				    <tr valign="middle">
					    <td valign="middle" align="center" width="10"><asp:imagebutton id="btnInvSearch" runat="server" Height="0px" Width="0px" 
					        ImageUrl="../System/icons/1x1.gif"></asp:imagebutton><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
					    <td>
					    <cc1:confirmedimagebutton id="btnSave" runat="server" Message="NONE" style="height: 24px"></cc1:confirmedimagebutton>
					    <cc1:bwimagebutton id="btnChangeLog" runat="server" ></cc1:bwimagebutton>
					    <cc1:confirmedimagebutton id="btnClose" runat="server" Message="NONE"></cc1:confirmedimagebutton></td>
				    </tr>
			    </table>
			    <uc1:LinePlanningHeader ID="LinePlanningHeader1" runat="server" />
    		
                <br />
                <br />


                <table height="15" cellspacing="0" cellpadding="0" width="100%" bgcolor="white" border="0">
			        <tr>
				        <td><asp:placeholder id="plhSearchControlsHolder" runat="server" EnableViewState="False"></asp:placeholder></td>
				        <td width="100%" valign="top">
					        <table height="45">
						        <tr>
							        <td>
								        <asp:imagebutton id="imgBtnSearch" runat="server" ></asp:imagebutton></td>
						        </tr>
					        </table>
				        </td>
			        </tr>
		        </table> 
		    
		           

            <table  class="TableHeader" height="25" cellspacing="0" cellpadding="0" width="100%" bgColor="#ffffff"
	            border="0">
	            <tr valign="middle">
		            <td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
		            <td class="fonthead" width="10">&nbsp;</td>
		            <td width="20"><asp:imagebutton id="btnImgFirst" runat="server"></asp:imagebutton></td>
		            <td width="20"><asp:imagebutton id="btnImgPrevious" runat="server"></asp:imagebutton></td>
		            <td nowrap align="center" width="125"><asp:label id="lblPageCount" runat="server" CssClass="fonthead"></asp:label></td>
		            <td width="20"><asp:imagebutton id="btnImgNext" runat="server"></asp:imagebutton></td>
		            <td width="20"><asp:imagebutton id="btnImgLast" runat="server" ToolTip="Last"></asp:imagebutton></td>
		            <td width="10">&nbsp;</td>
		            <td width="100"><asp:label id="RecordCount" runat="server" CssClass="font"></asp:label></td>				
		            <TD align="right" width="110"><asp:label id="RecordPerPage" runat="server" CssClass="font"></asp:label></TD>
		            <td width="25"><asp:dropdownlist id="ps" runat="server" CssClass="fonthead">
				            <asp:ListItem Value="5">5</asp:ListItem>
				            <asp:ListItem Value="10">10</asp:ListItem>
				            <asp:ListItem Value="15">15</asp:ListItem>
				            <asp:ListItem Value="20">20</asp:ListItem>
				            <asp:ListItem Value="25" Selected="true">25</asp:ListItem>
			            </asp:dropdownlist></td>
		            <td width="10"><asp:button id="Button1" runat="server" CssClass="fonthead" text="GO"></asp:button></td>
		            <td>&nbsp;</td>
	            </tr>
            </table>
            </div>
            <!-- div style="width: 100%; height: 200px; overflow: auto; border: thin solid white" id="div-datagrid" --->  
                         <asp:datagrid id="DataGrid1"  runat="server"  EnableViewState="true" 
                             UseAccessibleHeader="True"  DataKeyField="StyleColorwaySeasonYearID" >
                            <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate">
                            </AlternatingItemStyle>
                            <ItemStyle CssClass="ItemTemplate"></ItemStyle>
                            <HeaderStyle Height="20px"  CssClass="DataGridFreezeHeader" ></HeaderStyle>
                            <PagerStyle Visible="False"></PagerStyle>
                            <Columns>
                                <asp:TemplateColumn>
                                    <ItemTemplate>
                                        <input type ="hidden"  runat ="server" id="hdnStyleID" />
                                        <input type ="hidden"  runat ="server" id="hdnStyleColorID" />
                                        <input type ="hidden"  runat ="server" id="hdnCostValue" />
                                        <input type ="hidden"  runat ="server" id="hdnVendorID" />
                                    </ItemTemplate>
                                </asp:TemplateColumn>
                            </Columns>
                            
                        </asp:datagrid><asp:label id="SortOrder" runat="server" Visible="False"></asp:label>
                    <input type="hidden" runat="server" id="hiddenCurrentPage"  value="0"/>
            <!--/div -->

            <input type ="hidden" runat ="server" id="hdnFilter" />
					
    </form>
</body>
</html>
