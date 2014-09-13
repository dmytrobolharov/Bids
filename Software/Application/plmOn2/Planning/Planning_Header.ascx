<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Planning_Header.ascx.vb" Inherits="plmOnApp.Planning_Header" %>

<table height="25" cellspacing="0" cellpadding="0" width="100%" border="0">
    <tr class="TableHeader">
        <td valign="middle" align="center" width="10">
            <img height="15" src="../System/Images/bbTbSCnr.gif" width="3" alt="" />
        </td>
        <td width="20">
            <img id="imgBtnExp" onclick="return ShowPlanningHeaderContent(this)" style="cursor: pointer;" src="../System/Icons/icon_Next.gif" alt="" />
            <img id="imgBtnCol" onclick="return HidePlanningHeaderContent(this)" style="cursor: pointer; display: none;"
                src="../System/Icons/icon_Down.gif" alt="" />
        </td>
        <td class="fontHead">
            <asp:Label ID="lblHeaderDetail" runat="server"><%= PlanningName %></asp:Label>
        </td>
    </tr>
</table>
<div id="divHeaderContent" style="display: none;">
    <table cellspacing="0" cellpadding="0" width="100%" border="0">
        <tr bgcolor="White">
            <td>
                <asp:PlaceHolder ID="plhHeader" runat="server" EnableViewState="False"></asp:PlaceHolder>
            </td>
        </tr>
    </table>
</div>

<script type="text/javascript" language="javascript">
    function ShowPlanningHeaderContent(obj) {
        obj.style.display = 'none';
        document.getElementById('imgBtnCol').style.display = 'block';
        document.getElementById('divHeaderContent').style.display = 'block';
        return false;
    }

    function HidePlanningHeaderContent(obj) {
        obj.style.display = 'none';
        document.getElementById('imgBtnExp').style.display = 'block';
        document.getElementById('divHeaderContent').style.display = 'none';
        return false;
    }
</script>
