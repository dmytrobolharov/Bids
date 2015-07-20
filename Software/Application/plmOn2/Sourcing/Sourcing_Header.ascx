<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Sourcing_Header.ascx.vb" Inherits="plmOnApp.Sourcing_Header" %>
<link href="../System/CSS/Style.css" rel="stylesheet" type="text/css">
 
<%-- <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr bgcolor="White">
            <td>
                <asp:PlaceHolder ID="plhSourcingHeader" runat="server" EnableViewState="False"></asp:PlaceHolder>
            </td>
        </tr>
    </table>--%>
<table height="25" cellSpacing="0" cellPadding="0" width="100%" border="0" id="headerExp">
    <tr class="TableHeader">
        <td vAlign="middle" align="center" width="10"><img height="15" src="../System/Images/bbTbSCnr.gif" width="3"></td>
        <td width="20">
            <img id="imgBtnExp" onclick="return ShowHeaderContent(this)" style="cursor:pointer"  src="../System/Icons/icon_Next.gif" />
            <img id="imgBtnCol" onclick="return HideHeaderContent(this)" style="cursor:pointer" src="../System/Icons/icon_Down.gif" />
        </td>
        <td class="fontHead">
            <asp:label id="lblHeaderDetail" runat="server"></asp:label>
        </td>
    </tr>
</table>
<div id="divHeaderContent" style="display:none">
    <asp:PlaceHolder ID="plhSourcingHeader" runat="server" EnableViewState="False"></asp:PlaceHolder>
</div>

<script type='text/javascript' language='javascript'>
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
    }
    catch (e) { }
</script>
    