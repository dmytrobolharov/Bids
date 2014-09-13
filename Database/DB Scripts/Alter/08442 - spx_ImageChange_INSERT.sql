IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ImageChange_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ImageChange_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_ImageChange_INSERT](
	  @ActiveID UNIQUEIDENTIFIER
	, @ChangeID UNIQUEIDENTIFIER
	, @WorkflowID UNIQUEIDENTIFIER
	, @ImageID UNIQUEIDENTIFIER
	, @ImageStatus BIT
	, @ImageChangeNotifyTo NVARCHAR(4000)
	, @ImageChangeType NVARCHAR(100)
	, @ImageChangeDescription NVARCHAR(4000)
	, @ChangeBy NVARCHAR(200)
	, @ChangeDate DATETIME)
AS 

	DECLARE @NoOfChange INT

	SELECT @NoOfChange = COUNT(*)
	FROM pImageChange WITH (NOLOCK)
	WHERE ImageChangeID = @ChangeID

	IF @NoOfChange = 0
		INSERT INTO pImageChange (
			  ActiveID
			, ImageChangeID
			, ImageWorkflowTemplateItemID
			, ImageID
			, ImageChangeNotifyTo
			, ImageChangeType
			, ImageChangeDescription
			, ImageChangeBy
			, ImageChangeDate
			, ImageStatus)
		VALUES (
			  @ActiveID
			, @ChangeID
			, @WorkflowID
			, @ImageID
			, @ImageChangeNotifyTo
			, @ImageChangeType
			, @ImageChangeDescription
			, @ChangeBy
			, @ChangeDate
			, @ImageStatus)		
	ELSE
		UPDATE pImageChange
		SET ActiveID = @ActiveID
			, ImageStatus = @ImageStatus
			, ImageChangeNotifyTo = @ImageChangeNotifyTo
			, ImageChangeType = @ImageChangeType
			, ImageChangeDescription = @ImageChangeDescription
			, ImageChangeBy = @ChangeBy
			, ImageChangeDate = @ChangeDate
		WHERE ImageChangeID = @ChangeID

	


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08442', GetDate())
GO
