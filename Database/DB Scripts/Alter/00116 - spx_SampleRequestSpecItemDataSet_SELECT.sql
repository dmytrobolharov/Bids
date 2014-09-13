IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestSpecItemDataSet_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestSpecItemDataSet_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequestSpecItemDataSet_SELECT] (  
@StyleID uniqueidentifier,   
@StyleSet int,  
@SampleRequestTradeID uniqueidentifier,  
@SampleRequestWorkflowID uniqueidentifier,  
@SampleWorkflowID varchar (50) ,  
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
a.SampleRequestSpecID, a.Ask, (a.Spec - a.Ask) AS Var, a.Vendor, a.Rev, a.Final  
FROM         pSampleRequestSpecItem a WITH (NOLOCK) LEFT OUTER JOIN  
                      pPOMLibrary b WITH (NOLOCK) ON a.POM = b.POM AND a.PointMeasur = b.PointMeasur  
WHERE a.StyleID = @StyleID  
AND  a.StyleSet = @StyleSet  
AND a.SampleRequestTradeID = @SampleRequestTradeID  
AND a.SampleRequestWorkflowID = @SampleRequestWorkflowID  
AND a.SampleWorkflowID = @SampleWorkflowID  
AND a.Submit = @Submit  
ORDER BY a.Sort, a.POM, a.PointMeasur   


GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '116', GetDate())

GO

