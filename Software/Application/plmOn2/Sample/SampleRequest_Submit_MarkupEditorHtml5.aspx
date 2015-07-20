﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SampleRequest_Submit_MarkupEditorHtml5.aspx.vb" Inherits="plmOnApp.SampleRequest_Submit_MarkupEditorHtml5" %>
<!DOCTYPE html>
<html>
<head>
    <base href="<%= strMarkupServer %>/" />
    <title>Co-draw ff Markup</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=9">
    <link rel="apple-touch-startup-image" href="bower_components/durandal/img/ios-startup-image-landscape.png"
        media="(orientation:landscape)">
    <link rel="apple-touch-startup-image" href="bower_components/durandal/img/ios-startup-image-portrait.png"
        media="(orientation:portrait)">
    <link rel="apple-touch-icon" href="bower_components/durandal/img/icon.png">
    <link type="text/css" rel="stylesheet" href="css/libs.css">
    <link type="text/css" rel="stylesheet" href="css/app.css">
    <script type="text/javascript">        if (navigator.userAgent.match(/IEMobile\/10\.0/)) {
            var msViewportStyle = document.createElement("style");
            var mq = "@@-ms-viewport{width:auto!important}";
            msViewportStyle.appendChild(document.createTextNode(mq));
            document.getElementsByTagName("head")[0].appendChild(msViewportStyle);
        }</script>
    <body>
        <div id="applicationHost">
            <div class="splash">
                <img src="assets/y_logo.png" alt=""><p class="message">
                    Initializing markup tool...</p>
                <p class="spinner">
                    <img src="assets/spinner.GIF" alt=""></p>
            </div>
        </div>
        <script type="text/javascript">
            window.markupConfig = {
                imageServer: '<%= strImageServer %>/',
                appServer: '<%= strMarkupServer %>/'
            };
        </script>
        <script type="text/javascript" src="js/app.js"></script>
