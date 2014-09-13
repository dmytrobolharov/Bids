<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Control_WSClient_APIDoc.aspx.vb" Inherits="YuniFace.Control_WSClient_APIDoc" %>
<%@ Register TagPrefix="cc1" Namespace="Yunique.WebControls" Assembly="YSWebControls" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<html>
	<head>
		<title runat="server" id="PageTitle">API Documentation</title>
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR" />
		<meta content="Visual Basic .NET 7.1" name="CODE_LANGUAGE" />
		<meta content="JavaScript" name="vs_defaultClientScript" />
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema" />
		<link href="../System/CSS/Style.css" type="text/css" rel="stylesheet" />

        <style type="text/css">
         p.MsoNormal
            {margin-bottom:.0001pt;
            font-size:12.0pt;
            font-family:"Cambria","serif";
            margin-left: 0in;
            margin-right: 0in;
            margin-top: 0in;
            }
         p.MsoListParagraphCxSpFirst
            {margin-top:0in;
            margin-right:0in;
            margin-bottom:0in;
            margin-left:.5in;
            margin-bottom:.0001pt;
            font-size:12.0pt;
            font-family:"Cambria","serif";
            }
         p.MsoListParagraphCxSpMiddle
            {margin-top:0in;
            margin-right:0in;
            margin-bottom:0in;
            margin-left:.5in;
            margin-bottom:.0001pt;
            font-size:12.0pt;
            font-family:"Cambria","serif";
            }
         p.MsoListParagraphCxSpLast
            {margin-top:0in;
            margin-right:0in;
            margin-bottom:0in;
            margin-left:.5in;
            margin-bottom:.0001pt;
            font-size:12.0pt;
            font-family:"Cambria","serif";
            }
         p.MsoListParagraph
            {margin-top:0in;
            margin-right:0in;
            margin-bottom:0in;
            margin-left:.5in;
            margin-bottom:.0001pt;
            font-size:12.0pt;
            font-family:"Cambria","serif";
            }
            .style1
            {
                color: #FF0000;
            }
            .style2
            {
                color: #0000FF;
            }
            .style3
            {
                color: #FF9900;
            }
            .style4
            {
                color: #009933;
            }
            .style5
            {
                color: #006600;
            }
        </style>
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table class="TableHeader" id="toolbar" cellSpacing="0" cellPadding="0" width="100%" border="0" runat="server">
				<tr valign="middle">
					<td valign="middle" align="center" height="30px" width="10">
					    <img height="15" src="../System/Images/bbTbSCnr.gif" width="3">
					    <asp:imagebutton id="btnInvSearch" tabIndex="0" runat="server" Height="0px" Width="0px" ImageUrl="../System/icons/1x1.gif"></asp:imagebutton>
					</td>
				</tr>
			</table>

			<table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" height="45" cellSpacing="0" cellPadding="0" width="100%" bgColor="#ffffff" border="0">
				<tr>
					<td>&nbsp;<asp:label id="lblHeader" runat="server" ForeColor="#E0E0E0" Font-Size="X-Large" Font-Names="Tahoma,Verdana">API Documentation</asp:label></td>
				</tr>
			</table>

            <table style="BORDER-BOTTOM: orange thin solid; BORDER-LEFT-STYLE: none; BACKGROUND-COLOR: white" cellSpacing="2" cellPadding="0" width="100%" border="0">
				<tr>
					<td class="MsoNormal">
                        <br />
                        <b style="mso-bidi-font-weight:normal"><u><span style="mso-ansi-language:EN-US">API Services:</span></u></b>
                        <br />
                        <span style="mso-ansi-language:EN-US">You may interact with the YuniqueAPI using 
        either SOAP or REST.<span style="mso-spacerun:yes">&nbsp; </span>Both provide 
        the same features and functionality.<span style="mso-spacerun:yes">&nbsp; </span>
        The decision to use one versus the other is left to the consumers.</span>
                        <br />
                        <br />
        <span style="mso-ansi-language:EN-US">Both services provide a secure method of 
        access to Yunique Data.<span style="mso-spacerun:yes">&nbsp; </span>Service 
        consumers are authenticated and only allowed to obtain data they are in fact 
        authorized to obtain.</span>
                        <br />
                        <br />
        <span style="mso-ansi-language:EN-US">Our Authentication method is one of HMAC 
        signatures within the HTTP headers of the request.<span 
            style="mso-spacerun:yes">&nbsp; </span>
        </span>
                        <br />
                        <br />
                        <br />

        <b style="mso-bidi-font-weight:normal"><u><span style="mso-ansi-language:EN-US">
        Operations:</span></u></b>
                        <br />
        The following operations are supported. For a formal definition, please review the Service <asp:HyperLink ID="HyperLink3" runat="server" NavigateUrl="/Yunique.API.Rest/metadata?xsd=1">XSD</asp:HyperLink>.
                        <br />
	<div style="border:solid 1px #cccccc;height:800px;width:100%;">
        <table align="left" bordercolor="#0066FF" border="0">
            <col width="250px" />                
            <col width="50px" />                
            <col width="50px" />                
            <col width="50px" />                
            <col width="50px" />                
            <col width="50px" />                
            <tbody>
                <asp:Literal ID="OpTable" runat="server"></asp:Literal>
            </tbody>
            </table>
	</div>
                        <br />
                        <br />

                        <b style="mso-bidi-font-weight:normal"><u><span style="mso-ansi-language:EN-US">
        HTTP Headers:</span></u></b>
                        <br />
        <span style="mso-ansi-language:EN-US">The following HTTP headers are required 
        for HMAC authentication, for both RESTful and SOAP service calls:</span>

                        <ul>
                            <li><span class="style1">WSClientID</span>: The Web Service Client ID (GUID) This is established and setup using Yunique Toolkit</li>
                            <li><span class="style1">PLMUserName</span>: The plmOn UserName</li>
                            <li><span class="style1">TS</span>: A timestamp</li>
                            <li><span class="style1">Signature</span>: An HMAC SHA 256 signature</li>
                            <li><span class="style1">KeyID</span>: WSClientID</li>
                        </ul>
                        <br />

                        <b style="mso-bidi-font-weight:normal"><u><span style="mso-ansi-language:EN-US">
        Time Stamp Format:</span></u></b>
                        <br />
        <span style="mso-ansi-language:EN-US">The actual format is of no consequence as 
        long as it meets the following:</span>

                        <ol>
                            <li>Is in fact a valid date time stamp</li>
                            <li>Includes date</li>
                            <li>Includes time in UTC</li>
                        </ol>

        <span style="mso-ansi-language:EN-US">This very time stamp is sent in the 
        headers.<span style="mso-spacerun:yes">&nbsp; </span>It will also be included in 
        that which you sign.<span style="mso-spacerun:yes">&nbsp; </span>This time stamp 
        is converted back into a DateTime object, and compared with the current UTC 
        time.<span style="mso-spacerun:yes">&nbsp; </span>As long as the message is not 
        older than 2 minutes, no issues should be raised.</span>
                        <br />
                        <br />
                        <br />

        <b style="mso-bidi-font-weight:normal"><u><span style="mso-ansi-language:EN-US">
        HMAC Signatures:</span></u></b>
                        <br />
        <span style="mso-ansi-language:EN-US">We utilize HMAC sha256 signatures for 
        validating the authenticity of the requests.<span style="mso-spacerun:yes">&nbsp;
        </span>The signature is created by fashioning a “string to sign”, and then 
        signing it with a “shared secret” using the HMAC sha256 algorithm.<span 
            style="mso-spacerun:yes">&nbsp; </span>By doing this, and then sending a 
        “public key”, and the signature….<span style="mso-spacerun:yes">&nbsp; </span>
        The signature can be validated on the server side using the shared secret.<span 
            style="mso-spacerun:yes">&nbsp; </span>This allows us to avoid sending any 
        shared secrets over the wire.</span>
                        <br />
                        <br />
        <span style="mso-ansi-language:EN-US">In the context of our API, the above 
        mentioned HTTP headers are what provide this mechanism.<span 
            style="mso-spacerun:yes">&nbsp;&nbsp; </span>The WSClientID is the “public 
        key”,<span style="mso-spacerun:yes">&nbsp; </span>the TS is the timestamp (which 
        is also included in the signed string), and an agreed upon string to sign.<span 
            style="mso-spacerun:yes">&nbsp; </span>For RESTful calls, the agreed upon 
        string is of the format:</span>
                        <br />
                        <br />
        <span style="mso-ansi-language:EN-US"><span style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;</span></span>
        <span style="font-size:10.0pt;mso-bidi-font-size:9.5pt;font-family:Consolas; color:#943634;mso-themecolor:accent2;mso-themeshade:191;mso-ansi-language:EN-US">
        &quot;Yunique.API;&quot; &amp; FULL_REST_URL &amp; &quot;;&quot; &amp; isoTimeStamp</span>
                        <br />
                        <br />
        <span style="mso-bidi-font-family:Consolas;mso-ansi-language:EN-US">An example of the “string to sign”:</span>
                        <br />
                        <br />
        <span style="mso-ansi-language:EN-US"><span style="mso-spacerun:yes">&nbsp;&nbsp;&nbsp;</span></span>
        <span style="font-size:10.0pt;mso-bidi-font-size:9.5pt;font-family:Consolas; color:#943634;mso-themecolor:accent2;mso-themeshade:191;mso-ansi-language:EN-US">
        &quot;Yunique.API;/ColorType/List;2012-12-22T14:01:54.9571247Z&quot;
        </span>
                        <br />
                        <br />
                        <br />

        <b style="mso-bidi-font-weight:normal"><u><span style="mso-ansi-language:EN-US">
        RESTful Request and Response Example:</span></u></b>
                        <br />
        <span style="mso-ansi-language:EN-US">The following is a request/response pair 
        from a valid RESTful call.</span>
                        <br />
                        <br />
        <b><span lang="RU" style="color:black">Request:</span></b>
                        <br />
        <span style="font-size:8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;; mso-ansi-language:EN-US">GET http://localhost:24297/colortype/list HTTP/1.1</span>
                        <br />
        <span style="font-size:8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;; mso-ansi-language:EN-US">Host: localhost</span>
                        <br />
        <span style="font-size:8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;; mso-ansi-language:EN-US">Connection: keep-alive</span>
                        <br />
        <span style="font-size:8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;
