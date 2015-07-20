<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_Model_Edit.aspx.vb" Inherits="plmOnApp.Style.Model.Style_Model_Edit" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Model Edit</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet"/>
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <style type="text/css">
    .overflowColumn
    {
        word-wrap: break-word;   
    }
    </style>
    <script language="javascript">
        function addCssClass() {
            //var arr = $(".fabric_type").find("span");
            $(".fabric_type").find("span").each(function (element) {
                element = $(this);
                element.addClass("overflowColumn");
                element.attr("title", element.text());
                //console.log(element.text());
            })
        }
    </script>
</head>
<body onload = "addCssClass();">
    <form id="form1" runat="server">
        <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
				height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="Small" Font-Bold="True">Style_Model_Edit</asp:label></td>
				</tr>
			</table>
<table class="TableHeader" id="Table1" cellspacing="0" cellpadding="0" width="100%"
        border="0" runat="server">
        <tr>
            <td>
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE" >
                </cc1:ConfirmedImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click()" >
                </cc1:ConfirmedImageButton>

                <br />
            </td>
        </tr>
      
        <tr>
            <td width="800px">
                <asp:PlaceHolder runat="server" ID="plhControlsHolder"></asp:PlaceHolder>
            </td>
        </tr>
        <tr>
            <td>
                <br />
            </td>
        </tr>
        <!-- Material Association Grid -->
        <tr>
            <td>
                <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
	                <tr class="TableHeader">
		                <td valign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" /></td>
		                <td width="20">		    
		                    <img id="imgToggleFabric" onclick="toggleMatGrid(this)" src="../System/Icons/icon_Next.gif" alt="" />
		                </td>
		                <td class="fontHead">&nbsp;
			            <asp:label id="lblMatAssoc" runat="server"></asp:label></td>
	                </tr>
                </table>
                <div id="pnlFabricType" style="display:none;">
                    <asp:DataGrid ID="dgMaterialFabricType" runat="server" AutoGenerateColumns="false" DataKeyField="CADModel2BOMId">
                        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
	                    <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
	                    <headerStyle Height="25px" CssClass="TableHeader"></headerStyle>
                        <Columns>
                            <asp:TemplateColumn>
                                <HeaderStyle BorderWidth="1pt" BorderColor="Gainsboro" />
                                <HeaderTemplate>
                                    <asp:CheckBox ID="chbUnlinkAll" onclick="CheckAll(this, 'chbUnlink')" runat="server" />
                                </HeaderTemplate>
                                <ItemStyle CssClass="SelectCheckbox" BorderWidth="1pt" BorderColor="Gainsboro" />
                                <ItemTemplate>
                                    <asp:CheckBox ID="chbUnlink" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                            <asp:BoundColumn DataField="ModelName" HeaderText="Model Name" Visible="False" 
                                ItemStyle-Width="100px" ItemStyle-BorderWidth="1px" ItemStyle-BorderColor="Gainsboro" ItemStyle-BorderStyle="solid"></asp:BoundColumn>
                            <asp:TemplateColumn>
                                <HeaderTemplate>
                                    <%#GetSystemText("Model Name")%>
                                </HeaderTemplate>
                                <ItemStyle BorderWidth="1px" BorderColor="Gainsboro" BorderStyle="Solid" />
                                <ItemTemplate>
                                <asp:Label ID="lblModelName" runat="server" text='<%# Container.DataItem("ModelName") %>' />
                                </ItemTemplate>   
                            </asp:TemplateColumn>
                            <asp:TemplateColumn>
                                <HeaderTemplate>
                                    <%#GetSystemText("Fabric Type")%>
                                </HeaderTemplate>
                                <ItemStyle BorderWidth="1px" BorderColor="Gainsboro" BorderStyle="Solid" />
                                <ItemTemplate>
                                    <asp:DropDownList ID="selFabricType" runat="server"></asp:DropDownList>
                                    <asp:HiddenField ID="hdnIsChanged" runat="server" Value="0" />
                                    <asp:HiddenField ID="hdnFabricType" runat="server" />
                                    <asp:HiddenField ID="hdnModelName" runat="server" Value='<%# Container.DataItem("ModelName") %>' />
                                </ItemTemplate>                    
                            </asp:TemplateColumn>
                            <asp:TemplateColumn>
                                <HeaderTemplate>
                                    <%#GetSystemText("Material Code")%>
                                </HeaderTemplate>
                                <ItemStyle BorderWidth="1px" BorderColor="Gainsboro" BorderStyle="Solid" />
                                <ItemTemplate>
                                    <asp:DropDownList ID="selMaterial" runat="server"></asp:DropDownList>
                                    <asp:HiddenField ID="hdnMaterial" runat="server" />
                                    <asp:HiddenField ID="hdnMaterialName" runat="server" />
                                </ItemTemplate>
                            </asp:TemplateColumn>
                        </Columns>
                    </asp:DataGrid>
                    <input type="hidden" runat="server" id="hdnMatGridIsExp" value="0" />
                    <cc1:ConfirmedImageButton ID="btnUnlinkMF" Message="NONE" runat="server" />
                    <asp:Button ID="btnSaveMaterial2Fabric" runat="server" style="display:none;" Text="Save" />            
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <br />
            </td>
        </tr>
        <!-- Piece Views -->
        <tr>
            <td>
                <cc2:YSTabView ID="YSTabView2" runat="server"></cc2:YSTabView>
            </td>
        </tr>
        <tr>
            <td>
                <!-- Piece List View -->
           
                		<asp:datagrid id="DataGrid1" runat="server" AllowSorting="False" DataKeyField="ID">
							<AlternatingItemStyle Height="25px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
							<ItemStyle Height="25px" CssClass="ItemTemplate"></ItemStyle>
							<HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
							<PagerStyle Visible="False"></PagerStyle>
							   <Columns>
			                    <asp:TemplateColumn>
			                        <HeaderTemplate >
					                    <input type="checkbox" id="checkAll" onClick="CheckAll(this, 'chkDelete');" runat="server" name="checkAll">
				                    </HeaderTemplate>
				                    <ItemTemplate>
					                    <asp:CheckBox ID="chkDelete" runat="server"></asp:CheckBox>
				                    </ItemTemplate>
			                    </asp:TemplateColumn>
		                    </Columns>
						</asp:datagrid>
                <asp:Label ID="SortOrder1" runat="server" Visible="False"></asp:Label>
            </td>
        </tr>
    </table>
     <table cellspacing="2" cellpadding="0" width="550" border="0">
		<tr class="fontHead">								
			<td style="width: 400px; height: 24px"> 
			<cc1:confirmedimagebutton id="BtnAdd" runat="server" Message="NONE" >
           </cc1:confirmedimagebutton>
			<cc1:confirmedimagebutton id="imgBtnRemove" runat="server" Message="NONE" ></cc1:confirmedimagebutton>
			</td>
		</tr>
	 </table>
        <table bordercolor="gainsboro" cellspacing="1" cellpadding="0" border="0">
        <tr>
            <td valign="top">
                <asp:DataList ID="Datalist2" runat="server" EnableViewState="false" RepeatDirection="Horizontal"
                    RepeatColumns="1" RepeatLayout="Table" DataKeyField="ID">
                    <ItemStyle HorizontalAlign="Left" BorderWidth="0px" BorderStyle="Solid" BorderColor="Gainsboro"
                        VerticalAlign="Top" BackColor="White"></ItemStyle>
                    <HeaderStyle HorizontalAlign="Left"></HeaderStyle>
                    <ItemTemplate>
                        <table id="tbItem" runat="server" bordercolor='#CCCCCC' border="1" cellpadding="0"
                            width="100%" cellspacing="0">
                            <tr>
                                <td>
                                    <table class="TableHeader" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td>
                                                <asp:Label ID="lblEdit" runat="server"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                                                      <tr>
                                <td valign="top" style="height: 250px; width: 300px">
                                    <asp:Image ID="imgDesign" runat="server" />
                                </td>

                            </tr>
                            <tr>
                                <td>
                                    <asp:LinkButton ID="btndownload" runat="Server" OnClientClick="dont_show_wait_twice();" CommandName="download"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:PlaceHolder ID="pnlHeader" runat="server"></asp:PlaceHolder>
                                </td>
                            </tr>
                        </table>
                        <input type="hidden" id="txtImageVersion" runat="server" />
                        <input type="hidden" id="txtImageFileName" runat="server" /><br />
                    </ItemTemplate>
                </asp:DataList>
            </td>
        </tr>
    </table>
    <input id="imageSize" type="hidden" runat="server" />
    </form>
    
