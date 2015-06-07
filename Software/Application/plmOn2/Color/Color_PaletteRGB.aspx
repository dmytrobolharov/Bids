<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Color_PaletteRGB.aspx.vb" Inherits="plmOnApp.Color_PaletteRGB" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <script type="text/javascript" src="../System/Jscript/prototype.js"></script>
    <script type="text/javascript" src="../System/Jscript/colormethods.js"></script>
    <script type="text/javascript" src="../System/Jscript/colorvaluepicker.js"></script>
    <script type="text/javascript" src="../System/Jscript/slider.js"></script>
    <script type="text/javascript" src="../System/Jscript/colorpicker.js"></script>
    <link href="../System/CSS/Style.css" rel="stylesheet" type="text/css" />
    <link href="../System/CSS/Help.css" rel="stylesheet" type="text/css" />
    <title runat="server" id="PageTitle">Set RGB Color</title>
    <link href="../System/CSS/waitControl.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="../system/jscript/waitControl.js"></script>
</head>
<body>
    <div id="fixed_icons"><a href="../Help/Help_Folder.aspx?Folder=<%= Folder %>&HID=<%= HelpID %>" title="Help" target="_blank" id="yHelp"></a></div>
    <form id="form1" runat="server">
    <div>
		<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white"
			height="35" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
			<tr>
			    <td width="20">&nbsp;</td>
			    <td width="20">
                    <img src="../System/Icons/icon_colorwheel.gif" /></td>
				<td>&nbsp;<asp:label id="lblHeader" runat="server" Font-Names="Tahoma,Verdana" 
                        Font-Size="Medium" ForeColor="Gray">Set RGB Value...</asp:label></td>
			</tr>
		</table>    

        <TABLE>
          <TBODY>
          <TR>
            <TD vAlign=top>
              <DIV style="WIDTH: 256px" id=cp1_ColorMap></DIV></TD>
            <TD vAlign=top>
              <DIV id=cp1_ColorBar></DIV></TD>
            <TD vAlign=top>
              <TABLE>
                <TBODY>
                <TR>
                  <TD colSpan=3>
                    <DIV 
                    style="BORDER-BOTTOM: #000 1px solid; BORDER-LEFT: #000 1px solid; PADDING-BOTTOM: 0px; BACKGROUND-COLOR: #fff; MARGIN: 0px; PADDING-LEFT: 0px; WIDTH: 60px; PADDING-RIGHT: 0px; HEIGHT: 60px; BORDER-TOP: #000 1px solid; BORDER-RIGHT: #000 1px solid; PADDING-TOP: 0px" 
                    id=cp1_Preview><BR></DIV></TD></TR>

                <TR>
                  <TD height=5 colSpan=2></TD></TR>
                <TR>
                  
                  <TD><LABEL for=cp1_RedRadio><asp:label id="lblRed" runat="server">R:</asp:label></LABEL> </TD>
                  <TD><input style="WIDTH: 40px" id="cp1_Red" name="cp1_Red" value="255" /> </TD></TR>
                <TR>
                  
                  <TD><LABEL for=cp1_GreenRadio><asp:label id="lblGreen" runat="server">G:</asp:label></LABEL> </TD>
                  <TD><input style="WIDTH: 40px" id="cp1_Green" name="cp1_Green" value="0" /> </TD></TR>
                <TR>
                  
                  <TD><LABEL for=cp1_BlueRadio><asp:label id="lblBlue" runat="server">B:</asp:label></LABEL> </TD>
                  <TD><input style="WIDTH: 40px" id="cp1_Blue" name="cp1_Blue" value="0" /> </TD></TR>
                <TR>
                  <TD>#: </TD>
                  <TD><input style="WIDTH: 60px" id="cp1_Hex" name="cp1_Hex" runat="server" value='<%# Request.Querystring("HEX") %>'>
                </TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
                    <DIV style="DISPLAY: none">
                    <img src="../System/Images/rangearrows.gif" /> 
                    <img src="../System/Images/mappoint.gif"/> 
                    <img src="../System/Images/bar-saturation.png"/> 
                    <img src="../System/Images/bar-brightness.png"/> 
                    <img src="../System/Images/bar-blue-tl.png"/> 
                    <img src="../System/Images/bar-blue-tr.png"/> 
                    <img src="../System/Images/bar-blue-bl.png"/> 
                    <img src="../System/Images/bar-blue-br.png"/> 
                    <img src="../System/Images/bar-red-tl.png"/> 
                    <img src="../System/Images/bar-red-tr.png"/> 
                    <img src="../System/Images/bar-red-bl.png"/> 
                    <img src="../System/Images/bar-red-br.png"/> 
                    <img src="../System/Images/bar-green-tl.png"/> 
                    <img src="../System/Images/bar-green-tr.png"/> 
                    <img src="../System/Images/bar-green-bl.png"/> 
                    <img src="../System/Images/bar-green-br.png"/> 
                    <img src="../System/Images/map-red-max.png"/> 
                    <img src="../System/Images/map-red-min.png"/> 
                    <img src="../System/Images/map-green-max.png"/> 
                    <img src="../System/Images/map-green-min.png"/> 
                    <img src="../System/Images/map-blue-max.png"/> 
                    <img src="../System/Images/map-blue-min.png"/> 
                    <img src="../System/Images/map-saturation.png"/> 
                    <img src="../System/Images/map-saturation-overlay.png"/> 
                    <img src="../System/Images/map-brightness.png"/> 
                    <img src="../System/Images/map-hue.png"/> 
                    </DIV>
                    <script type="text/javascript">
	                    Event.observe(window,'load',function() {
	                    var sHex = '<% = Request.QueryString("HEX") %>';
	                    cp1 = new Refresh.Web.ColorPicker('cp1', { startHex: '' + sHex + '', startMode: 's' });
	                });

                    function btnClose_Click() {
                        <%= strExitScript %>
                        return false;
                    }
	                </script>
	        </div>        
            <div visible="false" style="visibility: hidden">    
	        <table>
	            <TR>
	            <TD><input id=cp1_RedRadio value=r type=radio name=cp1_Mode> </TD>
	            <TD><input id=cp1_GreenRadio value=g type=radio name=cp1_Mode> </TD>
	            <TD><input id=cp1_BlueRadio value=b type=radio name=cp1_Mode> </TD>
	            
                  <TD><input id="cp1_HueRadio" value="0" type="radio" name="cp1_Mode" runat="server"> </TD>
                  <TD><input style="WIDTH: 40px" id=cp1_Hue value=0 runat="server"></TD>
                  <TD><input id=cp1_SaturationRadio value=1 type=radio name=cp1_Mode runat="server"></TD>
                  <TD><input style="WIDTH: 40px" id=cp1_Saturation value=100 runat="server"></TD>
                  <TD><input id=cp1_BrightnessRadio value=2 type=radio name=cp1_Mode runat="server"> </TD>
                  <TD><input style="WIDTH: 40px" id=cp1_Brightness value=100 runat="server"></TD>
                </TR>        
	        </table>   
           </div>
	    <table bgcolor="gainsboro" border="0" cellpadding="0" cellspacing="0" 
            height="40" 
            style="BORDER-TOP: gray thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: gainsboro" 
            width="100%">
            <tr>
                <td align="center" width="50">
                    &nbsp;</td>
                <td align="center" width="300">
                    <asp:ImageButton ID="btnSave" runat="server"/>
                    <asp:ImageButton ID="btnClose" runat="server" OnClientClick="return btnClose_Click();"/>
                </td>
                <td align="center">
                    &nbsp;</td>
            </tr>
        </table>      
    </form>
</body>
</html>
