/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowAccess]    Script Date: 06/17/2014 16:01:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowAccess]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowAccess]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowAccess]    Script Date: 06/17/2014 16:01:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestWorkflowAccess]  (
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
SELECT StyleTypeID = sh.StyleType 
FROM pSampleRequestTrade srt INNER JOIN pStyleHeader sh ON sh.StyleID = srt.StyleID
WHERE srt.SampleRequestTradeID = @SampleRequestTradeID

INSERT INTO  #tempAccess (AccessRoleId , AccessDelete , AccessModify ) 
SELECT PermissionRoleId , PermissionDelete , PermissionModify
FROM fnx_Permissions_GetIntProductType_WorkflowPermissions(@TeamID, 5, @StyleTypeID)
WHERE WorkflowID IN ( 
	select SampleWorkflowGUID from dbo.pSampleRequestSubmit
	INNER JOIN dbo.pSampleWorkflow on pSampleRequestSubmit.SampleWorkflowID = pSampleWorkflow.SampleWorkflowID
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
VALUES ('DB_Version', '0.5.0000', '08031', GetDate())
GO
