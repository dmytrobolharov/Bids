SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[spx_ConstructionDetail_Unlink]
(@ConstructionDetailID UNIQUEIDENTIFIER,
@StyleID UNIQUEIDENTIFIER,
@WorkflowID UNIQUEIDENTIFIER,
@StyleSet int,
@MUser NVARCHAR(200),
@MDate DATETIME )
AS

DECLARE @WorkflowItemID UNIQUEIDENTIFIER
DECLARE @WorkFlowItemTypeId UNIQUEIDENTIFIER
DECLARE @Detail as nvarchar(4000)
DECLARE @OrigOperationSN as varchar(50)
DECLARE @Level1Desc as nvarchar(100)
DECLARE @Level2Desc as nvarchar(100)
DECLARE @Level3Desc as nvarchar(100)
DECLARE @Level1ID as varchar(50)
DECLARE @Level2ID as varchar(50)
DECLARE @Level3ID as varchar(50)
DECLARE @AuxField1 as nvarchar(100)
DECLARE @AuxField2 as nvarchar(100)
DECLARE @AuxField3 as nvarchar(100)
DECLARE @AuxField4 as nvarchar(100)
DECLARE @AuxField5 as nvarchar(100)
DECLARE @ImageID as varchar(50)
DECLARE @nCount as int
DECLARE @LinkDetail as int 
DECLARE @LinkUserDefined1 as int 
DECLARE @LinkUserDefined2 as int
DECLARE @LinkUserDefined3 as int 
DECLARE @LinkUserDefined4 as int 
DECLARE @LinkUserDefined5 as int

BEGIN
	SELECT @Level1ID = Level1ID, @Level2ID = Level2ID, @Level3ID = Level3ID, @WorkflowItemID = WorkflowItemID FROM pConPageDetail WITH (NOLOCK) WHERE ConstructionDetailID = @ConstructionDetailID
	
	select @nCount = count(*) from vwx_Control_CDFeature_SELECT WITH (NOLOCK) WHERE  Level1ID = @Level1ID  AND  Level2ID = @Level2ID  AND  Level3ID = @Level3ID
	IF  (@nCount <> 0)
	BEGIN
		SELECT @WorkFlowItemTypeId = WorkFlowItemTypeId FROM pWorkFlowItem WHERE WorkFlowItemId = @WorkFlowItemId

		SELECT @LinkDetail = LinkDetail,
				@LinkUserDefined1 = LinkUserDefined1,
				@LinkUserDefined2 = LinkUserDefined2,
				@LinkUserDefined3 = LinkUserDefined3,
				@LinkUserDefined4 = LinkUserDefined4,
				@LinkUserDefined5 = LinkUserDefined5
		FROM pConPageSettings WITH (NOLOCK) WHERE WorkFlowItemTypeId = @WorkFlowItemTypeId

		SELECT 
		   @Detail = CASE
			   WHEN @LinkDetail = 1 THEN Detail
			   ELSE (SELECT Detail FROM pConPageDetail WHERE ConstructionDetailID = @ConstructionDetailID)
			   END,

				@OrigOperationSN = SerialNumber, @Level1Desc = Level1Desc, @Level2Desc = Level2Desc, @Level3Desc = Level3Desc, 
		   @AuxField1 = CASE
			   WHEN @LinkUserDefined1 = 1 THEN AuxField1
			   ELSE (SELECT AuxField1 FROM pConPageDetail WHERE ConstructionDetailID = @ConstructionDetailID)
			   END,		
		   @AuxField2 = CASE
			   WHEN @LinkUserDefined2 = 1 THEN AuxField2
			   ELSE (SELECT AuxField2 FROM pConPageDetail WHERE ConstructionDetailID = @ConstructionDetailID)
			   END,
		   @AuxField3 = CASE
			   WHEN @LinkUserDefined3 = 1 THEN AuxField3
			   ELSE (SELECT AuxField3 FROM pConPageDetail WHERE ConstructionDetailID = @ConstructionDetailID)
			   END,
		   @AuxField4 = CASE
			   WHEN @LinkUserDefined4 = 1 THEN AuxField4
			   ELSE (SELECT AuxField4 FROM pConPageDetail WHERE ConstructionDetailID = @ConstructionDetailID)
			   END,
		   @AuxField5 = CASE
			   WHEN @LinkUserDefined5 = 1 THEN AuxField5
			   ELSE (SELECT AuxField5 FROM pConPageDetail WHERE ConstructionDetailID = @ConstructionDetailID)
			   END,
		 
		@ImageID = ImageID
		FROM vwx_Control_CDFeature_SELECT WITH (NOLOCK) WHERE  Level1ID = @Level1ID  AND  Level2ID = @Level2ID  AND  Level3ID = @Level3ID

		Update pConPageDetail SET Linked = 0, Detail = @Detail, OrigOperationSN = @OrigOperationSN, 
		Level1Desc = @Level1Desc, Level2Desc = @Level2Desc, Level3Desc = @Level3Desc,
		Level1ID = @Level1ID, Level2ID = @Level2ID,  Level3ID = @Level3ID, 
		AuxField1 = @AuxField1, AuxField2 = @AuxField2, AuxField3 = @AuxField3, AuxField4 = @AuxField4, AuxField5 = @AuxField5,
		ImageID = @ImageID, MUser = @MUser, MDate = @MDate Where ConstructionDetailID = @ConstructionDetailID
	END

	IF @@Error <> 0 GOTO Error

	RETURN
Error:
	ROLLBACK TRANSACTION
END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '788', GetDate())

GO