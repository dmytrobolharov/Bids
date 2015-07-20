IF OBJECT_ID(N'[dbo].[spx_Style_WhereUsedDataTable_SELECT_PIVOT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_Style_WhereUsedDataTable_SELECT_PIVOT]
GO

CREATE  PROCEDURE [dbo].[spx_Style_WhereUsedDataTable_SELECT_PIVOT] (
@StyleID UNIQUEIDENTIFIER,
@PrefLanguage NVARCHAR (50)
)
AS
select * into #temp1 from (
select sh.StyleNo,sh.Description,COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,wl.StyleID,wl.StyleSet,
'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR><TD width=''18''> 
<IMG src=''' + '../System/Icons/'+wfst.WorkflowStatusImage
+ '''  border=0 ALT=''Open''><TD class=''font'' align=center valign=center nowrap>&nbsp; 
<a href=''#'' onclick="javascript:window.open(''../Style/Style_Frame.aspx?SID=' 
	+ CAST(sh.StyleID AS NVARCHAR(50)) + '&SDID=' + CAST(isnull(sh.DevelopmentID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
	+ '&STP=' + CAST(sh.StyleType AS NVARCHAR(10))
	+ '&SN=' + CAST(wl.StyleSet AS NVARCHAR(5))
	+ '&P=' + CAST(wi.WorkFlowID AS NVARCHAR(50)) + '&WFIID=' + CAST(wi.WorkFlowItemID  AS NVARCHAR(50))
	+ '&WFID=' + CAST(wi.WorkflowID AS NVARCHAR(50)) 
	+'&RO=1'
	+ ''',''' + Replace(CAST(wi.WorkFlowItemID AS NVARCHAR(50)), '-', '') + 
	''',''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'');">'
 
+

		CASE UPPER(@PrefLanguage)
					WHEN  'ZH-CHS'  THEN CONVERT ( NVARCHAR(50), wi.WorkDue , 111)
					WHEN  'ZH-CHT'  THEN CONVERT ( NVARCHAR(50), wi.WorkDue , 111)
					WHEN  'DA-DK'  THEN CONVERT ( NVARCHAR(50), wi.WorkDue , 105)
					WHEN  'SV-FI'  THEN CONVERT ( NVARCHAR(50), wi.WorkDue , 111)
					WHEN  'FR-CA'  THEN cast( YEAR(wi.WorkDue) AS nvarchar(4) ) + '-' +cast( MONTH(wi.WorkDue) AS nvarchar(4) ) + '-' +cast( DAY(wi.WorkDue) AS nvarchar(4) )
					WHEN  'DE-DE'  THEN CONVERT ( NVARCHAR(50), wi.WorkDue , 104)
					WHEN  'HI-IN'  THEN CONVERT ( NVARCHAR(50), wi.WorkDue , 105)
					WHEN  'JA-JA'  THEN CONVERT ( NVARCHAR(50), wi.WorkDue , 111)
					WHEN  'KO-KR'  THEN cast( YEAR(wi.WorkDue) AS nvarchar(4) ) + '-' +cast( MONTH(wi.WorkDue) AS nvarchar(4) ) + '-' +cast( DAY(wi.WorkDue) AS nvarchar(4) )
					WHEN  'PL-PL'  THEN cast( YEAR(wi.WorkDue) AS nvarchar(4) ) + '-' +cast( MONTH(wi.WorkDue) AS nvarchar(4) ) + '-' +cast( DAY(wi.WorkDue) AS nvarchar(4) )
					WHEN  'PT-PT'  THEN CONVERT ( NVARCHAR(50), wi.WorkDue , 105)
					WHEN  'RU-RU'  THEN CONVERT ( NVARCHAR(50), wi.WorkDue , 104)
					WHEN  'SV-SE'  THEN cast( YEAR(wi.WorkDue) AS nvarchar(4) ) + '-' +cast( MONTH(wi.WorkDue) AS nvarchar(4) ) + '-' +cast( DAY(wi.WorkDue) AS nvarchar(4) )
					WHEN  'NL-NL'  THEN CONVERT ( NVARCHAR(50), wi.WorkDue , 105)
					WHEN  'TR-TR'  THEN CONVERT ( NVARCHAR(50), wi.WorkDue , 104)
					WHEN  'EN-US'  THEN CONVERT ( NVARCHAR(50), wi.WorkDue , 101)
					ELSE CONVERT ( NVARCHAR(50), wi.WorkDue , 103)
		END			

+ '</a></TD></TR></TABLE>'
 as data,wi.WorkFlowItemName as name from pWorkFlowItem wi 
INNER JOIN pWorkFlowItemLinked wl ON wi.WorkFlowItemID=wl.WorkFlowItemID 
INNER JOIN pStyleHeader sh ON  sh.StyleID = wl.StyleID
INNER JOIN pWorkflowStatus wfst ON wfst.WorkflowStatusID = wi.WorkStatus
LEFT JOIN pSizeClass sc ON sc.Custom = sh.SizeClass
where wi.StyleID=@StyleID and WorkflowID='40000000-0000-0000-0000-000000000050' 
UNION
select sh.StyleNo,sh.Description,COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,wl.StyleID,wl.StyleSet,
'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR><TD width=''18''> 
<IMG src=''' + '../System/Icons/'+wfst.WorkflowStatusImage
+ '''  border=0 ALT=''Open''><TD class=''font'' align=center valign=center nowrap>&nbsp; 
<a href=''#'' onclick="javascript:window.open(''../Style/Style_Redirect.aspx?SID=' 
	+ CAST(sh.StyleID AS NVARCHAR(50)) + '&SDID=' + CAST(isnull(sh.DevelopmentID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
	+ '&STP=' + CAST(sh.StyleType AS NVARCHAR(10))
	+ '&SN=' + CAST(wl.StyleSet AS NVARCHAR(5))
	+ '&P=' + CAST(sw.WorkflowID AS NVARCHAR(50))
	+ '&SWFID=' + CAST(sw.StyleWorkflowID AS NVARCHAR(50))  
	+ '&WFID=' + CAST(sw.WorkflowID AS NVARCHAR(50)) + '&SYID=' + CAST(isnull(sw.StyleSeasonYearID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50))
	+'&RO=1'
	+ ''',''' + Replace(CAST(sw.StyleWorkflowID AS NVARCHAR(50)), '-', '') + 
	''',''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'');">'
 
+

		CASE UPPER(@PrefLanguage)
					WHEN  'ZH-CHS'  THEN CONVERT ( NVARCHAR(50), sw.WorkDue , 111)
					WHEN  'ZH-CHT'  THEN CONVERT ( NVARCHAR(50), sw.WorkDue , 111)
					WHEN  'DA-DK'  THEN CONVERT ( NVARCHAR(50), sw.WorkDue , 105)
					WHEN  'SV-FI'  THEN CONVERT ( NVARCHAR(50), sw.WorkDue , 111)
					WHEN  'FR-CA'  THEN cast( YEAR(sw.WorkDue) AS nvarchar(4) ) + '-' +cast( MONTH(sw.WorkDue) AS nvarchar(4) ) + '-' +cast( DAY(sw.WorkDue) AS nvarchar(4) )
					WHEN  'DE-DE'  THEN CONVERT ( NVARCHAR(50), sw.WorkDue , 104)
					WHEN  'HI-IN'  THEN CONVERT ( NVARCHAR(50), sw.WorkDue , 105)
					WHEN  'JA-JA'  THEN CONVERT ( NVARCHAR(50), sw.WorkDue , 111)
					WHEN  'KO-KR'  THEN cast( YEAR(sw.WorkDue) AS nvarchar(4) ) + '-' +cast( MONTH(sw.WorkDue) AS nvarchar(4) ) + '-' +cast( DAY(sw.WorkDue) AS nvarchar(4) )
					WHEN  'PL-PL'  THEN cast( YEAR(sw.WorkDue) AS nvarchar(4) ) + '-' +cast( MONTH(sw.WorkDue) AS nvarchar(4) ) + '-' +cast( DAY(sw.WorkDue) AS nvarchar(4) )
					WHEN  'PT-PT'  THEN CONVERT ( NVARCHAR(50), sw.WorkDue , 105)
					WHEN  'RU-RU'  THEN CONVERT ( NVARCHAR(50), sw.WorkDue , 104)
					WHEN  'SV-SE'  THEN cast( YEAR(sw.WorkDue) AS nvarchar(4) ) + '-' +cast( MONTH(sw.WorkDue) AS nvarchar(4) ) + '-' +cast( DAY(sw.WorkDue) AS nvarchar(4) )
					WHEN  'NL-NL'  THEN CONVERT ( NVARCHAR(50), sw.WorkDue , 105)
					WHEN  'TR-TR'  THEN CONVERT ( NVARCHAR(50), sw.WorkDue , 104)
					WHEN  'EN-US'  THEN CONVERT ( NVARCHAR(50), sw.WorkDue , 101)
					ELSE CONVERT ( NVARCHAR(50), sw.WorkDue , 103)
		END			

+ '</a></TD></TR></TABLE>'
 as data,'Style Model' as name from pStyleWorkflow sw 
INNER JOIN pWorkFlowItemLinked wl ON sw.StyleWorkflowID=wl.WorkFlowItemID
INNER JOIN pStyleHeader sh ON  sh.StyleID = wl.StyleID
INNER JOIN pWorkflowStatus wfst ON wfst.WorkflowStatusID = sw.WorkStatus
LEFT JOIN pSizeClass sc ON sc.Custom = sh.SizeClass
where sw.StyleID=@StyleID and sw.WorkflowID='40000000-0000-0000-0000-000000000037'
UNION
select sh.StyleNo,sh.Description,COALESCE(sc.Custom, sh.SizeClass) AS SizeClass,wl.StyleID,wl.StyleSet,
'<TABLE cellSpacing=''0'' cellPadding=''0'' width=''100%'' border=''0''><TR><TD width=''18''> 
<IMG src=''' + '../System/Icons/'+wfst.WorkflowStatusImage
+ '''  border=0 ALT=''Open''><TD class=''font'' align=center valign=center nowrap>&nbsp; 
<a href=''#'' onclick="javascript:window.open(''../Style/Style_Redirect.aspx?SID=' 
	+ CAST(sh.StyleID AS NVARCHAR(50)) + '&SDID=' + CAST(isnull(sh.DevelopmentID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
	+ '&STP=' + CAST(sh.StyleType AS NVARCHAR(10))
	+ '&SN=' + CAST(wl.StyleSet AS NVARCHAR(5))
	+ '&P=' + CAST(sw.WorkflowID AS NVARCHAR(50))
	+ '&SWFID=' + CAST(sw.StyleWorkflowID AS NVARCHAR(50))  
	+ '&WFID=' + CAST(sw.WorkflowID AS NVARCHAR(50)) + '&SYID=' + CAST(isnull(sw.StyleSeasonYearID, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50))
	+'&RO=1'
	+ ''',''' + Replace(CAST(sw.StyleWorkflowID AS NVARCHAR(50)), '-', '') + 
	''',''width=1024, height=700, location=yes, menubar=yes, status=yes, toolbar=yes, scrollbars=yes, resizable=yes'');">'
 
+

		CASE UPPER(@PrefLanguage)
					WHEN  'ZH-CHS'  THEN CONVERT ( NVARCHAR(50), sw.WorkDue , 111)
					WHEN  'ZH-CHT'  THEN CONVERT ( NVARCHAR(50), sw.WorkDue , 111)
					WHEN  'DA-DK'  THEN CONVERT ( NVARCHAR(50), sw.WorkDue , 105)
					WHEN  'SV-FI'  THEN CONVERT ( NVARCHAR(50), sw.WorkDue , 111)
					WHEN  'FR-CA'  THEN cast( YEAR(sw.WorkDue) AS nvarchar(4) ) + '-' +cast( MONTH(sw.WorkDue) AS nvarchar(4) ) + '-' +cast( DAY(sw.WorkDue) AS nvarchar(4) )
					WHEN  'DE-DE'  THEN CONVERT ( NVARCHAR(50), sw.WorkDue , 104)
					WHEN  'HI-IN'  THEN CONVERT ( NVARCHAR(50), sw.WorkDue , 105)
					WHEN  'JA-JA'  THEN CONVERT ( NVARCHAR(50), sw.WorkDue , 111)
					WHEN  'KO-KR'  THEN cast( YEAR(sw.WorkDue) AS nvarchar(4) ) + '-' +cast( MONTH(sw.WorkDue) AS nvarchar(4) ) + '-' +cast( DAY(sw.WorkDue) AS nvarchar(4) )
					WHEN  'PL-PL'  THEN cast( YEAR(sw.WorkDue) AS nvarchar(4) ) + '-' +cast( MONTH(sw.WorkDue) AS nvarchar(4) ) + '-' +cast( DAY(sw.WorkDue) AS nvarchar(4) )
					WHEN  'PT-PT'  THEN CONVERT ( NVARCHAR(50), sw.WorkDue , 105)
					WHEN  'RU-RU'  THEN CONVERT ( NVARCHAR(50), sw.WorkDue , 104)
					WHEN  'SV-SE'  THEN cast( YEAR(sw.WorkDue) AS nvarchar(4) ) + '-' +cast( MONTH(sw.WorkDue) AS nvarchar(4) ) + '-' +cast( DAY(sw.WorkDue) AS nvarchar(4) )
					WHEN  'NL-NL'  THEN CONVERT ( NVARCHAR(50), sw.WorkDue , 105)
					WHEN  'TR-TR'  THEN CONVERT ( NVARCHAR(50), sw.WorkDue , 104)
					WHEN  'EN-US'  THEN CONVERT ( NVARCHAR(50), sw.WorkDue , 101)
					ELSE CONVERT ( NVARCHAR(50), sw.WorkDue , 103)
		END			

+ '</a></TD></TR></TABLE>'
 as data,'Style Marker' as name from pStyleWorkflow sw 
INNER JOIN pWorkFlowItemLinked wl ON sw.StyleWorkflowID=wl.WorkFlowItemID  
INNER JOIN pStyleHeader sh ON  sh.StyleID = wl.StyleID
INNER JOIN pWorkflowStatus wfst ON wfst.WorkflowStatusID = sw.WorkStatus
LEFT JOIN pSizeClass sc ON sc.Custom = sh.SizeClass
where sw.StyleID=@StyleID and sw.WorkflowID='40000000-0000-0000-0000-000000000023'
) as tmp 

EXECUTE spx_Crosstab 
'select * from #temp1',
NULL,
NULL,
'name',
'data',
'MAX'

drop table #temp1

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09787', GetDate())
GO
