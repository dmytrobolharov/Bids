/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowBOMAccess]    Script Date: 08/28/2014 16:21:16 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowBOMAccess]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowBOMAccess]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowBOMAccess]    Script Date: 08/28/2014 16:21:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestWorkflowBOMAccess]  (
@TeamID UNIQUEIDENTIFIER  ,
@SampleRequestTradeID UNIQUEIDENTIFIER 
)

AS


DECLARE @Total INT 
DECLARE @Current INT 
DECLARE @AccessRoleID INT 
DECLARE @AccessDelete INT 
DECLARE @AccessModify INT 
DECLARE @RestrictionDelete  INT 
DECLARE @RestrictionModify  INT 


CREATE TABLE   #tempAccess  (
	rowid INT IDENTITY ( 1,1)  ,
	AccessRoleID INT,	
	AccessDelete INT ,  
	AccessModify INT
)

DECLARE @StyleTypeID AS INT
SELECT @StyleTypeID = sh.StyleType 
FROM pSampleRequestBOMTrade srt INNER JOIN pStyleHeader sh ON sh.StyleID = srt.StyleID
WHERE srt.SampleRequestTradeID = @SampleRequestTradeID

INSERT INTO  #tempAccess (AccessRoleId , AccessDelete , AccessModify ) 
SELECT PermissionRoleId , PermissionDelete , PermissionModify
FROM fnx_Permissions_GetIntProductType_WorkflowPermissions(@TeamID, 5, @StyleTypeID)
WHERE WorkflowID IN ( 
	select SampleWorkflowGUID from dbo.pSampleRequestSubmitBOM WITH (NOLOCK)
	INNER JOIN dbo.pSampleWorkflow on pSampleRequestSubmitBOM.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
	where SampleRequestTradeID = @SampleRequestTradeID
)
GROUP BY PermissionRoleId , PermissionDelete , PermissionModify


SELECT @Total   = COUNT (*) FROM  #tempAccess  
SET @Current = 1


SET @RestrictionDelete   = 0 
SET @RestrictionModify  = 0 


WHILE @Current <= @Total 
BEGIN
	
	SELECT @AccessRoleID=AccessRoleID, @AccessDelete=AccessDelete , @AccessModify = AccessModify 
	FROM #tempAccess
	WHERE  rowid = @Current 


	IF @AccessRoleID = 0 
	BEGIN
		SET @RestrictionDelete  = @RestrictionDelete  + 1 	
		SET @RestrictionModify = @RestrictionModify  + 1 
	END
	ELSE 
	BEGIN 
		IF @AccessRoleID = 2 
		BEGIN
			IF @AccessDelete = 0
				SET @RestrictionDelete  = @RestrictionDelete  + 1 
			
			IF @AccessModify = 0 
				SET @RestrictionModify = @RestrictionModify  + 1 
		END 
	END 

	SET @Current = @Current + 1 
END 


SELECT  @RestrictionDelete AS RestrictionDelete, @RestrictionModify as RestrictionModify


DROP TABLE #tempAccess


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '09007', GetDate())
GO