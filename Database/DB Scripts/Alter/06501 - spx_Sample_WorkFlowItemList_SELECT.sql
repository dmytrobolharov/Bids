IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sample_WorkFlowItemList_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sample_WorkFlowItemList_SELECT]
GO

   
CREATE PROCEDURE [dbo].[spx_Sample_WorkFlowItemList_SELECT]   
(@WorkflowId uniqueidentifier,  
 @StyleID uniqueidentifier,  
 @StyleSet int  ,
 @ReportSampleRequestSubmitGroup  NVARCHAR(5),
 @SeasonYearID uniqueidentifier = NULL
)  
AS  

CREATE TABLE  #Temp (   
Rec_Id int identity(1,1)  , 
WorkFlowItemID  uniqueidentifier ,   
WorkflowID  uniqueidentifier ,  
WorkflowItemTypeId uniqueidentifier,
ItemTypeLabel nvarchar(200),
StyleID uniqueidentifier,
WorkFlowItemName nvarchar(200),
Sort nvarchar(4),
CUser nvarchar(200),
CDate datetime,
MUser nvarchar(200),
MDate datetime
) 


DECLARE @IsSeasonal INT = (SELECT IsSeasonal FROM Mapping WHERE Map = @WorkflowID),
		@StyleSeasonYearID uniqueidentifier = (SELECT StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID)


IF @WorkflowId = '00000000-0000-0000-0000-000000000000'
  BEGIN
	INSERT INTO #Temp (  
	WorkFlowItemID   ,   
	WorkflowID   ,  
	WorkflowItemTypeId ,
	ItemTypeLabel ,
	StyleID ,
	WorkFlowItemName ,
	Sort ,
	CUser ,
	CDate ,
	MUser ,
	MDate 
	) 
	SELECT 	ReportSampleRequestSubmitFolderID  as WorkFlowItemID, '00000000-0000-0000-0000-000000000000' as WorkflowId, ReportSampleRequestSubmitFolderID  as WorkflowItemTypeId,
	ReportSampleRequestSubmitName AS  ItemTypeLabel, @StyleID AS StyleID, ReportSampleRequestSubmitName AS WorkFlowItemName, ReportSampleRequestSubmitSort AS Sort, CUser, CDate, MUser, MDate
	FROM 
	rReportSampleRequestSubmitFolder 
	WHERE
	ReportSampleRequestSubmitGroup = @ReportSampleRequestSubmitGroup AND Active = '1'
	ORDER BY ReportSampleRequestSubmitSort 
 END    
ELSE
BEGIN
	INSERT INTO #Temp (  
	WorkFlowItemID   ,   
	WorkflowID   ,  
	WorkflowItemTypeId ,
	ItemTypeLabel ,
	StyleID ,
	WorkFlowItemName ,
	Sort ,
	CUser ,
	CDate ,
	MUser ,
	MDate 
	) 
	 SELECT wfi.WorkFlowItemID, wfi.WorkflowID, wfi.WorkflowItemTypeId, wfit.ItemTypeLabel, wfi.StyleID, wfi.WorkFlowItemName, wfi.Sort, wfi.CUser, wfi.CDate, wfi.MUser, wfi.MDate  
	 FROM pWorkFlowItem wfi INNER JOIN  
	 pWorkFlowItemType wfit ON wfit.WorkflowItemTypeId = wfi.WorkflowItemTypeId 
	 WHERE wfi.StyleID = @StyleID  
	 AND wfi.StyleSet = @StyleSet  
	 AND wfi.WorkflowId = @WorkflowId  
	 AND (@IsSeasonal = 1 AND wfi.StyleSeasonYearID = @StyleSeasonYearID OR @IsSeasonal = 0)
	 Order By wfi.Sort  
 END
 
   
 SELECT  * FROM #Temp   
 DROP TABLE #Temp      
 
 
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06501', GetDate())
GO
