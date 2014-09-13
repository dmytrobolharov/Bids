IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ColorFolderChange_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ColorFolderChange_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_ColorFolderChange_INSERT](
	  @ActiveID UNIQUEIDENTIFIER
	, @ChangeID UNIQUEIDENTIFIER
	, @WorkflowID UNIQUEIDENTIFIER
	, @ColorFolderID UNIQUEIDENTIFIER
	, @ColorFolderStatus BIT
	, @ColorFolderChangeNotifyTo NVARCHAR(4000)
	, @ColorFolderChangeType NVARCHAR(100)
	, @ColorFolderChangeDescription NVARCHAR(4000)
	, @ChangeBy NVARCHAR(200)
	, @ChangeDate DATETIME)
AS 

	DECLARE @NoOfChange INT

	SELECT @NoOfChange = COUNT(*)
	FROM pColorFolderChange WITH (NOLOCK)
	WHERE ColorFolderChangeID = @ChangeID

	IF @NoOfChange = 0
		INSERT INTO pColorFolderChange (
			  ActiveID
			, ColorFolderChangeID
			, ColorFolderWorkflowID
			, ColorFolderID
			, ColorFolderChangeNotifyTo
			, ColorFolderChangeType
			, ColorFolderChangeDescription
			, ColorFolderChangeBy
			, ColorFolderChangeDate
			, ColorFolderStatus)
		VALUES (
			  @ActiveID
			, @ChangeID
			, @WorkflowID
			, @ColorFolderID
			, @ColorFolderChangeNotifyTo
			, @ColorFolderChangeType
			, @ColorFolderChangeDescription
			, @ChangeBy
			, @ChangeDate
			, @ColorFolderStatus)		
	ELSE
		UPDATE pColorFolderChange
		SET ActiveID = @ActiveID
			, ColorFolderStatus = @ColorFolderStatus
			, ColorFolderChangeNotifyTo = @ColorFolderChangeNotifyTo
			, ColorFolderChangeType = @ColorFolderChangeType
			, ColorFolderChangeDescription = @ColorFolderChangeDescription
			, ColorFolderChangeBy = @ChangeBy
			, ColorFolderChangeDate = @ChangeDate
		WHERE ColorFolderChangeID = @ChangeID

	



GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08497', GetDate())
GO
