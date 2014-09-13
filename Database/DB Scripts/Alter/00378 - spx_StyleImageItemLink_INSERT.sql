ALTER PROCEDURE [dbo].[spx_StyleImageItemLink_INSERT]
(
@StyleID uniqueidentifier,
@NewStyleID uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
AS

SET NOCOUNT ON

DECLARE @Row_Count int
DECLARE @Row_Loop int
DECLARE @StyleImageItemMasterID uniqueidentifier
DECLARE @StyleImageItemID uniqueidentifier
DECLARE @NewStyleImageItemMasterID uniqueidentifier

BEGIN
CREATE TABLE [dbo].[#tempStyleImageItem] (
	[RecID] int IDENTITY(1,1)  NOT NULL,
	[StyleImageItemID]  uniqueidentifier ROWGUIDCOL  NOT NULL ,
	[StyleImageItemMasterID] [uniqueidentifier],
	[StyleImageItemGroupID] [uniqueidentifier],
	[WorkflowID] [uniqueidentifier],
	[StyleID] [uniqueidentifier],
	[StyleSet] [int],
	[ImageID] [uniqueidentifier],
	[ImageVersion] [int],
	[Sort] [nvarchar] (5),
	[CUser] [nvarchar] (200),
	[CDate] [datetime],
	[MUser] [nvarchar] (200),
	[MDate] [datetime]
)
END

BEGIN
CREATE TABLE [dbo].[#tempCopyStyleImageItem] (
	[RecID] int IDENTITY(1,1)  NOT NULL,
	[StyleImageItemID]  uniqueidentifier ROWGUIDCOL  NOT NULL ,
	[StyleImageItemMasterID] [uniqueidentifier],
	[StyleImageItemGroupID] [uniqueidentifier],
	[WorkflowID] [uniqueidentifier],
	[StyleID] [uniqueidentifier],
	[StyleSet] [int],
	[ImageID] [uniqueidentifier],
	[ImageVersion] [int],
	[Sort] [nvarchar] (5),
	[CUser] [nvarchar] (200),
	[CDate] [datetime],
	[MUser] [nvarchar] (200),
	[MDate] [datetime]
)
END


BEGIN
	INSERT INTO dbo.#tempStyleImageItem
	(StyleImageItemID, StyleImageItemMasterID, StyleImageItemGroupID, WorkflowID, StyleID, StyleSet, ImageID, ImageVersion, Sort, CUser, CDate, MUser, MDate)
	SELECT StyleImageItemID, StyleImageItemMasterID, StyleImageItemGroupID, WorkflowID, StyleID, StyleSet, ImageID, ImageVersion, Sort, CUser, CDate, MUser, MDate
	FROM dbo.pStyleImageItem
	WHERE (StyleID = @StyleID) AND (StyleImageLinked = 1)
END

BEGIN

	SET @Row_Loop = 1
	SET @Row_Count = (SELECT COUNT(*) FROM dbo.#tempStyleImageItem)
	
	WHILE @Row_Loop <= @Row_Count 
	
		BEGIN
		
		SELECT @StyleImageItemMasterID = StyleImageItemMasterID, @StyleImageItemID = StyleImageItemID FROM #tempStyleImageItem WHERE RecID = @Row_Loop
			
			IF @StyleImageItemMasterID IS NULL
			BEGIN
				SET @NewStyleImageItemMasterID = newid()
				UPDATE pStyleImageItem SET StyleImageItemMasterID = @NewStyleImageItemMasterID WHERE StyleImageItemID = @StyleImageItemID
			END	
		
		SET @Row_Loop = @Row_Loop + 1
			
		END
END


--BEGIN
	--INSERT INTO dbo.#tempCopyStyleImageItem
	--(StyleImageItemID, StyleImageItemMasterID, StyleImageItemGroupID, WorkflowID, StyleID, StyleSet, ImageID, ImageVersion, Sort, CUser, CDate, MUser, MDate)
	--SELECT newid() AS StyleImageItemID, StyleImageItemMasterID, StyleImageItemGroupID, WorkflowID, @NewStyleID, StyleSet, ImageID, ImageVersion, Sort, @CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate
	--FROM dbo.pStyleImageItem
	--WHERE (StyleID = @StyleID)
--END


---INSERT HERE
BEGIN
	INSERT INTO dbo.pStyleImageItem
	(StyleImageItemID, StyleImageItemMasterID, StyleImageItemGroupID, WorkflowID, StyleID, StyleSet, ImageID, ImageVersion, Sort, CUser, CDate, MUser, MDate, StyleImageLinked)
	SELECT newid() AS StyleImageItemID, StyleImageItemMasterID, StyleImageItemGroupID, WorkflowID, @NewStyleID, StyleSet, ImageID, ImageVersion, Sort, @CreatedBy AS CUser, @CreatedDate AS CDate, @CreatedBy AS MUser, @CreatedDate AS MDate, 1
	FROM dbo.pStyleImageItem
	WHERE (StyleID = @StyleID) AND (StyleImageLinked = 1)
END


--SELECT * FROM dbo.pStyleImageItem WHERE (StyleID = @StyleID)
--SELECT * FROM #tempStyleImageItem
--SELECT * FROM #tempCopyStyleImageItem
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '378', GetDate())
GO