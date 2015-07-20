IF OBJECT_ID(N'[dbo].[spx_SampleRequestSpecItemDataSet_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_SampleRequestSpecItemDataSet_SELECT]
GO

CREATE  PROCEDURE [dbo].[spx_SampleRequestSpecItemDataSet_SELECT] (
@StyleID uniqueidentifier, 
@StyleSet int,
@SampleRequestTradeID uniqueidentifier,
@SampleRequestWorkflowID uniqueidentifier,
@SampleWorkflowID nvarchar (50) ,
@Submit int,
@nHowToMeasure int = 0 
)
AS 



SELECT  a.POM, a.PointMeasur, a.POMTempID, b.POMLibraryID, a.SpecID, a.StyleID, a.POMTempItemID,  a.ModelSpecID, a.ModelID, 
a.StyleSet, a.Critical,   a.TOL, a.TOLN, a.Spec, a.Proto0, 
a.Proto1, a.Proto2, a.Proto3, a.Proto4, a.Proto5, a.Proto6, a.Proto7, a.Proto8, a.Proto9, a.Proto10, a.Proto11, a.Grade0, a.Grade1, a.Grade2, 
a.Grade3, a.Grade4, a.Grade5, a.Grade6, 
a.Grade7, a.Grade8, a.Grade9, a.Grade10, a.Grade11, a.Size0, a.Size1, a.Size2, a.Size3, a.Size4, a.Size5, a.Size6, a.Size7, a.Size8, 
a.Size9, a.Size10, a.Size11, a.CDate, a.CUser, 
a.MDate, a.MUser, a.Change, a.Sort, b.HowToMeasurText, b.HowToMeasurImage ,
a.SampleRequestSpecID, a.Ask, a.Var, a.Vendor, a.Rev, a.Final,
CASE a.POMTempID
	WHEN NULL THEN ''
	ELSE '<img src="../System/Icons/icon_link.gif" style="border-width:0px;" />'
END  AS Linked,
CASE a.Critical
	WHEN 1 THEN '<img src="../System/Icons/icon_warning.gif" style="border-width:0px;" />'
	ELSE ''
END AS IsCritical,
CASE 
	WHEN b.POMLibraryID IS NOT NULL THEN '<img src="../System/Icons/icon_howto.gif" style="border-width:0px;" />'
	ELSE ''
END AS HowTo,

'<input Onclick="javascript:var w=window.open( ''../Control/Control_POMLibrary_HowTo.aspx?PLID=' + CAST(b.POMLibraryID AS NVARCHAR(40))+ 
'&PTID='+ CAST(a.POMTempItemID AS NVARCHAR(40))  + ''', 
''POMSubmit'', ''menubar=0,toolbar=0,status=0,scrollbars=1,location=0,resizable=1,top=1,left=1,height=600,width=800''); w.focus(); 
return false;" type="image" src="' + dbo.fnx_GetStreamingPOMImageSmallPath(b.POMLibraryID, '75') + '" style="border-width:0px;" />' as HowToImage

	
FROM pSampleRequestSpecItem a WITH (NOLOCK) 
LEFT OUTER JOIN pPOMLibrary b WITH (NOLOCK) ON a.POM = b.POM AND a.PointMeasur = b.PointMeasur
WHERE a.StyleID = @StyleID
AND  a.StyleSet = @StyleSet
AND a.SampleRequestTradeID = @SampleRequestTradeID
AND a.SampleRequestWorkflowID = @SampleRequestWorkflowID
AND a.SampleWorkflowID = @SampleWorkflowID
AND a.Submit = @Submit
ORDER BY a.Sort, a.POM, a.PointMeasur



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10377', GetUTCDate())
GO