color:red;mso-ansi-language:EN-US">WSClientID</span><span style="font-size:
8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;
mso-ansi-language:EN-US">: 40000000-0000-0000-0000-000000000011</span>
                        <br />
        <span style="font-size:8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;
color:red;mso-ansi-language:EN-US">PLMUsername</span><span style="font-size:
8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;
mso-ansi-language:EN-US">: Administrator</span>
                        <br />
        <span style="font-size:8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;
color:red;mso-ansi-language:EN-US">TS</span><span style="font-size:8.5pt;
font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;mso-ansi-language:
EN-US">: 2008-09-22T14:01:54.9571247Z</span>
                        <br />
        <span style="font-size:8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;
color:red;mso-ansi-language:EN-US">Signature</span><span style="font-size:8.5pt;
font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;mso-ansi-language:
EN-US">: &lt;your_signature_here&gt;</span>
                        <br />
        <span style="font-size:8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;
color:red;mso-ansi-language:EN-US">Accept</span><span style="font-size:8.5pt;
font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;mso-ansi-language:
EN-US">: application/json</span>
                        <br />
        <span style="font-size:8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;
mso-ansi-language:EN-US">User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.52 Safari/537.17</span>
                        <br />
        <span style="font-size:8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;
mso-ansi-language:EN-US">Cache-Control: no-cache</span>
                        <br />
        <span style="font-size:8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;
mso-ansi-language:EN-US">Accept-Encoding: gzip,deflate,sdch</span>
                        <br />
        <span style="font-size:8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;
mso-ansi-language:EN-US">Accept-Language: en-US,en;q=0.8</span>
                        <br />
        <span style="font-size:8.5pt;font-family:&quot;Lucida Console&quot;;
mso-bidi-font-family:&quot;Lucida Console&quot;;mso-ansi-language:EN-US">Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.3</span>
                        <br />
                        <br />

        <b><span lang="RU" style="color:black">Response:&nbsp;</span></b>
                        <br />
        <span style="font-size:8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;
mso-ansi-language:EN-US">HTTP/1.1 200 OK</span>
                        <br />
        <span style="font-size:8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;
mso-ansi-language:EN-US">Server: ASP.NET Development Server/10.0.0.0</span>
                        <br />
        <span style="font-size:8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;
mso-ansi-language:EN-US">Date: Tue, 15 Jan 2013 21:20:26 GMT</span>
                        <br />
        <span style="font-size:8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;
mso-ansi-language:EN-US">X-AspNet-Version: 4.0.30319</span>
                        <br />
        <span style="font-size:8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;
mso-ansi-language:EN-US">X-Powered-By: ServiceStack/3.933 Win32NT/.NET</span>
                        <br />
        <span style="font-size:8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;
mso-ansi-language:EN-US">Cache-Control: private</span>
                        <br />
        <span style="font-size:8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;
mso-ansi-language:EN-US">Content-Type: application/json; charset=utf-8</span>
                        <br />
        <span style="font-size:8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;
mso-ansi-language:EN-US">Content-Length: 2566</span>
                        <br />
        <span style="font-size:8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;
mso-ansi-language:EN-US">Connection: Close</span>
                        <br />
        <span style="font-size:8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;
mso-ansi-language:EN-US"></span>
                        <br />
        <span style="font-size:8.5pt;font-family:&quot;Lucida Console&quot;;mso-bidi-font-family:&quot;Lucida Console&quot;;
