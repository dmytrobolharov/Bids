
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(select * from information_Schema.routines WHERE SPECIFIC_NAME = N'spx_ConstructionDetail_Unlink')
DROP PROCEDURE spx_ConstructionDetail_Unlink
GO

CREATE PROCEDURE [dbo].[spx_ConstructionDetail_Unlink]
(@ConstructionDetailID UNIQUEIDENTIFIER,
@StyleID UNIQUEIDENTIFIER,
@WorkflowID UNIQUEIDENTIFIER,
@StyleSet int,
@MUser NVARCHAR(200),
@MDate DATETIME )
AS


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

BEGIN
	SELECT @Level1ID = Level1ID, @Level2ID = Level2ID, @Level3ID = Level3ID FROM pConPageDetail WITH (NOLOCK) WHERE ConstructionDetailID = @ConstructionDetailID
	SELECT @Detail = Detail, @OrigOperationSN = SerialNumber, @Level1Desc = Level1Desc, @Level2Desc = Level2Desc, @Level3Desc = Level3Desc, 
	@AuxField1 = AuxField1, @AuxField2 = AuxField2, @AuxField3 = AuxField3, @AuxField4 = AuxField4, @AuxField5 = AuxField5, @ImageID = ImageID
	FROM vwx_Control_CDFeature_SELECT WITH (NOLOCK) WHERE  Level1ID = @Level1ID  AND  Level2ID = @Level2ID  AND  Level3ID = @Level3ID
	select @nCount = count(*) from vwx_Control_CDFeature_SELECT WITH (NOLOCK) WHERE  Level1ID = @Level1ID  AND  Level2ID = @Level2ID  AND  Level3ID = @Level3ID
	IF  (@nCount <> 0)
	BEGIN
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
VALUES ('DB_Version', '4.0.0000', '567', GetDate())
GO