</body>
    <script type="text/javascript" language="javascript">
        var frm = document.form1;
        function CheckAll(checkAllBox, what) {
           var actVar = checkAllBox.checked;
           for (i = 0; i < frm.length; i++) {
               e = frm.elements[i];
               if (e.type == 'checkbox' && e.name.indexOf(what) != -1)
                   if (e.disabled == false)
                   e.checked = actVar;
           }
        }

        

        function toggleMatGrid(trigger) {
            var panel = document.getElementById("pnlFabricType"),
                state = panel.style.display;

            if (state === "none") {
                panel.style.display = "block";
                trigger.src = "../System/Icons/icon_Down.gif"
            } else {
                panel.style.display = "none";
                trigger.src = "../System/Icons/icon_Next.gif"
            }

            document.getElementById("hdnMatGridIsExp").value = (state === "none" ? 1 : 0)
            return false;
        }

        // restore material grid state
        if (document.getElementById("hdnMatGridIsExp").value === "1") {
            toggleMatGrid(document.getElementById("imgToggleFabric"))
        }

        // fix for ie6, other browsers don't allow selecting disabled options
        var selected = {};
        function saveSelectedIndex(sel) {
           selected[sel.id] = sel.selectedIndex;
        }

        function checkForPost(sel1, sel2, hdn) {
           var $ = function(el) {
               return document.getElementById(el);
           },
                sel1 = $(sel1), sel2 = $(sel2);

           // fix for ie6, other browsers doesn't allow selecting disabled options
           if (sel1.options[sel1.selectedIndex].disabled) {
               sel1.selectedIndex = selected[sel1.id];
               return false;
           }

           if (sel2.options[sel2.selectedIndex].disabled) {
               sel2.selectedIndex = selected[sel2.id];
               return false;
           }

           if (sel1.selectedIndex != 0 && sel2.selectedIndex != 0) {
               $(hdn).value = "1";
               $("btnSaveMaterial2Fabric").click();
           }

           selected[sel1.id] = sel1.selectedIndex;
           selected[sel2.id] = sel2.selectedIndex;

           return false;
        }
    </script>
    <script language="javascript">
	    function btnClose_Click() {
		    <%= strExitScript %>
            return false;
        }
    </script>
</html>
