<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="CalendarEvent.aspx.vb" Inherits="plmOnApp.CalendarEvent" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
<LINK href="../CSS/Style.css" type="text/css" rel="stylesheet">
    <title>Event</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
       <table bgcolor="#ffffff">
            <tr>
                <td width="10">
                </td>
                <td class="fontHead" width="125" height="20">
                </td>
                <td width="250">
                </td>
            </tr>
            <tr>
                <td width="10">
                </td>
                <td class="fontHead" width="125" height="20">
                    <asp:label id="lblEventName" runat="server">Event Name:</asp:label></td>
                <td width="250">
        <asp:Label ID="lblCalendarEventName" runat="server" CssClass="font"></asp:Label></td>
            </tr>
            <tr>
                <td width="10">
                </td>
                <td class="fontHead" width="125" height="20">
                    <asp:label id="lblEventDate" runat="server">Event Date:</asp:label></td>
                <td width="250">
                    <asp:Label ID="lblCalendarEventDate" runat="server" CssClass="font"></asp:Label></td>
            </tr>
            <tr>
                <td width="10">
                </td>
                <td class="fontHead" width="125" height="20">
                    <asp:label id="lblEventType" runat="server">Event Type:</asp:label></td>
                <td width="250">
                    <asp:Label ID="lblCalendarEventType" runat="server" CssClass="font"></asp:Label></td>
            </tr>
           <tr>
               <td width="10">
               </td>
               <td class="fontHead" width="125" height="20">
                   <asp:label id="lblEventCountry" runat="server">Event Country:</asp:label></td>
               <td width="250">
                   <asp:Label ID="lblCalendarEventCountry" runat="server" CssClass="font"></asp:Label></td>
           </tr>
           <tr>
               <td width="10">
               </td>
               <td class="fontHead" height="20" width="125">
               </td>
               <td width="250">
               </td>
           </tr>
        </table>
    </div>
    </form>
</body>
</html>
