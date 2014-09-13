<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Style_New_CopyMultiSelection_Final.aspx.vb" Inherits="plmOnApp.Style_New_CopyMultiSelection_Final" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title></title>
	<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
	<link href="../System/CSS/Tree.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="../System/Jscript/YSCalendarFunctions.js"></script>    
    <script type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
    <style type="text/css">
        .multi-bubble .wf-label {
        	padding-top: 5px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <table class="TableHeader" id="toolbar" cellSpacing="0" cellpadding="0" width="100%" border="0"
		    runat="server">
		    <tr valign="middle">
			    <td valign="middle" align="center" width="10"><IMG height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
			    <td><cc1:confirmedimagebutton id="btnSaveSet" runat="server"  Message="NONE"></cc1:confirmedimagebutton><cc1:confirmedimagebutton id="btnClose" runat="server"  Message="NONE"
					    CausesValidation="False"></cc1:confirmedimagebutton></td>
		    </tr>
	    </table>
	    
        <table borderColor="gold" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffff99" border="1">
	    <tr>
		    <td><table cellSpacing="0" cellpadding="0" width="100%" border="0">
				<tr>
				    <td width="10">&nbsp;</td>
				    <td width="200"><asp:radiobuttonlist id="rblImage" runat="server" RepeatDirection="Horizontal" CssClass="fontHead">
					    </asp:radiobuttonlist></td>
				    <td>&nbsp;</td>
			    </tr>
		        </table>
		   </td>
	    </tr>
    	</table>	    

		<table cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr>
				<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">Copy Style...</asp:label></td>
			</tr>
		</table>
		<table height="100" cellSpacing="0" cellpadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr valign="top">
				<td width="10">&nbsp;</td>
				<td width="900"><asp:placeholder id="plhControlsHolder" runat="server"></asp:placeholder></td>
				<td><cc1:bwimagebutton id="imgDesign" runat="server"></cc1:bwimagebutton></td>
			</tr>
		</table>
		
          <br /><br />
        <asp:Panel ID="pnlSeasonYear"  runat="server"  >
            <table class="TableHeaderYellow" cellspacing="0" cellpadding="0" width="100%" height="30"
                border="0">
                <tr valign="middle">
                    <td valign="middle" align="center" width="10">
                        <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
                    </td>
                    <td width="20"><img src="../System/Icons/icon_season.gif" /></td>
                    <td width="125" align="right" nowrap="nowrap">
                        <asp:Label runat="server" ID="Label1" class="fontHead" >Select Season / Year:</asp:Label>
                    </td>
                    <td>
                        <asp:DropDownList  ID="ddlStyleSeasonYearID" runat="server" AutoPostBack="true" ></asp:DropDownList>
                    </td>
                </tr>
            </table>
        </asp:Panel> 
        

        <asp:DataList runat="server" ID="dlVariation" RepeatDirection="Horizontal" DataKeyField="StyleID">
        <ItemStyle  VerticalAlign="Top" />
        <ItemTemplate>
            <table class="TableHeaderGreen" cellspacing="0" cellpadding="0" width="100%" border="0" >
            <tr valign="middle" height="25">
                <td>
                    &nbsp;
                    <input type="checkbox" id="checkAll" onclick="CheckAll(this, 'chkSelect');" runat="server" name="checkAll" />
                </td>
                <td align="center" >
                    <asp:Label id="lblVariation" runat="server"></asp:Label>
                    <asp:HiddenField ID="hdnStyleID" runat="server" Value='<%# Eval("StyleID") %>' />
                </td>
                <td>&nbsp;</td>
             </tr>
            <%--<tr>
                <td colspan="3" bgcolor="Beige">             
                    <asp:DataList runat="server" ID="dlColorway" RepeatDirection="Horizontal"  
                         OnItemDataBound="dlColorway_ItemDataBound" RepeatColumns="1" DatakeyField="StyleColorwaySeasonYearID">
                        <ItemTemplate>
                            <table border="0">
                            <tr><td width="20"><asp:CheckBox runat="server" ID="chkSelect" /></td>
                                <td><asp:Image runat="server" ID="imgColor" /></td>
                                <td><asp:label runat="server" ID="lblColor" /></td></tr></table>
                        </ItemTemplate>
                    </asp:DataList>                                
                </td>
             </tr>--%>
                <tr>
                    <td colspan="3">
                        <asp:DataList runat="server" ID="dlWorkflow" RepeatDirection="Vertical" OnItemDataBound="dlWorkflow_ItemDataBound"
                            DataKeyField="Map">
                            <ItemTemplate>
                                <table border="0" width="200">
                                    <tr>
                                        <td width="20" valign="top">
                                            <asp:CheckBox runat="server" ID="chkSelect" />&nbsp;
                                        </td>
                                        <td width="180" class="wf-label">
                                            <asp:Label runat="server" ID="lblWorkflowName" AssociatedControlID="chkSelect"></asp:Label>
                                            <asp:DataList runat="server" ID="dlWorkflowItem" RepeatDirection="Vertical" OnItemDataBound="dlWorkflowItem_ItemDataBound" DataKeyField="WorkflowItemID">
                                                <ItemTemplate>
                                                    <table width="180" border="0">
                                                        <tr>
                                                            <td valign="top">
                                                                <asp:CheckBox runat="server" ID="chkSelectItem" />
                                                                <input type="hidden" runat="server" id="hdnWorkflowID" />
                                                                <asp:Label runat="server" ID="lblWorkflowItemName" AssociatedControlID="chkSelectItem"></asp:Label>
                                                                </td><td>
                                                                <asp:DataList ID="dlBOMColorways" runat="server" DataKeyField="StyleColorID" RepeatDirection="Vertical">
                                                                    <ItemTemplate>
                                                                        <table>
                                                                            <tr>
                                                                                <td style='width: 30px; height: 30px; text-align: left; vertical-align: top; background-image: url(<%# GetColorStreamPath("30", Eval("ColorFolderID").ToString(), Eval("ColorPaletteID").ToString()) %>)'>
                                                                                    <label style="width: 30px; height: 30px; position: absolute;">
                                                                                    <asp:CheckBox runat="server" ID="chbBOMColorwaySelected" Checked="true" />
                                                                                    </label>
                                                                                </td>
                                                                                <td>
                                                                                    <asp:Label ID="lblColorwayCode" runat="server" CssClass="font"><%# Eval("ColorCode") %></asp:Label>
                                                                                    <asp:HiddenField ID="hdnColorCode" runat="server" Value='<%# Eval("ColorCode") %>' />
                                                                                    <br />
                                                                                    <asp:Label ID="lblColorwayName" runat="server" CssClass="font"><%# Eval("ColorName") %></asp:Label>
                                                                                    <asp:HiddenField ID="hdnColorName" runat="server" Value='<%# Eval("ColorName") %>' />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </ItemTemplate>
                                                                </asp:DataList>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                        </td>
                                    </tr>
                                </table>
                            </ItemTemplate>
                        </asp:DataList>
                    </td>
                </tr>
            </table>
        </ItemTemplate>
        </asp:DataList>
    </form>
    <script type="text/javascript">
        var frm = document.forms['form1'];
        function CheckAll(checkAllBox, name) {
            var actVar = checkAllBox.checked;
            for (var i = 0; i < frm.length; i++) {
                var e = frm.elements[i];
                if (e.type == 'checkbox' && e.id.indexOf(checkAllBox.id.replace("checkAll", "")) != -1  && e.name.indexOf(name) != -1) {
                    e.checked = actVar;
                    $(document).ready(function () {
                        $(document).find("input[id*='chkSelectItem']").each(function () {
                            ShowBOMColorways($(this)[0]);
                        });
                    });
                }
            }
        }


        window.onload = function () {
            document.getElementById('drlSizeRange').disabled = true;
            document.getElementById('drlSizeClass').disabled = true;
            document.getElementById('drlCustomField3').value = "In Progress"
            document.getElementById('drlCustomField3').disabled = true;
        }

        function ShowBOMColorways(sender) {
            if (sender.checked) {
                $(sender).closest("tr").find("table[id*='dlBOMColorways']").show();
            } else {
                $(sender).closest("tr").find("table[id*='dlBOMColorways']").hide();
            }
        }

        $(document).ready(function () {
            $(document).find("input[id*='chkSelectItem']").each(function () {
                ShowBOMColorways($(this)[0]);
            });
        });

    </script>
</body></html>
