IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleTechPackStatusChange_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleTechPackStatusChange_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_StyleTechPackStatusChange_INSERT](
	  @ActiveID UNIQUEIDENTIFIER
	, @ChangeID UNIQUEIDENTIFIER
	, @WorkflowID UNIQUEIDENTIFIER
	, @StyleID UNIQUEIDENTIFIER
	, @SeasonYearID UNIQUEIDENTIFIER
	, @StyleTechPackStatus BIT
	, @StyleTechPackChangeNotifyTo NVARCHAR(4000)
	, @StyleTechPackChangeType NVARCHAR(100)
	, @StyleTechPackChangeDescription NVARCHAR(4000)
	, @ChangeBy NVARCHAR(200)
	, @ChangeDate DATETIME)
AS 

	DECLARE @NoOfChange INT,
			@StyleSeasonYearID UNIQUEIDENTIFIER = (
				SELECT StyleSeasonYearID FROM pStyleSeasonYear 
				WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID)

	SELECT @NoOfChange = COUNT(*)
	FROM pStyleTechPackChange WITH (NOLOCK)
	WHERE StyleTechPackChangeID = @ChangeID

	IF @NoOfChange = 0
		INSERT INTO pStyleTechPackChange (
			  ActiveID
			, StyleTechPackChangeID
			, StyleTechPackWorkflowID
			, StyleID
			, StyleSeasonYearID
			, StyleTechPackChangeNotifyTo
			, StyleTechPackChangeType
			, StyleTechPackChangeDescription
			, StyleTechPackChangeBy
			, StyleTechPackChangeDate
			, StyleTechPackStatus)
		VALUES (
			  @ActiveID
			, @ChangeID
			, @WorkflowID
			, @StyleID
			, @StyleSeasonYearID
			, @StyleTechPackChangeNotifyTo
			, @StyleTechPackChangeType
			, @StyleTechPackChangeDescription
			, @ChangeBy
			, @ChangeDate
			, @StyleTechPackStatus)		
	ELSE
		UPDATE pStyleTechPackChange
		SET ActiveID = @ActiveID
			, StyleTechPackStatus = @StyleTechPackStatus
			, StyleTechPackChangeNotifyTo = @StyleTechPackChangeNotifyTo
			, StyleTechPackChangeType = @StyleTechPackChangeType
			, StyleTechPackChangeDescription = @StyleTechPackChangeDescription
			, StyleTechPackChangeBy = @ChangeBy
			, StyleTechPackChangeDate = @ChangeDate
		WHERE StyleTechPackChangeID = @ChangeID

	




GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08509', GetDate())
GO
