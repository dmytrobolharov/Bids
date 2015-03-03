<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Body_PatternSheet_Edit.aspx.vb"
    Inherits="plmOnApp.Body_PatternSheet_Edit" %>

<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Register TagPrefix="cc2" Namespace="Yunique.WebControls.YSTab" Assembly="YSTab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Model_Edit</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/Grid.css" type="text/css" rel="stylesheet" />
	<script language="javascript" type="text/javascript" src="../system/jscript/jquery-1.8.3.min.js"></script>
	<script language="javascript" type="text/javascript" src="../system/jscript/FillDRL.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white"
        height="45" cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" Font-Names="Tahoma,Verdana" Font-Size="Small" Font-Bold="True">Body PatterSheet Edit</asp:Label>
            </td>
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
            <td>
                <cc2:YSTabView ID="YSTabView1" runat="server"></cc2:YSTabView>
            </td>
        </tr>
        <tr>
            <td>
                <%-- <asp:PlaceHolder  runat ="server"  ID="plhControlsHolderEdit" ></asp:PlaceHolder>--%>
                <asp:PlaceHolder runat="server" ID="plhControlsHolder"></asp:PlaceHolder>
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
					                    <input type="checkbox" id="checkAll" onClick="CheckAll(this);" runat="server" name="checkAll">
				                    </HeaderTemplate>
				                    <ItemTemplate>
					                    <asp:CheckBox ID="chkSelected" runat="server"></asp:CheckBox>
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
                                    <asp:LinkButton ID="btndownload" runat="Server"  CommandName="download">
                                    </asp:LinkButton>
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
    <SCRIPT language="javascript">
		    var frm = document.form1;
		    function CheckAll(checkAllBox) {
		        var actVar = checkAllBox.checked;
		        for (i = 0; i < frm.length; i++) {
		            e = frm.elements[i];
		            if (e.type == 'checkbox' && e.name.indexOf("chkSelected") != -1)
		                e.checked = actVar;
		        }
		    }

		    function disableEnterKey() {
		        if (window.event.keyCode == 13) window.event.keyCode = 0;
		    }
		</SCRIPT>
        <script language="javascript">
	        function btnClose_Click() {
		        <%= strExitScript %>
                return false;
            }
        </script>
</body>
</html>