mso-ansi-language:EN-US">{&quot;data&quot;:&quot;{\&quot;Yunique.API\&quot;:{\&quot;Data<span style="mso-spacerun:yes">&nbsp; </span>. . . . }</span>
                        <br />
                        <br />
                        <br />

        <span style="mso-ansi-language:EN-US">
        <br />
        <b style="mso-bidi-font-weight:normal"><u>SOAP Request and Response Example:</u></b></span>
                        <br />
        <span style="mso-ansi-language:EN-US">In Progress….<span 
            style="mso-spacerun:yes">&nbsp; </span>(but here is something…)</span>
                        <br />
                        <br />
                        <br />

        <b><span lang="RU" style="color:black">Request:</span></b>
                        <br />
        <span lang="RU" style="font-size:9.0pt">&lt;soap:Envelope xmlns:soap=&quot;<a href="http://www.w3.org/2003/05/soap-envelope">http://www.w3.org/2003/05/soap-envelope</a>&quot; 
        xmlns:yun=&quot;<a href="http://www.GerberTechnology.com/YuniqueAPI/">http://www.GerberTechnology.com/YuniqueAPI/</a>&quot;&gt;</span>
                        <br />
        <span lang="RU" style="font-size:9.0pt">&nbsp;&nbsp; &lt;soap:Header/&gt;</span>
                        <br />
        <span lang="RU" style="font-size:9.0pt">&nbsp;&nbsp; &lt;soap:Body&gt;</span>
                        <br />
        <span lang="RU" style="font-size:9.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;yun:StyleHeader&gt;</span>
                        <br />
        <span lang="RU" style="font-size:9.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;yun:WSClientName&gt;GT&lt;/yun:WSClientName&gt;</span>
                        <br />
        <span lang="RU" style="font-size:9.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;yun:WSClientPassword&gt;CO6I80aLnwoAz7SMQ2kxOw==&lt;/yun:WSClientPassword&gt;</span>
                        <br />
        <span lang="RU" style="font-size:9.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;yun:UserName&gt;peterd&lt;/yun:UserName&gt;</span>
                        <br />
        <span lang="RU" style="font-size:9.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;yun:CRUDType&gt;1&lt;/yun:CRUDType&gt;</span>
                        <br />
        <span lang="RU" style="font-size:9.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;!--Optional:--&gt;</span>
                        <br />
        <span lang="RU" style="font-size:9.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;yun:Params&gt;&lt;/yun:Params&gt;</span>
                        <br />
        <span lang="RU" style="font-size:9.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;!--Optional:--&gt;</span>
                        <br />
        <span lang="RU" style="font-size:9.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;yun:OrderBy&gt;&lt;/yun:OrderBy&gt;</span>
                        <br />
        <span lang="RU" style="font-size:9.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;!--Optional:--&gt;</span>
                        <br />
        <span lang="RU" style="font-size:9.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;yun:PageNumber&gt;1&lt;/yun:PageNumber&gt;</span>
                        <br />
        <span lang="RU" style="font-size:9.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;!--Optional:--&gt;</span>
                        <br />
        <span lang="RU" style="font-size:9.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;yun:PageSize&gt;25&lt;/yun:PageSize&gt;</span>
                        <br />
        <span lang="RU" style="font-size:9.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;!--Optional:--&gt;</span>
                        <br />
        <span lang="RU" style="font-size:9.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;yun:SkipLookupTables&gt;0&lt;/yun:SkipLookupTables&gt;</span>
                        <br />
        <span lang="RU" style="font-size:9.0pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;/yun:StyleHeader&gt;</span>
                        <br />
        <span lang="RU" style="font-size:9.0pt">&nbsp;&nbsp; &lt;/soap:Body&gt;</span>
                        <br />
        <span lang="RU" style="font-size:9.0pt">&lt;/soap:Envelope&gt;</span>
                        <br />
                        <br />

        <b><span lang="RU" style="color:black">Response:</span></b><br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:
text1">&lt;soap:Envelope xmlns:soap=&quot;<a href="http://www.w3.org/2003/05/soap-envelope"><span style="color:black;
mso-themecolor:text1">http://www.w3.org/2003/05/soap-envelope</span></a>&quot; xmlns:xsi=&quot;<a 
            href="http://www.w3.org/2001/XMLSchema-instance"><span 
            style="color:black;mso-themecolor:text1">http://www.w3.org/2001/XMLSchema-instance</span></a>&quot; 
        xmlns:xsd=&quot;<a href="http://www.w3.org/2001/XMLSchema"><span 
            style="color:black;mso-themecolor:text1">http://www.w3.org/2001/XMLSchema</span></a>&quot;&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp; &lt;soap:Body&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:
