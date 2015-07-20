IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sample_StyleWorkflowTechPackLogic_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sample_StyleWorkflowTechPackLogic_SELECT]
GO


CREATE  PROCEDURE [dbo].[spx_Sample_StyleWorkflowTechPackLogic_SELECT] (   
@StyleID uniqueidentifier,  
@StyleSet int ,  
@StyleSourcing int = 0 ,
@StyleIDOrg uniqueidentifier,
@SeasonYearID uniqueidentifier = NULL
)  
AS     
DECLARE @StyleWorkflowID as uniqueidentifier    
SELECT @StyleWorkflowID = StyleWorkflowId  FROM pStyleHeader WITH (NOLOCK) where StyleID = @StyleID  
  
DECLARE @StyleSeasonYearID uniqueidentifier = (SELECT StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID)

  
CREATE TABLE  #Temp (   
Rec_Id int identity(1,1)  ,   
WorkflowID  uniqueidentifier ,   
MapDetail nvarchar (200)   
)  

 IF @StyleID = @StyleIDOrg
 BEGIN
	INSERT  INTO #Temp ( WorkflowID,  MapDetail ) 
	SELECT '00000000-0000-0000-0000-000000000000' as WorkflowId,  'Sample Request'  AS MapDetail 
	--SELECT 	ReportSampleRequestSubmitFolderID  as WorkflowId, ReportSampleRequestSubmitName AS MapDetail                 
	--                FROM 
	--                	rReportSampleRequestSubmitFolder 
	--                WHERE
	--                 ReportSampleRequestSubmitGroup = @ReportSampleRequestSubmitGroup AND Active = '1'
	--                  ORDER BY ReportSampleRequestSubmitSort 
END 
  
if @StyleSourcing = 1   
begin  
 INSERT  INTO #Temp ( WorkflowID,  MapDetail )  
 SELECT '10000000-0000-0000-0000-000000000000' as WorkflowId,  'Style Sourcing'  AS MapDetail   
end   
  
INSERT  INTO #Temp ( WorkflowID,  MapDetail )  
SELECT '10000000-0000-0000-0000-000000000001' as WorkflowId,  'Comments'  AS MapDetail   
    
INSERT  INTO #Temp ( WorkflowID,  MapDetail )  
SELECT '10000000-0000-0000-0000-000000000002' as WorkflowId,  'Style Information' AS MapDetail   
    
IF @StyleWorkflowID IS NOT NULL   
BEGIN     
		INSERT INTO #Temp ( WorkflowID, MapDetail )
		SELECT a.WorkflowID, b.MapDetail
		FROM pStyleWorkflow a WITH (NOLOCK) 
			INNER JOIN Mapping b WITH (NOLOCK) ON a.WorkflowID = b.Map 
			INNER JOIN pWorkflowTemplateItem e WITH (NOLOCK) ON e.WorkflowID = b.Map 
		WHERE a.StyleID = @StyleID
			AND a.StyleSet = @StyleSet
			AND e.WorkflowTemplateID = @StyleWorkflowID
			AND (b.IsSeasonal = 1 AND a.StyleSeasonYearID = @StyleSeasonYearID OR b.IsSeasonal = 0)
		ORDER BY e.WorkflowSort, e.WorkflowID
END   
ELSE   
BEGIN     
		INSERT INTO #Temp ( WorkflowID, MapDetail )
		SELECT a.WorkflowID, c.MapDetail
		FROM pStyleWorkflow a WITH (NOLOCK), pWorkflowStatus b WITH (NOLOCK), Mapping c WITH (NOLOCK)
		WHERE a.StyleID = @StyleID
		AND a.StyleSet = @StyleSet
		AND b.WorkflowStatusID = a.WorkStatus
		AND a.WorkflowID = c.Map
		AND (c.IsSeasonal = 1 AND a.StyleSeasonYearID = @StyleSeasonYearID OR c.IsSeasonal = 0)
		ORDER BY a.WorkSort
END  
  
 SELECT  * FROM #Temp   
 DROP TABLE #Temp  
  
set ANSI_NULLS ON  
set QUOTED_IDENTIFIER ON  

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06500', GetDate())
GO
