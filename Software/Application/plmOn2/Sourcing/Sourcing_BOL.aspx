<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_BOL.aspx.vb"
    Inherits="plmOnApp.Sourcing_BOL" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title runat="server" id="PageTitle">Sourcing</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet">
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />

    <script language="javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>
    <script language="javascript" src="../System/Jscript/Custom.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <table class="TableHeader" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr valign="middle" height="25">
            <td valign="middle" align="center" width="10">
                <img height="15" alt="" src="../System/Images/bbTbSCnr.gif" width="3">
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE" />
                <cc1:ConfirmedImageButton ID="btnGoTo" runat="server" Message="NONE" />
                <cc1:BWImageButton ID="btnPreview" runat="server" Message="NONE"></cc1:BWImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="return btnClose_Click();"/>
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;
                <asp:Label ID="lbHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="X-Large"
                    ForeColor="Silver">Bill of Materials</asp:Label>
            </td>
        </tr>
    </table>
    <table id="Table1" cellspacing="1" cellpadding="1" width="100%" bgcolor="#ffffff"
        border="0">
        <tr>
            <td>
                <asp:PlaceHolder ID="plhHeaderControl" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
    </table>
    <asp:Panel ID="pnlSeasonYear" runat="server">
        <table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
            border="0">
            <tr valign="middle">
                <td valign="middle" align="center" width="10">
                    <img height="15" alt="" src="../System/Images/bbTbSCnr.gif" width="3" />
                </td>
                <td width="20">
                    <img alt="" src="../System/Icons/icon_season.gif" />
                </td>
                <td nowrap="nowrap">
                    <asp:Label runat="server" ID="lblSeasonYearLabel" class="fontHead"></asp:Label>&nbsp;
                    <asp:Label ID="lblStyleSeasonYear" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <table cellspacing="1" cellpadding="1" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td width="900">
                <asp:PlaceHolder ID="plhControlsHolder" runat="server"></asp:PlaceHolder>
            </td>
            <td valign="top">
                <table cellpadding="0" cellspacing="0">
                    <tr class="TableHeader" height="20" valign="middle">
                        <td>
                            <table cellspacing="0" cellpadding="0" width="150" border="0">
                                <tr valign="middle">
                                    <td valign="middle" align="center" width="10">
                                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                                    </td>
                                    <td>
                                        <input type="checkbox" id="chkAll" onclick="CheckAllColor(this)">&nbsp;&nbsp;
                                        <asp:Label runat="server" ID="lblSelColorway" CssClass="fontHead"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:DataList runat="server" ID="dlStyleColor" DataKeyField="StyleColorID" Width="100%">
                                <ItemStyle BorderWidth="1px" BorderStyle="Solid" BorderColor="Gainsboro"></ItemStyle>
                                <ItemTemplate>
                                    &nbsp;&nbsp;<asp:CheckBox runat="server" ID="chkStyleColor"></asp:CheckBox>&nbsp;
                                    <asp:Label runat="server" ID="lblStyleColor" Text='<%# string.Concat( DataBinder.Eval(Container.DataItem, "MainColor").ToString ) %>'
                                        CssClass="font"></asp:Label>
                                    <asp:HiddenField runat="server" ID="hdnStyleSourcingBOLColorID" />
                                </ItemTemplate>
                            </asp:DataList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table cellpadding="0" cellspacing="0" border="0" bgcolor="White">
        <tr>
            <td>
                <cc2:YSTabView ID="YSTabView1" runat="server"></cc2:YSTabView>
            </td>
        </tr>
    </table>
    <table cellspacing="0" cellpadding="0" border="0" bgcolor="white">
        <tr>
            <td>
                <table class="TableHeader" cellspacing="0" cellpadding="0" border="0" bgcolor="white" width="100%">
                    <tr>
                        <td valign="middle" align="right">
                            <asp:Label ID="lblSelException" runat="server"></asp:Label>
                            &nbsp;&nbsp;
                            <asp:DropDownList ID="selBOLType" runat="server" DataValueField="BOLExceptionId"
                                DataTextField="BOLExceptionName" AutoPostBack="false">
                            </asp:DropDownList>
                        </td>
                        <td width="50" align="left">
                            <cc1:ConfirmedImageButton Message="NONE" ID="btnSelException" runat="server" />
                        </td>
                        <td align="right">
                            <asp:DropDownList ID="selVendors" runat="server"></asp:DropDownList>
                        </td>
                        <td>
                            <cc1:ConfirmedImageButton Message="NONE" ID="btnBatchOperations" runat="server" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table cellSpacing="1" cellPadding="1" width="100%" bgColor="#ffffff" border="0">
		            <tr height="10"></tr>
		            <tr>
			            <td>
				            <asp:placeholder id="plhControlsHolderBOLVar" runat="server"></asp:placeholder>
				        </td>
			        </tr>
		        </table>
		    </td>
		</tr>
        <tr>
            <td>
                <asp:DataGrid ID="DataGrid2" runat="server" AllowSorting="False" DataKeyField="PageOperationId">
                    <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
                    <Columns>
                        <asp:TemplateColumn ItemStyle-BorderWidth="1">
                            <HeaderTemplate>
                                <input type="checkbox" id="checkAll" onclick="CheckAll(this);" runat="server" name="checkAll" />
                            </HeaderTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn ItemStyle-BorderWidth="1">
                            <ItemStyle Width="75" />
                            <ItemTemplate>
                                <table cellspacing="0" cellpadding="0" width="75" border="0">
                                    <tr>
                                        <td>
                                            <table cellspacing="0" cellpadding="0" width="25" border="0">
                                                <tr>
                                                    <td>
                                                        <asp:Image ID="ImgLinked" runat="server" ImageUrl="../System/Icons/icon_link.gif"
                                                            Visible='<%# DisplayLinkedVisible(Container.DataItem("isLinked")) %>' ToolTip='<%#GetSystemText("Construction Linked") & "..." %>'>
                                                        </asp:Image>
                                                    </td>
                                                </tr>
                                            </table>
                                            <table cellspacing="0" cellpadding="0" width="25" border="0">
                                                <tr>
                                                    <td style="height: 50px; vertical-align: top">
                                                        <div style="position: absolute;">
                                                            <cc1:BWImageButton ID="imgConstructionDetail" runat="server"></cc1:BWImageButton>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn ItemStyle-BorderWidth="1">
                            <HeaderStyle Width="30px" CssClass="TableHeader"></HeaderStyle>
                            <HeaderTemplate>
                                <asp:Label runat="server" ID="lblMacro" Text='<%#GetSystemText("Macro") %>' />
                            </HeaderTemplate>
                            <ItemStyle Width="30px" HorizontalAlign="Center"></ItemStyle>
                            <ItemTemplate>
                                <asp:Image runat="server" ID="imgIsMacro" ImageUrl="../System/Icons/tv_plusdotsbt.gif" />
                                <asp:HiddenField runat="server" ID="hdnMacroParentId" Value="" />
                                <asp:HiddenField runat="server" ID="hdnMacroId" Value="" />
                            </ItemTemplate>
                        </asp:TemplateColumn>
                        <%--<asp:TemplateColumn>
                            <ItemTemplate>
                                <asp:DropDownList runat="server" ID="ddlVendors1"></asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateColumn>--%>
                    </Columns>
                </asp:DataGrid>
            </td>
        </tr>
    </table>
    <br />
    <table cellspacing="2" cellpadding="0" border="0" id="tblTotal" runat="server">
        <tr>
            <td width="400">
            </td>
            <td width="300" align="left" style="background-color: #AABBCC">
                <asp:DataGrid ID="dgTotal" Width="100%" runat="server" ShowHeader="true" AllowSorting="False"
                    CellPadding="4" DataKeyField="BaseRateId" BorderStyle="Solid" BorderWidth="1"
                    BorderColor="Black" AutoGenerateColumns="false" HeaderStyle-Height="0">
                    <Columns>
                        <asp:BoundColumn DataField="BaseRateCode" ItemStyle-BorderStyle="Solid" ItemStyle-HorizontalAlign="Left"
                            ItemStyle-Width="100"></asp:BoundColumn>
                        <asp:BoundColumn DataField="TotalTime" HeaderText="Time" HeaderStyle-Font-Bold="true" 
                            HeaderStyle-BorderStyle="Solid" HeaderStyle-HorizontalAlign="Center" ItemStyle-BorderStyle="Solid" 
                            ItemStyle-HorizontalAlign="Center" ItemStyle-Width="75">
                        </asp:BoundColumn>
                        <asp:BoundColumn DataField="sConvCost" HeaderText="Conv. Cost" HeaderStyle-Font-Bold="true" 
                            HeaderStyle-BorderStyle="Solid" HeaderStyle-HorizontalAlign="Center" ItemStyle-BorderStyle="Solid" 
                            ItemStyle-HorizontalAlign="Center" ItemStyle-Width="75">
                        </asp:BoundColumn>
                        <asp:BoundColumn DataField="ConvCurr" HeaderText="Conv. Curr." HeaderStyle-Font-Bold="true" 
                            HeaderStyle-BorderStyle="Solid" HeaderStyle-HorizontalAlign="Center" ItemStyle-BorderStyle="Solid" ItemStyle-HorizontalAlign="Center"
                            ItemStyle-Width="50">
                        </asp:BoundColumn>
                    </Columns>
                </asp:DataGrid>
            </td>
        </tr>
    </table>
    </form>

    <script type="text/javascript" language="javascript">
        function getElementsByNameIE(tag, name) {

            var elem = document.getElementsByTagName(tag);
            var arr = new Array();
            for (i = 0, iarr = 0; i < elem.length; i++) {
                att = elem[i].getAttribute("name");
                if (att == name) {
                    arr[iarr] = elem[i];
                    iarr++;
                }
            }
            return arr;
        }

        function hideUnhide(MacroParentId, id) {
            var h = getElementsByNameIE("tr", "hide_" + MacroParentId)
            for (var i = 0; i < h.length; i++) {
                if (h[i].style.display == 'none') {
                    h[i].style.display = ''
                    document.getElementById(id).src = '../System/Icons/tv_minusdotst.gif'
                }
                else {
                    if (h[i].style.display == '') h[i].style.display = 'none'
                    document.getElementById(id).src = '../System/Icons/tv_plusdotsbt.gif'
                }
            }
        }

        function changeVendors(MacroParentId, index) {
            var h = getElementsByNameIE("tr", "hide_" + MacroParentId);

            for (var i = 0; i < h.length; i++) {
                h[i].getElementsByTagName("select")[0].selectedIndex = index;
            }
        }

        function changeChecked(MacroParentId, checked) {
            var h = getElementsByNameIE("tr", "hide_" + MacroParentId),
                inputs, checkbox;

            for (var i = 0; i < h.length; i++) {
                inputs = h[i].getElementsByTagName("input");

                for (var j = 0, jmax = inputs.length; j < jmax; j++) {
                    checkbox = inputs[j];

                    if (checkbox.type == "checkbox" && checkbox.name.indexOf("chbBatchOp") != -1) {
                        checkbox.checked = checked
                    }
                }
            }
        }

        var frm = document.form1;
        function CheckAll(checkAllBox) {
            var actVar = checkAllBox.checked, e;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chbBatchOp") != -1)
                    if (e.disabled == false)
                    e.checked = actVar;
            }
        }

        function CheckAllColor(checkAllBox) {
            var actVar = checkAllBox.checked;
            for (i = 0; i < frm.length; i++) {
                e = frm.elements[i];
                if (e.type == 'checkbox' && e.name.indexOf("chkStyleColor") != -1)
                    if (e.disabled == false)
                    e.checked = actVar;
            }
        }
		
        function btnClose_Click() {
            <%= strExitScript %>
            return false;
        }
    </script>

</body>
</html>