text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;StyleHeaderResponse xmlns=&quot;</span><span 
            lang="RU"><a href="http://www.GerberTechnology.com/YuniqueAPI/"><span 
            style="font-size:8.0pt;color:black;mso-themecolor:text1">http://www.GerberTechnology.com/YuniqueAPI/</span></a></span><span 
            lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&quot;&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;StyleHeaderResult&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;Yunique.API xmlns=&quot;&quot;&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;Data&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;pStyleHeader&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;StyleID&gt;14d9befd-9b0f-43e5-99b6-92c0ddb5f2cf&lt;/StyleID&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;DesignSketchID&gt;00000000-0000-0000-0000-000000000000&lt;/DesignSketchID&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;StyleType&gt;10&lt;/StyleType&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;stylestatus&gt;Development&lt;/stylestatus&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;StyleNo/&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;Description/&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;StyleCategory&gt;83b4a0a1-b2ad-4809-b05f-a016be23f7c4&lt;/StyleCategory&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;SizeRange&gt;26-32&lt;/SizeRange&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;SizeClass&gt;A Cup&lt;/SizeClass&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;IntroSeasonYearID&gt;37b6d2a9-baa4-4136-bd89-0625c249dbab&lt;/IntroSeasonYearID&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;WashType/&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;DueDate&gt;2012-07-02T00:00:00-05:00&lt;/DueDate&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;CustomField3/&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;Designer/&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;Active&gt;1&lt;/Active&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;MUser&gt;Emily Jenkins&lt;/MUser&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;MDate&gt;2010-12-09T15:54:37-06:00&lt;/MDate&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;Change&gt;1&lt;/Change&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;/pStyleHeader&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;pStyleHeader&gt;</span>
                        <br />
        <span style="font-size:8.0pt;color:black;mso-themecolor:text1;mso-ansi-language:EN-US"><span style="mso-tab-count:2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </span>. . .</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;/pStyleHeader&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;pStyleHeader&gt;</span>
                        <br />
        <span style="font-size:8.0pt;color:black;mso-themecolor:text1;mso-ansi-language:EN-US"><span style="mso-tab-count:2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </span>. . .</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;/pStyleHeader&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;pStyleHeader&gt;</span><span style="font-size:8.0pt;color:black;mso-themecolor:text1;mso-ansi-language:EN-US"></span>
                        <br />
        <span style="font-size:8.0pt;color:black;mso-themecolor:text1;mso-ansi-language:EN-US"><span style="mso-tab-count:2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        </span>. . .</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;/pStyleHeader&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        &lt;/Data&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&lt;/Yunique.API&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;/StyleHeaderResult&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt;/StyleHeaderResponse&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&nbsp;&nbsp; &lt;/soap:Body&gt;</span>
                        <br />
        <span lang="RU" style="font-size:8.0pt;color:black;mso-themecolor:text1">&lt;/soap:Envelope&gt;</span>
                        <br />
                        <br />
                        <br />

        <b style="mso-bidi-font-weight:normal"><u><span style="mso-ansi-language:EN-US">REST Request and Response Messages:</span></u></b>
                        <br />
                        <br />
                        <br />

        <b style="mso-bidi-font-weight:normal"><u><span style="mso-ansi-language:EN-US">SOAP WebMethod Parameters:</span></u></b>
                        <br />
                        <br />
                        <br />

        <b style="mso-bidi-font-weight:normal"><u><span style="mso-ansi-language:EN-US">Params Examples:</span></u></b>
                        <br />
        <span style="mso-ansi-language:EN-US">What follows below are several specific 
        sets of examples of what data must be passed in via the “Params”/”XMLFilters” in order to make particular calls.</span>
                        <br />
                        <ul>
                            <li><strong>ColorType</strong>
                                <ul>
                                    <li><span class="style2">Search Template</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">List</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Detail</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>Either ColorTypeDescription or ColorTypeID in order to get the ColorTypeID</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Schema</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>SchemaType ("Default" or "Search")</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <br />
                            </li>

                            <li><strong>ColorFolder</strong>
                                <ul>
                                    <li><span class="style2">Search Template</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>Either ColorTypeDescription or ColorTypeID in order to get the ColorTypeID</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">List</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>Either ColorTypeDescription or ColorTypeID in order to get the ColorTypeID</li>
                                                    <li>ColorName</li>
                                                    <li>ColorNumber</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Insert</span> <span class="style4">(allows multiple records to be passed in)</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>ColorFolderDescription</li>
                                                    <li>ColorFolderID (a blank one will let the API create the ID)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>Either ColorTypeDescription or ColorTypeID in order to get the ColorTypeID</li>
                                                    <li>ReturnMinimalResultSet (&quot;0&quot; = False, &quot;1&quot; = True)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Detail</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>ColorFolderID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>Either ColorTypeDescription or ColorTypeID in order to get the ColorTypeID</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Update</span> <span class="style4">(allows multiple records to be passed in)</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>ColorFolderID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>Either ColorTypeDescription or ColorTypeID in order to get the ColorTypeID</li>
                                                    <li>ReturnMinimalResultSet (&quot;0&quot; = False, &quot;1&quot; = True)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Schema</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>SchemaType ("Default" or "Search")</li>
                                                    <li>Either ColorTypeDescription or ColorTypeID in order to get the ColorTypeID</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <br />
                            </li>

                            <li><strong>ColorPalette</strong>
                                <ul>
                                    <li><span class="style2">Search Template</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>ColorFolderID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">List</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>ColorFolderID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Insert</span> <span class="style4">(allows multiple records to be passed in)</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>ColorFolderID</li>
                                                    <li>ColorCode</li>
                                                    <li>Hex</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>ColorPaletteID (a blank one will let the API create the ID)</li>
                                                    <li>ReturnMinimalResultSet (&quot;0&quot; = False, &quot;1&quot; = True)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Detail</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>ColorPaletteID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Update</span> <span class="style4">(allows multiple records to be passed in)</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>ColorPaletteID</li>
                                                    <li>Hex</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>ReturnMinimalResultSet (&quot;0&quot; = False, &quot;1&quot; = True)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Delete</span> <span class="style4">(allows multiple records to be passed in)</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>ColorPaletteID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Schema</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>SchemaType ("Default" or "Search")</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <br />
                            </li>

                            <li><strong>ImageType</strong>
                                <ul>
                                    <li><span class="style2">Search Template</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">List</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Detail</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>ImageType</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Schema</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>SchemaType ("Default" or "Search")</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <br />
                            </li>

                            <li><strong>Image</strong>
                                <ul>
                                    <li><span class="style2">Search Template</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>ImageSubFolder1</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">List</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>ImageSubFolder1</li>
                                                    <li>GetMD5 (&quot;0&quot; = False, &quot;1&quot; = True)</li>
                                                    <li>GetBase64 (&quot;0&quot; = False, &quot;1&quot; = True)</li>
                                                    <li>GetImgURLs (&quot;0&quot; = False, &quot;1&quot; = True)</li>
                                                    <li>GetHMAC (&quot;0&quot; = False, &quot;1&quot; = True)</li>
                                                    <li>ImageStreamerScale (Default = 128)</li>
                                                    <li>ImageStreamerFormat (Default = &quot;jpg&quot;)</li>
                                                    <li>authInfo</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Insert</span> <span class="style4">(allows multiple records to be passed in)</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>ImageID</li>
                                                    <li>ImageFileType</li>
                                                    <li>ImageSubFolder1</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>ReturnMinimalResultSet (&quot;0&quot; = False, &quot;1&quot; = True)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Detail</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>ImageID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>ImageSubFolder1</li>
                                                    <li>GetBase64 (&quot;0&quot; = False, &quot;1&quot; = True)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Update</span> <span class="style4">(allows multiple records to be passed in)</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>ImageID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>ReturnMinimalResultSet (&quot;0&quot; = False, &quot;1&quot; = True)</li>
                                                    <li>BImage</li>
                                                    <li>Version</li>
                                                    <li>ImageFile</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Delete</span> <span class="style4">(allows multiple records to be passed in)</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>ImageHistoryID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Schema</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>SchemaType ("Default" or "Search")</li>
                                                    <li>ImageSubFolder1</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Copy</span> <span class="style4">(allows multiple records to be passed in)</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>ImageID</li>
                                                    <li>Version</li>
                                                    <li>ImageLocation</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <br />
                            </li>

                            <li><strong>ImageHistory</strong>
                                <ul>
                                    <li><span class="style2">Search Template</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">List</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Detail</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>ImageHistoryID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Schema</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>SchemaType ("Default" or "Search")</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <br />
                            </li>

                            <li><strong>MeasurementBeforeTreatment</strong>
                                <ul>
                                    <li><span class="style2">List</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>WorkflowItemID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>ReturnAsMetricValues ("0"=False, "1"=True)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Schema</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>WorkflowItemID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>SchemaType ("Default" or "Search")</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <br />
                            </li>

                            <li><strong>MeasurementGradedSpec</strong>
                                <ul>
                                    <li><span class="style2">List</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>WorkflowItemID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>ReturnAsMetricValues ("0"=False, "1"=True)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Schema</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>WorkflowItemID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>SchemaType ("Default" or "Search")</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <br />
                            </li>

                            <li><strong>MeasurementGradeRule</strong>
                                <ul>
                                    <li><span class="style2">List</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>WorkflowItemID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Schema</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>WorkflowItemID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>SchemaType ("Default" or "Search")</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <br />
                            </li>

                            <li><strong>ProcessDetailType</strong>
                                <ul>
                                    <li><span class="style2">Search Template</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">List</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Detail</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>WorkflowItemTypeID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Schema</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>SchemaType ("Default" or "Search")</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <br />
                            </li>

                            <li><strong>ProcessDetail</strong>
                                <ul>
                                    <li><span class="style2">Search Template</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">List</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>StyleWorkflowID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Detail</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>WorkflowItemID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Schema</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>StyleWorkflowID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>SchemaType ("Default" or "Search")</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <br />
                            </li>

                            <li><strong>ProcessDetailItem</strong>
                                <ul>
                                    <li><span class="style2">Search Template</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">List</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>WorkflowItemID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Detail</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>ConstructionDetailID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Schema</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>WorkflowItemID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>SchemaType ("Default" or "Search")</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <br />
                            </li>

                            <li><strong>StyleDimBOMMaterial</strong>
                                <ul>
                                    <li><span class="style2">List</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>WorkflowItemID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Schema</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>WorkflowItemID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>SchemaType ("Default" or "Search")</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <br />
                            </li>

                            <li><strong>StyleType</strong>
                                <ul>
                                    <li><span class="style2">Search Template</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">List</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Schema</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>SchemaType ("Default" or "Scearch")</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <br />
                            </li>

                            <li><strong>StyleHeader</strong>
                                <ul>
                                    <li><span class="style2">Search Template</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>StyleTypeDescription, StyleType or StyleTypeID (for getting the StyleType)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">List</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>StyleTypeDescription, StyleType or StyleTypeID (for getting the StyleType)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Insert</span> <span class="style4">(allows multiple records to be passed in)</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>StyleTypeDescription, StyleType or StyleTypeID (for getting the StyleType)</li>
                                                    <li>WorkflowTemplateId</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>ReturnMinimalResultSet (&quot;0&quot; = False, &quot;1&quot; = True)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Detail</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>StyleID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Update</span> <span class="style4">(allows multiple records to be passed in)</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>StyleID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>ReturnMinimalResultSet (&quot;0&quot; = False, &quot;1&quot; = True)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Delete</span> <span class="style4">(allows multiple records to be passed in)</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>StyleID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Schema</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>SchemaType ("Default" or "Scearch")</li>
                                                    <li>StyleTypeDescription, StyleType or StyleTypeID (for getting the StyleType)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <br />
                            </li>

                            <li><strong>StylePage</strong>
                                <ul>
                                    <li><span class="style2">Search Template</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>StyleID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">List</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>StyleID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Schema</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>StyleID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>SchemaType ("Default" or "Scearch")</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <br />
                            </li>

                            <li><strong>TechPackSample</strong>
                                <ul>
                                    <li><span class="style2">Insert</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>StyleID</li>
                                                    <li>ReportTechPackFolderID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>AsyncEnable ("0"=False, "1"=True)</li>
                                                    <li>ReportLogEnable ("0"=False, "1"=True)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <br />
                            </li>

                            <li><strong>TechPackStyle</strong>
                                <ul>
                                    <li><span class="style2">Insert</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>StyleID</li>
                                                    <li>ReportTechPackFolderID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>AsyncEnable ("0"=False, "1"=True)</li>
                                                    <li>ReportLogEnable ("0"=False, "1"=True)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <br />
                            </li>

                            <li><strong>TechPackStyleBatch</strong>
                                <ul>
                                    <li><span class="style2">Insert</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>BatchQueueJobID</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>AsyncEnable ("0"=False, "1"=True)</li>
                                                    <li>ReportLogEnable ("0"=False, "1"=True)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <br />
                            </li>

                            <li><strong>TradePartnerTemplate</strong>
                                <ul>
                                    <li><span class="style2">Search Template</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">List</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Schema</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>SchemaType ("Default" or "Scearch")</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <br />
                            </li>

                            <li><strong>User</strong>
                                <ul>
                                    <li><span class="style2">Search Template</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">List</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Insert</span> <span class="style4">(allows multiple records to be passed in)</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>FirstName, LastName or both</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>Active</li>
                                                    <li>Email</li>
                                                    <li>PassWord</li>
                                                    <li>PreferredLang</li>
                                                    <li>UserName</li>
                                                    <li>ReturnMinimalResultSet (&quot;0&quot; = False, &quot;1&quot; = True)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Detail</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>TeamID or UserName</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Update</span> <span class="style4">(allows multiple records to be passed in)</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>TeamID or UserName</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>ReturnMinimalResultSet (&quot;0&quot; = False, &quot;1&quot; = True)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Schema</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>SchemaType ("Default" or "Scearch")</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                                <br />
                            </li>

                            <li><strong>WorkflowTemplate</strong>
                                <ul>
                                    <li><span class="style2">Search Template</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">List</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">Schema</span>
                                        <ul>
                                            <li><span class="style1">Required params</span>
                                                <ul>
                                                    <li>(none)</li>
                                                </ul>
                                            </li>
                                            <li><span class="style3">Optional named params</span>
                                                <ul>
                                                    <li>SchemaType ("Default" or "Scearch")</li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                        <br />
                        <br />


                        <b style="mso-bidi-font-weight:normal"><u><span style="mso-ansi-language:EN-US">VB.NET Code Examples:</span></u></b>
                        <br />
                        <span style="mso-ansi-language:EN-US">What follows below are several specific sets of VB.NET code examples of how to call the APIs directly.</span>
                        <br />
                        <ul>
                            <li><strong>Login View</strong>
                                <ul>
                                    <li><span class="style2">GetUserData</span>
                                        <ul>
                                            <li><span class="style5">Dim strParams = "&lt;Params Signature=&quot;&quot;7Ab5TnV2gbOi5QLMwBpj97m3rLtrX0daIz/b/oqUmvs=&quot;&quot; TimeStamp=&quot;&quot;01112013 125300&quot;&quot;&gt;&lt;UserName&gt;Administrator&lt;/UserName&gt;&lt;/Params&gt;"</span></li>
                                            <li><span class="style5">Dim objUserAPI As New Yunique.BOL.User()</span></li>
                                            <li><span class="style5">Dim dsResults as DataSet = objUserAPI.CRUDDataSet("administrator", Enums.CRUDType.List, strParams, "", False)</span></li>
                                        </ul>
                                    </li>
                                </ul>
                                <br />
                            </li>

                            <li><strong>Colors Application</strong>
                                <ul>
                                    <li><span class="style2">AddColorFolder</span>
                                        <ul>
                                            <li><span class="style5">Dim strParams = "&lt;Params&gt;&lt;ColorFolderID&gt;&lt;/ColorFolderID&gt;&lt;ColorTypeID&gt;1&lt;/ColorTypeID&gt;&lt;ColorFolderDescription&gt;Test 2012&lt;/ColorFolderDescription&gt;&lt;Active&gt;1&lt;/Active&gt;&lt;/Params&gt;"</span></li>
                                            <li><span class="style5">Dim objColorAPI As New Yunique.BOL.ColorFolder()</span></li>
                                            <li><span class="style5">Dim dsResults as DataSet = objColorAPI.CRUDDataSet("administrator", Enums.CRUDType.Create, strParams, "", False)</span></li>
                                            <li><strong>Request:</strong>
                                                <ul>
                                                    <li><span lang="RU" style="font-size:9.0pt;color:black;mso-themecolor:text1">POST http://localhost.:24297/colorfolder/insert HTTP/1.1<br />
                                                        Accept: application/xml<br />
                                                        KeyID: 40000000-0000-0000-0000-000000000011<br />
                                                        TS: 1/17/2013 3:15:49 AM<br />
                                                        Signature: JtJOP4yqJZ8uWzgiJI81HUPbFim0RZcb0VY4Ud/yUcw=<br />
                                                        WSClientID: 40000000-0000-0000-0000-000000000011<br />
                                                        PLMUsername: Administrator<br />
                                                        Content-Type: application/xml<br />
                                                        Host: localhost.:24297<br />
                                                        Content-Length: 1481<br />
                                                        Expect: 100-continue<br />
                                                        Connection: Keep-Alive<br /><br />
                                                        &lt;ColorFolderInsert xmlns="http://schemas.datacontract.org/2004/07/Yunique.API.Rest.DTOs" xmlns:i="http://www.w3.org/2001/XMLSchema-instance"&gt;&lt;CRUDType xmlns="http://schemas.datacontract.org/2004/07/Yunique.API.Common.DTOs"&gt;0&lt;/CRUDType&gt;&lt;IncludeResultSchema xmlns="http://schemas.datacontract.org/2004/07/Yunique.API.Common.DTOs"&gt;false&lt;/IncludeResultSchema&gt;&lt;OrderBy i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Yunique.API.Common.DTOs"/&gt;&lt;PageNumber i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Yunique.API.Common.DTOs"/&gt;&lt;PageSize i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Yunique.API.Common.DTOs"/&gt;&lt;Params xmlns="http://schemas.datacontract.org/2004/07/Yunique.API.Common.DTOs"&gt;&lt;Params&gt;&lt;ColorFolderID&gt;&lt;/ColorFolderID&gt;&lt;ColorTypeID&gt;1&lt;/ColorTypeID&gt;&lt;ColorFolderDescription&gt;Test 2012 (Part II)&lt;/ColorFolderDescription&gt;&lt;Active&gt;1&lt;/Active&gt;&lt;/Params&gt;&lt;/Params&gt;&lt;ServiceType xmlns="http://schemas.datacontract.org/2004/07/Yunique.API.Common.DTOs"&gt;0&lt;/ServiceType&gt;&lt;SkipLookupTables i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Yunique.API.Common.DTOs"/&gt;&lt;UserName i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Yunique.API.Common.DTOs"/&gt;&lt;WSClientName i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Yunique.API.Common.DTOs"/&gt;&lt;WSClientPassword i:nil="true" xmlns="http://schemas.datacontract.org/2004/07/Yunique.API.Common.DTOs"/&gt;&lt;/ColorFolderInsert&gt;</span>
                                                    </li>
                                                </ul>
                                            </li>
                                            <li><strong>Response:</strong>
                                                <ul>
                                                    <li><span lang="RU" style="font-size:9.0pt;color:black;mso-themecolor:text1">HTTP/1.1 200 OK<br />
                                                        Server: ASP.NET Development Server/10.0.0.0<br />
                                                        Date: Thu, 17 Jan 2013 03:16:39 GMT<br />
                                                        X-AspNet-Version: 4.0.30319<br />
                                                        X-Powered-By: ServiceStack/3.933 Win32NT/.NET<br />
                                                        Cache-Control: private<br />
                                                        Content-Type: application/xml<br />
                                                        Content-Length: 358<br />
                                                        Connection: Close<br /><br />
                                                        &lt;ColorFolderInsertResponse xmlns:i="http://www.w3.org/2001/XMLSchema-instance" xmlns="http://schemas.datacontract.org/2004/07/Yunique.API.Rest.DTOs"&gt;&lt;Data xmlns="http://schemas.datacontract.org/2004/07/Yunique.API.Common.DTOs"&gt;{"YuniqueAPI":{"Data":{"Results":{"ColorFolderID":"3b16e925-f67d-496d-90a4-856a29a0bc00"}}}}&lt;/Data&gt;&lt;/ColorFolderInsertResponse&gt;</span>
                                                    </li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">AddColorPalette</span>
                                        <ul>
                                            <li class="style5">Dim strParams = 
                                                "&lt;Params&gt;&lt;ColorPaletteID&gt;&lt;/ColorPaletteID&gt;&lt;ColorFolderID&gt;00000000-0000-0000-0000-000000000000&lt;/ColorFolderID&gt;&lt;ColorCode&gt;17-3014 
                                                TCX&lt;/ColorCode&gt;&lt;ColorName&gt;Mulberry&lt;/ColorName&gt;&lt;ColorSource&gt;PANTONE 
                                                TCX&lt;/ColorSource&gt;&lt;Hex&gt;A76C97&lt;/Hex&gt;&lt;R&gt;167&lt;/R&gt;&lt;G&gt;108&lt;/G&gt;&lt;B&gt;151&lt;/B&gt;&lt;LAB_L&gt;53.74&lt;/LAB_L&gt;&lt;LAB_A&gt;28.83&lt;/LAB_A&gt;&lt;LAB_B&gt;-12.29&lt;/LAB_B&gt;&lt;/Params&gt;"</li>
                                            <li><span class="style5">Dim objColorAPI As New Yunique.BOL.ColorPalette()</span></li>
                                            <li><span class="style5">Dim dsResults as DataSet = objColorAPI.CRUDDataSet("administrator", Enums.CRUDType.Create, strParams, "", False)</span></li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">DeleteColorPalettes</span>
                                        <ul>
                                            <li class="style5">Dim strParams = &quot;&lt;Params&gt;&lt;ParamRecord&gt;&lt;ColorPaletteID&gt;00000000-0000-0000-0000-000000000000&lt;/ColorPaletteID&gt;&lt;/ParamRecord&gt;&lt;ParamRecord&gt;&lt;ColorPaletteID&gt;00000000-0000-0000-0000-000000000000&lt;/ColorPaletteID&gt;&lt;/ParamRecord&gt;&lt;/Params&gt;&quot;</li>
                                            <li><span class="style5">Dim objColorAPI As New Yunique.BOL.ColorPalette()</span></li>
                                            <li><span class="style5">Dim dsResults as DataSet = objColorAPI.CRUDDataSet(&quot;administrator&quot;, Enums.CRUDType.Delete, strParams, &quot;&quot;, False)</span></li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">EditColorPalette</span>
                                        <ul>
                                            <li><span class="style5">Dim strParams = 
                                                &quot;&lt;Params&gt;&lt;ColorPaletteID&gt;00000000-0000-0000-0000-000000000000&lt;/ColorPaletteID&gt;&lt;ColorFolderID&gt;00000000-0000-0000-0000-000000000000&lt;/ColorFolderID&gt;&lt;ColorCode&gt;15-1058 
                                                TCX&lt;/ColorCode&gt;&lt;ColorName&gt;Radiant Yellow&lt;/ColorName&gt;&lt;ColorSource&gt;PANTONE 
                                                TCX&lt;/ColorSource&gt;&lt;Hex&gt;FC9E21&lt;/Hex&gt;&lt;R&gt;252&lt;/R&gt;&lt;G&gt;158&lt;/G&gt;&lt;B&gt;33&lt;/B&gt;&lt;LAB_L&gt;74.43&lt;/LAB_L&gt;&lt;LAB_A&gt;31.04&lt;/LAB_A&gt;&lt;LAB_B&gt;73.5&lt;/LAB_B&gt;&lt;/Params&gt;&quot;</span></li>
                                            <li><span class="style5">Dim objColorAPI As New Yunique.BOL.ColorPalette()</span></li>
                                            <li><span class="style5">Dim dsResults as DataSet = objColorAPI.CRUDDataSet("administrator", Enums.CRUDType.Update, strParams, "", False)</span></li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">GetColorFolderTypes</span>
                                        <ul>
                                            <li><span class="style5">Dim strParams = &quot;&quot;</span></li>
                                            <li><span class="style5">Dim objColorAPI As New Yunique.BOL.ColorType()</span></li>
                                            <li><span class="style5">Dim dsResults as DataSet = objColorAPI.CRUDDataSet("administrator", Enums.CRUDType.List, strParams, "", False)</span></li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">GetPalettes</span>
                                        <ul>
                                            <li><span class="style5">Dim strParams = "&lt;Params&gt;&lt;ColorFolderID&gt;00000000-0000-0000-0000-000000000000&lt;/ColorFolderID&gt;&lt;/Params&gt;"</span></li>
                                            <li><span class="style5">Dim objColorAPI As New Yunique.BOL.ColorPalette()</span></li>
                                            <li><span class="style5">Dim dsResults as DataSet = objColorAPI.CRUDDataSet(&quot;administrator&quot;, Enums.CRUDType.List, strParams, &quot;&quot;, False)</span></li>
                                            <li><strong>Request:</strong>
                                                <ul>
                                                    <li><span lang="RU" style="font-size:9.0pt;color:black;mso-themecolor:text1">GET http://localhost:24297/colorpalette/list?Params={%20%22Params%22:%20{%20%22ColorFolderID%22:%20%2200000000-0000-0000-0000-000000000000%22%20}%20} HTTP/1.1<br />
                                                        Host: localhost:24297<br />
                                                        Connection: keep-alive<br />
                                                        TS: 2008-09-22T14:01:54.9571247Z<br />
                                                        PLMUsername: Administrator<br />
                                                        User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.52 Safari/537.17<br />
                                                        Accept: application/json<br />
                                                        Cache-Control: no-cache<br />
                                                        Signature: JHSJDKFHSDF9U439F394F49HF739F<br />
                                                        WSClientID: 40000000-0000-0000-0000-000000000011<br />
                                                        Accept-Encoding: gzip,deflate,sdch<br />
                                                        Accept-Language: en-US,en;q=0.8<br />
                                                        Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.3</span>
                                                    </li>
                                                </ul>
                                            </li>
                                            <li><strong>String Signed:</strong>
                                                <ul>
                                                    <li><span lang="RU" style="font-size:9.0pt;color:black;mso-themecolor:text1">"Yunique.API;/colorpalette/list?Params={%20%22Params%22:%20{%20%22ColorFolderID%22:%20%2200000000-0000-0000-0000-000000000000%22%20}%20};20012-12-22T14:01:54.9571247Z"</span>
                                                    </li>
                                                </ul>
                                            </li>
                                            <li><strong>Response:</strong>
                                                <ul>
                                                    <li><span lang="RU" style="font-size:9.0pt;color:black;mso-themecolor:text1">HTTP/1.1 200 OK<br />
                                                        Server: ASP.NET Development Server/10.0.0.0<br />
                                                        Date: Tue, 15 Jan 2013 22:10:56 GMT<br />
                                                        X-AspNet-Version: 4.0.30319<br />
                                                        X-Powered-By: ServiceStack/3.933 Win32NT/.NET<br />
                                                        Cache-Control: private<br />
                                                        Content-Type: application/json; charset=utf-8<br />
                                                        Content-Length: 2566<br />
                                                        Connection: Close<br /><br />
                                                        {"data": "{"YuniqueAPI":{"Data":{"pColorType":[{"pColorTypeId": "205ba27d-12a1-457d-ab3e-64b0591156ce","ColorTypeID": "0","ColorTypeDescription": "Company Library","ColorFolderSearchSchema": "Color_Folder_Search.xml","ColorFolderSchema": "Color_Folder_Default_Library.xml","ColorPaletteSchema": "Color_Palette_Edit.xml","ColorPaletteItemSchema": "Color_PaletteItem_Default.xml","ColorPaletteSearchSchema": "Color_Palette_Search.xml","ColorPaletteImageSchema": "Color_Palette_Image_Edit.xml","Sort": "001","CorpColor": "1","ColorLibraryTypeID": "00000000-0000-0000-0000-000000000001","ColorPaletteGridSearchSchema": "Color_Palette_GridSearch_Default.xml","Active": "1"},{"pColorTypeId": "375fb4ec-0d35-40ef-826d-7516e3970173","ColorTypeID": "1","ColorTypeDescription": "Seasonal","ColorFolderSearchSchema": "Color_Folder_Search.xml","ColorFolderSchema": "Color_Folder_Default.xml","ColorPaletteSchema": "Color_Palette_Edit.xml","ColorPaletteItemSchema": "Color_PaletteItem_Default.xml","ColorPaletteSearchSchema": "Color_Palette_Search.xml","ColorPaletteImageSchema": "Color_Palette_Image_Edit.xml","Sort": "001","CorpColor": "0","ColorPaletteGridSearchSchema": "Color_Palette_GridSearch_Default.xml","Active": "1"},{"pColorTypeId": "b6d554ad-d08f-401d-9dca-e73f964def1e","ColorTypeID": "3","ColorTypeDescription": "Textile","ColorFolderSearchSchema": "Color_Folder_Search.xml","ColorFolderSchema": "Color_Folder_Default.xml","ColorPaletteSchema": "Color_Palette_Edit.xml","ColorPaletteItemSchema": "Color_PaletteItem_Default.xml","ColorPaletteSearchSchema": "Color_Palette_Search.xml","ColorPaletteImageSchema": "Color_Palette_Image_Edit.xml","Sort": "003","CorpColor": "0","ColorPaletteGridSearchSchema": "Color_Palette_GridSearch_Default.xml","Active": "1"},{"pColorTypeId": "644d43ac-97e4-449a-9c33-644d1c1e1e6c","ColorTypeID": "2","ColorTypeDescription": "Trim","ColorFolderSearchSchema": "Color_Folder_Search.xml","ColorFolderSchema": "Color_Folder_Default.xml","ColorPaletteSchema": "Color_Palette_Edit.xml","ColorPaletteItemSchema": "Color_PaletteItem_Default.xml","ColorPaletteSearchSchema": "Color_Palette_Search.xml","ColorPaletteImageSchema": "Color_Palette_Image_Edit.xml","Sort": "002","CorpColor": "0","ColorPaletteGridSearchSchema": "Color_Palette_GridSearch_Default.xml","Active": "1"}],"Active":[{"CustomKey": "0","Custom": "No"},{"CustomKey": "1","Custom": "Yes"}]}}}"}
                                                        </span>
                                                    </li>
                                                </ul>
                                            </li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">UpdateColorFolder</span>
                                        <ul>
                                            <li class="style5">Dim strParams = 
                                                &quot;&lt;Params&gt;&lt;ColorFolderID&gt;00000000-0000-0000-0000-000000000000&lt;/ColorFolderID&gt;&lt;ColorTypeID&gt;1&lt;/ColorTypeID&gt;&lt;ColorFolderDescription&gt;Test 
                                                2012-1&lt;/ColorFolderDescription&gt;&lt;Active&gt;1&lt;/Active&gt;&lt;/Params&gt;&quot;</li>
                                            <li><span class="style5">Dim objColorAPI As New Yunique.BOL.ColorFolder()</span></li>
                                            <li><span class="style5">Dim dsResults as DataSet = objColorAPI.CRUDDataSet("administrator", Enums.CRUDType.Update, strParams, "", False)</span></li>
                                        </ul>
                                    </li>
                                </ul>
                                <br />
                            </li>

                            <li><strong>Images Application</strong>
                                <ul>
                                    <li><span class="style2">CreateImage</span>
                                        <ul>
                                            <li><span class="style5">Dim strParams = "&lt;Params&gt;&lt;ImageID&gt;&lt;/ImageID&gt;&lt;ImageSubFolder1&gt;Style&lt;/ImageSubFolder1&gt;&lt;ImageDescription&gt;Test&lt;/ImageDescription&gt;&lt;ImageFileType&gt;EPS&lt;/ImageFileType&gt;&lt;ImageSubFolder6&gt;00000000-0000-0000-0000-000000000000&lt;/ImageSubFolder6&gt;&lt;ImageSubFolder7&gt;Photos&lt;/ImageSubFolder7&gt;&lt;ImageKeywords&gt;Test&lt;/ImageKeywords&gt;&lt;ImageWorkflowTemplateID&gt;00000000-0000-0000-0000-000000000000&lt;/ImageWorkflowTemplateID&gt;&lt;/Params&gt;"</span></li>
                                            <li><span class="style5">Dim objImageAPI As New Yunique.BOL.Image()</span></li>
                                            <li><span class="style5">Dim dsResults as DataSet = objImageAPI.CRUDDataSet("administrator", Enums.CRUDType.Create, strParams, "", False)</span></li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">GetImageDetailsSchema</span>
                                        <ul>
                                            <li><span class="style5">Dim strParams = "&lt;Params&gt;&lt;ImageSubFolder1&gt;Style&lt;/ImageSubFolder1&gt;&lt;/Params&gt;"<br />
                                                Or<br />
                                                strParams = ""</span></li>
                                            <li><span class="style5">Dim objImageAPI As New Yunique.BOL.Image()</span></li>
                                            <li><span class="style5">Dim dsResults as DataSet = objImageAPI.CRUDDataSet("administrator", Enums.CRUDType.Schema, strParams, "", False, 1, 25)</span></li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">GetImageSchema</span>
                                        <ul>
                                            <li><span class="style5">Dim strParams = "&lt;Params&gt;&lt;ImageSubFolder1&gt;Style&lt;/ImageSubFolder1&gt;&lt;/Params&gt;"<br />
                                                Or<br />
                                                strParams = ""</span></li>
                                            <li><span class="style5">Dim objImageAPI As New Yunique.BOL.ImageHistory()</span></li>
                                            <li><span class="style5">Dim dsResults as DataSet = objImageAPI.CRUDDataSet("administrator", Enums.CRUDType.Schema, strParams, "", False, 1, 25)</span></li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">SearchImages</span>
                                        <ul>
                                            <li><span class="style5">Dim strParams = "&lt;Params&gt;&lt;ImageSubFolder1&gt;Style&lt;/ImageSubFolder1&gt;&lt;/Params&gt;"</span></li>
                                            <li><span class="style5">Dim objImageAPI As New Yunique.BOL.Image()</span></li>
                                            <li><span class="style5">Dim dsResults as DataSet = objImageAPI.CRUDDataSet("administrator", Enums.CRUDType.List, strParams, "", False, 1, 25)</span></li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">UpdateImage</span>
                                        <ul>
                                            <li><span class="style5">Dim strParams = "&lt;Params&gt;&lt;ImageID&gt;00000000-0000-0000-0000-000000000000&lt;/ImageID&gt;&lt;ImageSubFolder1&gt;Style&lt;/ImageSubFolder1&gt;&lt;ImageDescription&gt;Test&lt;/ImageDescription&gt;&lt;ImageFileType&gt;EPS&lt;/ImageFileType&gt;&lt;ImageSubFolder6&gt;00000000-0000-0000-0000-000000000000&lt;/ImageSubFolder6&gt;&lt;ImageSubFolder7&gt;Photos&lt;/ImageSubFolder7&gt;&lt;ImageKeywords&gt;Spring&lt;/ImageKeywords&gt;&lt;ImageWorkflowTemplateID&gt;00000000-0000-0000-0000-000000000000&lt;/ImageWorkflowTemplateID&gt;&lt;/Params&gt;"</span></li>
                                            <li><span class="style5">Dim objImageAPI As New Yunique.BOL.Image()</span></li>
                                            <li><span class="style5">Dim dsResults as DataSet = objImageAPI.CRUDDataSet("administrator", Enums.CRUDType.Update, strParams, "", False)</span></li>
                                        </ul>
                                    </li>
                                </ul>
                                <br />
                            </li>

                            <li><strong>Styles Application</strong>
                                <ul>
                                    <li><span class="style2">GetStyleSchema</span>
                                        <ul>
                                            <li><span class="style5">Dim strParams = "&lt;Params&gt;&lt;StyleType&gt;10&lt;/StyleType&gt;&lt;/Params&gt;"</span></li>
                                            <li><span class="style5">Dim objStyleAPI As New Yunique.BOL.StyleHeader()</span></li>
                                            <li><span class="style5">Dim dsResults as DataSet = objStyleAPI.CRUDDataSet("administrator", Enums.CRUDType.Schema, strParams, "", False, 1, 25)</span></li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">LinkImageToStyle</span>
                                        <ul>
                                            <li><span class="style5">Dim strParams = "&lt;Params&gt;&lt;ParamRecord&gt;&lt;StyleID&gt;0e485798-afd5-46e1-b885-e6484dffe205&lt;/StyleID&gt;&lt;DesignSketchID&gt;00000000-0000-0000-0000-000000000000&lt;/DesignSketchID&gt;&lt;/ParamRecord&gt;&lt;/Params&gt;"</span></li>
                                            <li><span class="style5">Dim objStyleAPI As New Yunique.BOL.StyleHeader()</span></li>
                                            <li><span class="style5">Dim dsResults as DataSet = objStyleAPI.CRUDDataSet("administrator", Enums.CRUDType.Update, strParams, "", False)</span></li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">SearchStyle</span>
                                        <ul>
                                            <li><span class="style5">Dim strParams = "&lt;Params&gt;&lt;StyleType&gt;10&lt;/StyleType&gt;&lt;/Params&gt;"</span></li>
                                            <li><span class="style5">Dim objStyleAPI As New Yunique.BOL.StyleHeader()</span></li>
                                            <li><span class="style5">Dim dsResults as DataSet = objStyleAPI.CRUDDataSet("administrator", Enums.CRUDType.List, strParams, "", False, 1, 25)</span></li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">CreateStyle</span>
                                        <ul>
                                            <li><span class="style5">Dim strParams = "&lt;Params&gt;&lt;StyleType&gt;10&lt;/StyleType&gt;&lt;WorkflowTemplateId&gt;7CBDDD58-B08E-4723-9477-C9E791CDF36E&lt;/WorkflowTemplateId&gt;&lt;Description&gt;PSD Test #011&lt;/Description&gt;&lt;StyleCategory&gt;FEFB00DC-9134-4E13-96DA-B7B9D7923BB9&lt;/StyleCategory&gt;&lt;SizeRange&gt;4-6X&lt;/SizeRange&gt;&lt;SizeClass&gt;Mens&lt;/SizeClass&gt;&lt;IntroSeasonYearID&gt;37B6D2A9-BAA4-4136-BD89-0625C249DBAB&lt;/IntroSeasonYearID&gt;&lt;WashType&gt;01&lt;/WashType&gt;&lt;DueDate&gt;2012-12-25 00:00:00&lt;/DueDate&gt;&lt;CustomField3&gt;In Progress&lt;/CustomField3&gt;&lt;/Params&gt;"</span></li>
                                            <li><span class="style5">Dim objStyleAPI As New Yunique.BOL.StyleHeader()</span></li>
                                            <li><span class="style5">Dim dsResults as DataSet = objStyleAPI.CRUDDataSet("administrator", Enums.CRUDType.Create, strParams, "", False)</span></li>
                                        </ul>
                                    </li>
                                    <li><span class="style2">UpdateStyle</span>
                                        <ul>
                                            <li><span class="style5">Dim strParams = "&lt;Params&gt;&lt;ParamRecord&gt;&lt;StyleID&gt;0e485798-afd5-46e1-b885-e6484dffe205&lt;/StyleID&gt;&lt;StyleType&gt;10&lt;/StyleType&gt;&lt;StyleNo&gt;YA12?02&lt;/StyleNo&gt;&lt;Description&gt;Cap Sleeve Top 4&lt;/Description&gt;&lt;Year&gt;2012&lt;/Year&gt;&lt;Active&gt;1&lt;/Active&gt;&lt;/ParamRecord&gt;&lt;ParamRecord&gt;&lt;StyleID&gt;0e485798-afd5-46e1-b885-e6484dffe205&lt;/StyleID&gt;&lt;Description&gt;Cap Sleeve Top 5&lt;/Description&gt;&lt;/ParamRecord&gt;&lt;/Params&gt;"</span></li>
                                            <li><span class="style5">Dim objStyleAPI As New Yunique.BOL.StyleHeader()</span></li>
                                            <li><span class="style5">Dim dsResults as DataSet = objStyleAPI.CRUDDataSet("administrator", Enums.CRUDType.Update, strParams, "", False)</span></li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                        </ul>

                    </td>
				</tr>
			</table>

	    </form>
	</body>
</html>
