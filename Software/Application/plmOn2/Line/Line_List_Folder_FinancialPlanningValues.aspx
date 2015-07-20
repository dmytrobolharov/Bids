<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>
<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Line_List_Folder_FinancialPlanningValues.aspx.vb" Inherits="plmOnApp.Line_List_Folder_FinancialPlanningValues" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Line List Planning Values</title>
    <link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../System/Jscript/jquery-1.6.2.min.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/floatButtonBar.js"></script>
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
    <style type="text/css">
        #DataGrid1 {
        	margin-top: 10px;
        	margin-left: 10px;
        	border: none;
        }
        
        #DataGrid1 td {
        	border: 1px solid #bbb;
        }
        
        #DataGrid1 input {
            color: #0000ff;
            background-color: #FFFACD;
        }
        	
        #DataGrid1 input, .numeric {
        	text-align: right;        	
        }        
        
        #DataGrid1 .names {
        	padding: 2px;   
        	vertical-align: top;     	
        }
        
        #DataGrid1 .names img {        
        	display: inline-block;
        }
        
        #DataGrid1 .style-category .names {
        	padding-left: 30px;
        }
        
        .TableHeader .font, .TableHeader .fontRed {
        	font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    
    <table class="TableHeader" id="toolbar" cellspacing="0" cellpadding="0" width="100%" border="0" runat="server">
        <tr valign="middle">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td>
                <cc1:ConfirmedImageButton ID="btnSave" runat="server" Message="NONE"></cc1:ConfirmedImageButton>
                <cc1:BWImageButton ID="btnChangeLog" runat="server" CausesValidation="false" Visible="false" OnClientClick="javascript:Page_ValidationActive = false;">
                </cc1:BWImageButton>
                <cc1:ConfirmedImageButton ID="btnClose" runat="server" Message="NONE" OnClientClick="window.opener.location.href = window.opener.location.href; window.close(); return false;">
                </cc1:ConfirmedImageButton>                
            </td>
        </tr>
    </table>
    <table style="border-bottom: orange thin solid; border-left-style: none; background-color: white" height="45"
        cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
        <tr>
            <td>
                &nbsp;<asp:Label ID="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana"><%= GetSystemText("Line List Planning Values")%></asp:Label>
            </td>
        </tr>
    </table>
    <table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr class="TableHeader">
            <td valign="middle" align="center" width="10">
                <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
            </td>
            <td width="20">
                <img id="imgBtnExp" onclick="return ShowHeaderContent(this)" style="cursor: pointer" src="../System/Icons/icon_Next.gif" alt="" />
                <img id="imgBtnCol" onclick="return HideHeaderContent(this)" style="cursor: pointer" src="../System/Icons/icon_Down.gif" alt="" />
            </td>
            <td class="fontHead">
                <asp:Label ID="lblHeaderDetail" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <div id="divHeaderContent" style="display: none">
        <table cellspacing="0" cellpadding="0" width="100%" bgcolor="#ffffff" border="0">
            <tr>
                <td width="900">
                    <asp:PlaceHolder ID="plhHeaderControlsHolder" runat="server"></asp:PlaceHolder>
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
    </div>
    
    <asp:DataGrid ID="DataGrid1" runat="server" AllowSorting="True" DataKeyField="LineFolderStyleCategoryID" AutoGenerateColumns="false">
        <AlternatingItemStyle Height="20px" CssClass="AlternateItemTemplate"></AlternatingItemStyle>
        <ItemStyle Height="20px" CssClass="ItemTemplate"></ItemStyle>
        <HeaderStyle Height="25px" CssClass="TableHeader"></HeaderStyle>
        <PagerStyle Visible="False"></PagerStyle>        
        <Columns>
            <asp:TemplateColumn>
                <ItemStyle CssClass="names" />
                <ItemTemplate>
                    <img runat="server" id="imgToggler" onclick='<%# String.Format("toggleRows(this, &#39;{0}&#39;)", Eval("LineFolderStyleTypeID").ToString)%>'
                        style="cursor: pointer" src="../System/Icons/icon_Down.gif" alt="" />
                    <asp:Label runat="server" ID="lblName" Text='<%# Eval("Name") %>'></asp:Label>
                    <asp:HiddenField runat="server" ID="hdnLineFolderDivisionID" Value='<%# Eval("LineFolderDivisionID") %>' />
                    <asp:HiddenField runat="server" ID="hdnLineFolderStyleTypeID" Value='<%# Eval("LineFolderStyleTypeID") %>' />
                    <asp:HiddenField runat="server" ID="hdnLineFolderStyleCategoryID" Value='<%# Eval("LineFolderStyleCategoryID") %>' />
                    <asp:HiddenField runat="server" ID="hdnRowName" Value='<%# Convert.ToString(Eval("LineFolderDivision")) & "/" & Convert.ToString(Eval("LineFolderStyleTypeDescription")) & "/" & Convert.ToString(Eval("LineFolderStyleCategory")) %>'/>
                </ItemTemplate>
            </asp:TemplateColumn>
        </Columns>
    </asp:DataGrid><asp:Label ID="SortOrder" runat="server" Visible="False"></asp:Label>
            
    </form>
    <script type="text/javascript">
        $(function () {
            $(":text").keyup(function () {
                var value = $.trim(this.value),
                    firstChar = value.charAt(0);

                if (value.length > 1 && (firstChar == "." || firstChar == ",")) {
                    this.value = "0" + value;
                }
            });
        });
        
        try {
            document.getElementById('imgBtnCol').style.display = 'none';
            function ShowHeaderContent(obj) {
                obj.style.display = 'none';
                document.getElementById('imgBtnCol').style.display = 'block';
                document.getElementById('divHeaderContent').style.display = 'block';
                return false;
            }

            function HideHeaderContent(obj) {
                obj.style.display = 'none';
                document.getElementById('imgBtnExp').style.display = 'block';
                document.getElementById('divHeaderContent').style.display = 'none';
                return false;
            }
        } catch (e) { }

        $("#DataGrid1 td:first").css({border: 'none', visibility: 'hidden'});

        function toggleRows(img, style_category) {
            if ($(img).closest("tr").nextUntil(".TableHeader").toggle().is(":visible")) {
                img.src = "../System/Icons/icon_Down.gif";
            } else {
                img.src = "../System/Icons/icon_Next.gif";
            }
        }
    </script>
</body>
</html>
