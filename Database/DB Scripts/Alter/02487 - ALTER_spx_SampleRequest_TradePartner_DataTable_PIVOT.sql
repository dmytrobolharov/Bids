-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Alter Script                                                                               */
-- * Database:                                                                                  */
-- * 21 December 2011                                                                           */
-- *                                                                                            */
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET NOCOUNT ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'spx_SampleRequest_TradePartner_DataTable_PIVOT') AND type = N'P' )
	DROP PROCEDURE spx_SampleRequest_TradePartner_DataTable_PIVOT
GO


CREATE PROCEDURE spx_SampleRequest_TradePartner_DataTable_PIVOT
(
	@TradepartnerID UNIQUEIDENTIFIER = NULL,   
	@TeamID UNIQUEIDENTIFIER,   
	@Filter NVARCHAR (4000)   
)
AS
	SELECT SampleWorkflow,
		REPLACE(SampleWorkflow, ' ', '_') AS SampleWorkflowField, 
		SampleWorkflowSort
	FROM pSampleWorkflow WITH (NOLOCK)
	WHERE
	(
		SampleWorkflowID IN
		(
			SELECT SampleWorkflowId
			FROM pSampleWorkflowViewSubmit WITH (NOLOCK)
			WHERE TeamId = @TeamId
		)
	)
	AND pSampleWorkflow.Active='Yes'  
	ORDER BY SampleWorkflowSort   
  
	--***  
	--** PIVOT  
	--***  
  
	CREATE TABLE #tmpSample1 
	(  
		SampleRequestTradeID UNIQUEIDENTIFIER,  
		SampleWorkflow NVARCHAR(200),  
		StyleID UNIQUEIDENTIFIER,  
		SampleRequestSubmitID UNIQUEIDENTIFIER,   
		TradePartnerID UNIQUEIDENTIFIER,   
		TradePartnerVendorID UNIQUEIDENTIFIER,  
		Link  NVARCHAR(4000),   
		AssignedTo INT,   
		StyleColorID UNIQUEIDENTIFIER ,  
		TechPack NVARCHAR(4000),  
		StyleSet NVARCHAR(200),  
		SetNo INT,  
		Season NVARCHAR(200),  
		Year NVARCHAR(200),
		SeasonYearID UNIQUEIDENTIFIER  
	)  
	  
	CREATE TABLE #tmpSample2 
	(  
		SampleRequestTradeID UNIQUEIDENTIFIER,  
		SampleWorkflow NVARCHAR(200),  
		StyleID UNIQUEIDENTIFIER,  
		SampleRequestSubmitID UNIQUEIDENTIFIER,   
		TradePartnerName NVARCHAR(200),  
		VendorName NVARCHAR(200),  
		TradePartnerID UNIQUEIDENTIFIER,   
		TradePartnerVendorID UNIQUEIDENTIFIER,  
		Link  NVARCHAR(4000),  
		StyleNo NVARCHAR(50) ,   
		CustomField1 NVARCHAR(400),
		DevelopmentNo NVARCHAR(40),
		CustomField5 NVARCHAR(400),
		CustomField6 NVARCHAR(400),
		CustomField7 NVARCHAR(400),
		CustomField9 NVARCHAR(400),
		StyleType INT,
		StyleCategory NVARCHAR(400),
		SizeRange NVARCHAR(100),
		Description NVARCHAR(100),  
		SizeClass NVARCHAR(50),  
		CustomField13 NVARCHAR(400),
		WashType NVARCHAR(100),
		CustomField10 NVARCHAR(400),
		CustomField11 NVARCHAR(400),
		CustomField12 NVARCHAR(400),
		Designer NVARCHAR(200), 
		Colorway NVARCHAR (200),  
		TechPack NVARCHAR(4000) ,  
		StyleSet NVARCHAR(200),  
		SetNo INT,  
		Season NVARCHAR(200),  
		Year NVARCHAR(200),  
		SeasonYearID UNIQUEIDENTIFIER  
	)   

  
	CREATE TABLE #tmpSample3 
	(  
		SampleRequestTradeID UNIQUEIDENTIFIER,  
		SampleWorkflow NVARCHAR(200),  
		StyleID UNIQUEIDENTIFIER,  
		SampleRequestSubmitID UNIQUEIDENTIFIER,   
		TradePartnerName NVARCHAR(200),  
		VendorName NVARCHAR(200),  
		TradePartnerID UNIQUEIDENTIFIER,   
		TradePartnerVendorID UNIQUEIDENTIFIER,  
		Link  NVARCHAR(4000),  
		StyleNo NVARCHAR(50), 
		CustomField1 NVARCHAR(400),  
		DevelopmentNo NVARCHAR(40),
		CustomField5 NVARCHAR(400),
		CustomField6 NVARCHAR(400),
		CustomField7 NVARCHAR(400),
		CustomField9 NVARCHAR(400),
		StyleType INT,
		StyleCategory NVARCHAR(400),
		SizeRange NVARCHAR(100),
		Description NVARCHAR(100),  
		SizeClass NVARCHAR(50), 
		CustomField13 NVARCHAR(400),
		WashType NVARCHAR(100),
		CustomField10 NVARCHAR(400),
		CustomField11 NVARCHAR(400),
		CustomField12 NVARCHAR(400),
		Designer NVARCHAR(200),  
		Colorway NVARCHAR (200),  
		TechPack NVARCHAR(4000) ,  
		StyleSet NVARCHAR(200),  
		SetNo INT,  
		Season NVARCHAR(200),  
		Year NVARCHAR(200),  
		SeasonYearID UNIQUEIDENTIFIER  
	)     
  
	IF @TradepartnerID IS NOT NULL  
	BEGIN  
  
		INSERT INTO #tmpSample1 
		(   
		SampleRequestTradeID, 
		SampleWorkflow, 
		StyleID, 
		SampleRequestSubmitID,  
		TradePartnerID,
		TradePartnerVendorID,
		Link,   
		AssignedTo,
		StyleColorID, 
		TechPack, 
		StyleSet, 
		SetNo, 
		Season, 
		Year,
		SeasonYearID  
		)  
		SELECT   
		a.SampleRequestTradeID, 
		REPLACE(f.SampleWorkflow, ' ', '_') AS SampleWorkflow, 
		a.StyleID, 
		a.SampleRequestSubmitID,   
		b.TradePartnerID , 
		b.TradePartnerVendorID,   
		'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR><TD width=''18''>   
		<IMG src=''' +   
		CASE   
		WHEN d.ApprovedType = 1  THEN '../System/Icons/icon_ball_green.gif'  
		WHEN a.Status = 4  THEN '../System/Icons/icon_ball_red.gif'  
		WHEN a.Submit = 1 THEN '../System/Icons/icon_ball_blue.gif'  
		ELSE '../System/Icons/icon_ball_yellow.gif'  
		END  
		+ '''  border=0 ALT=''Open''><TD class=''font'' align=center valign=center nowrap>&nbsp;   
		<a href=''#'' onclick="javascript:window.open(''../Sample/SampleRequest_Workflow_Redirect.aspx?SRTID=' +   
		CAST ( a.SampleRequestTradeID AS NVARCHAR(50)) + '&SWID=' + a.SampleWorkflowID + '&SN='+  CAST(a.StyleSet  as nvarchar(5)) +  
		''',''' +    
		Replace( CAST ( a.SampleRequestTradeID AS NVARCHAR(50)) , '-', '') +  
		''',''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'');">'   
		+  
		CASE   
		WHEN d.ApprovedType = 1 THEN ISNULL(CONVERT(VARCHAR(12),a.EndDate , 107),'NODATE')  
		WHEN a.Status = 4 THEN ISNULL(CONVERT(VARCHAR(12),a.MDate , 107),'NODATE')  
		ELSE ISNULL(CONVERT(VARCHAR(12),a.DueDate , 107),'NODATE')  
		END   
		+ '&nbsp;<b>('   
		+  CAST(a.Submit AS NVARCHAR(5)) + ')</b></a></TD></TR></TABLE>'  

		AS Link,   
		a.AssignedTo,
		b.StyleColorID,   
		CASE   
		WHEN  b.TechPackID IS NULL  OR b.TechPackID  = '00000000-0000-0000-0000-000000000000' THEN '<div align=center>-------</div>'  
		ELSE   
		'<TABLE>  
		<TR>  
		<TD width=''18''><IMG src=''../System/Icons/icon_packageok.gif'' border=''0''></TD>  
		<TD class=''font'' align=''center'' valign=''center'' nowrap>&nbsp;  
		<a href=''#'' onclick="javascript:window.open(''../Sample/SampleRequest_Workflow_Redirect.aspx?SRTID='  
		+ CAST (a.SampleRequestTradeID AS NVARCHAR(50))  
		+ '&SN=' + CAST(a.StyleSet AS NVARCHAR(10))   
		+ '&TP=1'' , '''   
		+ REPLACE ( CAST ( a.SampleRequestTradeID  AS NVARCHAR(50) ), '-', '' )   

		+ ''',  ''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'' '   
		+ ' );" >  '   
		+  ISNULL(CONVERT(VARCHAR(12),g.DueDate , 107),'NODATE')+  '</a></TD></TR></TABLE>'  
		END AS TechPack,  

		CASE   
		WHEN a.StyleSet = 1 THEN   
		CASE WHEN g.PC1 Is Not Null THEN g.PC1 ELSE '1st Set' END  
		WHEN a.StyleSet = 2 THEN   
		CASE WHEN g.PC2 Is Not Null THEN g.PC2 ELSE '2nd Set' END  
		WHEN a.StyleSet = 3 THEN   
		CASE WHEN g.PC3 Is Not Null THEN g.PC3 ELSE '3rd Set' END  
		WHEN a.StyleSet = 4 THEN   
		CASE WHEN g.PC4 Is Not Null THEN g.PC4 ELSE '4th Set' END   
		END AS StyleSet, 
		a.StyleSet as SetNo,
		i.Season, 
		i.Year,
		i.SeasonYearID    
		FROM dbo.pSampleRequestSubmit a  
		INNER JOIN pSampleRequestTrade b ON a.SampleRequestTradeID  = b.SampleRequestTradeID    
		INNER JOIN pSampleWorkflow c ON a.SampleWorkflowId = c.SampleWorkflowID   
		INNER JOIN pSampleRequestSubmitStatus d ON a.Status   = d.StatusID   
		INNER JOIN pSampleRequestWorkflow e ON e.SampleRequestWorkflowID = a.SampleRequestWorkflowID  AND e.Submit = a.Submit  --Comment #01  
		INNER JOIN pSampleWorkflow f ON f.SampleWorkflowID  =  e.SampleWorkflowID   
		INNER JOIN pStyleHeader g ON g.StyleID = b.StyleID  
		LEFT OUTER JOIN pStyleSeasonYear h ON h.StyleSeasonYearID =  b.StyleSeasonyearID   
		LEFT OUTER JOIN pSeasonYear i ON i.SeasonYearID =  h.SeasonYearID  
		INNER JOIN pSampleWorkflowViewSubmit j ON c.SampleWorkflowID=j.SampleWorkflowId    
		WHERE b.TradePartnerID = @TradepartnerID 
  
	END  
	ELSE   
	BEGIN  
  
		INSERT INTO #tmpSample1 
		(   
		SampleRequestTradeID,
		SampleWorkflow,
		StyleID,
		SampleRequestSubmitID,  
		TradePartnerID,
		TradePartnerVendorID,
		Link,   
		AssignedTo,
		StyleColorID,
		TechPack,
		StyleSet,
		SetNo,
		Season,
		Year,
		SeasonYearID  
		)  
		SELECT   
		a.SampleRequestTradeID,
		REPLACE(f.SampleWorkflow, ' ', '_') AS SampleWorkflow,
		a.StyleID,
		a.SampleRequestSubmitID,   
		b.TradePartnerID,
		b.TradePartnerVendorID,   
		'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR><TD width=''18''>   
		<IMG src=''' +   
		CASE   
		WHEN d.ApprovedType = 1  THEN '../System/Icons/icon_ball_green.gif'  
		WHEN a.Status = 4  THEN '../System/Icons/icon_ball_red.gif'  
		WHEN a.Submit = 1 THEN '../System/Icons/icon_ball_blue.gif'  
		ELSE '../System/Icons/icon_ball_yellow.gif'  
		END  
		+ '''  border=0 ALT=''Open''><TD class=''font'' align=center valign=center nowrap>&nbsp;   
		<a href=''#'' onclick="javascript:window.open(''../Sample/SampleRequest_Workflow_Redirect.aspx?SRTID=' +   
		CAST ( a.SampleRequestTradeID AS NVARCHAR(50)) + '&SWID=' + a.SampleWorkflowID + '&SN='+  CAST(a.StyleSet  as nvarchar(5)) +  
		''',''' +    
		Replace( CAST ( a.SampleRequestTradeID AS NVARCHAR(50)) , '-', '') +  
		''',''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'');">'   
		+  
		CASE   
		WHEN d.ApprovedType = 1 THEN ISNULL(CONVERT(VARCHAR(12),a.EndDate , 107),'NODATE') --CONVERT ( NVARCHAR(50), a.EndDate , 101)   
		WHEN a.Status = 4 THEN ISNULL(CONVERT(VARCHAR(12),a.MDate, 107),'NODATE')--CONVERT ( NVARCHAR(50), a.MDate , 101)  
		ELSE ISNULL(CONVERT(VARCHAR(12),a.DueDate, 107),'NODATE') --CONVERT ( NVARCHAR(50), a.DueDate , 101)  
		END   
		+ '&nbsp;<b>('   
		+  CAST(a.Submit AS NVARCHAR(5)) + ')</b></a></TD></TR></TABLE>'  

		AS Link,   
		a.AssignedTo,
		b.StyleColorID,   
		CASE   
		WHEN  b.TechPackID IS NULL  OR b.TechPackID  = '00000000-0000-0000-0000-000000000000' THEN '<div align=center>-------</div>'  
		ELSE   
		'<TABLE>  
		<TR>  
		<TD width=''18''><IMG src=''../System/Icons/icon_packageok.gif'' border=''0''></TD>  
		<TD class=''font'' align=''center'' valign=''center'' nowrap>&nbsp;  
		<a href=''#'' onclick="javascript:window.open(''../Sample/SampleRequest_Workflow_Redirect.aspx?SRTID='  
		+ CAST (a.SampleRequestTradeID AS NVARCHAR(50))  
		+ '&SN=' + CAST(a.StyleSet AS NVARCHAR(10))   
		+ '&TP=1'' , '''   
		+ REPLACE ( CAST ( a.SampleRequestTradeID  AS NVARCHAR(50) ), '-', '' )   

		+ ''',  ''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'' '   
		+ ' );" >  '   
		--+ CONVERT ( NVARCHAR(50), g.DueDate , 101)  +  '</a></TD></TR></TABLE>'  
		+ ISNULL(CONVERT(VARCHAR(12),g.DueDate, 107),'NODATE')  +  '</a></TD></TR></TABLE>'       
		END AS TechPack ,  
		CASE   
		WHEN a.StyleSet = 1 THEN   
		CASE WHEN g.PC1 Is Not Null THEN g.PC1 ELSE '1st Set' END  
		WHEN a.StyleSet = 2 THEN   
		CASE WHEN g.PC2 Is Not Null THEN g.PC2 ELSE '2nd Set' END  
		WHEN a.StyleSet = 3 THEN   
		CASE WHEN g.PC3 Is Not Null THEN g.PC3 ELSE '3rd Set' END  
		WHEN a.StyleSet = 4 THEN   
		CASE WHEN g.PC4 Is Not Null THEN g.PC4 ELSE '4th Set' END   
		END AS StyleSet, a.StyleSet as SetNo, i.Season, i.Year,i.SeasonYearID      
		FROM dbo.pSampleRequestSubmit a  
		INNER JOIN pSampleRequestTrade b ON a.SampleRequestTradeID  = b.SampleRequestTradeID    
		INNER JOIN pSampleWorkflow c ON a.SampleWorkflowId = c.SampleWorkflowID   
		INNER JOIN pSampleRequestSubmitStatus d ON a.Status   = d.StatusID   
		INNER JOIN pSampleRequestWorkflow e ON e.SampleRequestWorkflowID = a.SampleRequestWorkflowID AND e.Submit = a.Submit  --Comment #01  
		INNER JOIN pSampleWorkflow f ON f.SampleWorkflowID  =  e.SampleWorkflowID   
		INNER JOIN pStyleHeader g ON g.StyleID = b.StyleID  
		LEFT OUTER JOIN pStyleSeasonYear h ON h.StyleSeasonYearID =  b.StyleSeasonyearID   
		LEFT OUTER JOIN pSeasonYear i ON i.SeasonYearID =  h.SeasonYearID  
		INNER JOIN pSampleWorkflowViewSubmit j ON c.SampleWorkflowID=j.SampleWorkflowId    
  
	END  
  
  
	DECLARE @SQL_01 NVARCHAR(4000)   
  
	DECLARE @flag INT    
	SET @flag = 0  
  
	SET @SQL_01 = 'INSERT INTO #tmpSample2 
	(
		SampleRequestTradeID,
		SampleWorkflow,
		StyleID,
		SampleRequestSubmitID,  
		TradePartnerID,
		TradePartnerVendorID,
		TradePartnerName,
		VendorName,  
		Link,
		StyleNo,
		CustomField1,
		DevelopmentNo,
		CustomField5,
		CustomField6,
		CustomField7,
		CustomField9,
		StyleType,
		StyleCategory,
		SizeRange,
		CustomField13,
		WashType,
		CustomField10,
		CustomField11,
		CustomField12,
		Designer,
		Description,
		SizeClass,
		Colorway,
		TechPack,
		StyleSet,
		SetNo,
		Season,
		Year,
		SeasonYearID 
	)  
		SELECT 
		a.SampleRequestTradeID, 
		REPLACE(a.SampleWorkflow, '' '', ''_'') AS SampleWorkflow,
		a.StyleID,
		a.SampleRequestSubmitID,   
		a.TradePartnerID,
		a.TradePartnerVendorID,
		b.TradePartnerName,
		c.VendorName,  
		a.Link,
		d.StyleNo,
		d.CustomField1,
		d.DevelopmentNo,
		d.CustomField5,
		CustomField6,
		CustomField7,
		CustomField9,
		d.StyleType,
		d.StyleCategory,
		d.SizeRange,
		d.CustomField13,
		d.WashType,
		d.CustomField10,
		d.CustomField11,
		d.CustomField12,
		d.Designer,
		d.Description,
		d.SizeClass,
		g.StyleColorName,
		a.TechPack,
		a.StyleSet,
		a.SetNo,
		a.Season,
		a.Year,
		a.SeasonYearID  
		FROM #tmpSample1 a  
		INNER JOIN uTradePartner b ON b.TradePartnerID = a.TradePartnerID  
		INNER JOIN uTradePartnerVendor c ON c.TradePartnerVendorID = a.TradePartnerVendorID    
		INNER JOIN pStyleHeader d ON d.StyleID = a.StyleID   
		LEFT OUTER JOIN pStyleColorway g ON g.StyleColorID = a.StyleColorID'  
  
		EXEC (@SQL_01)    

		IF @Filter IS NOT NULL AND LEN(@Filter) > 0   
		SET @SQL_01 = 'INSERT INTO #tmpSample3 SELECT * FROM #tmpSample2 WHERE ' + @Filter   
		ELSE   
		SET @SQL_01 = 'INSERT INTO #tmpSample3 SELECT * FROM #tmpSample2 '  

		print @SQL_01

		EXEC (@SQL_01)   

  
		EXECUTE spx_Crosstab   
		'SELECT SampleWorkflow, Link , SampleRequestTradeID, StyleID, TradePartnerID , TradePartnerVendorID, TradePartnerName,   
		VendorName,CustomField1,DevelopmentNo,CustomField5,CustomField6,CustomField7,CustomField9,StyleType,StyleCategory,SizeRange,CustomField13,WashType,CustomField10,CustomField11,CustomField12,Designer,StyleNo,Description, SizeClass, Colorway, TechPack, StyleSet, SetNo, Season, Year,SeasonYearID    
		FROM #tmpSample3',  
		NULL,  
		NULL,  
		'SampleWorkflow',  
		'Link',  
		'MAX'  
		  
		  
		DROP TABLE #tmpSample1  
		DROP TABLE #tmpSample2  
		DROP TABLE #tmpSample3  
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES              ('DB_Version', '4.1.0000', '02487', GetDate())
GO

SET NOCOUNT Off
GO
