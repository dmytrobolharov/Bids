IF OBJECT_ID(N'[dbo].[spx_StyleSizeClassRangeVariation_UPDATE]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleSizeClassRangeVariation_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleSizeClassRangeVariation_UPDATE]
(
@StyleID uniqueidentifier,
@NewStyleID uniqueidentifier,
@CreatedBy nvarchar(200),
@CreatedDate datetime
)
AS

BEGIN

	UPDATE trg
	SET trg.SizeRange = src.SizeRange,
	    trg.SizeRangeId = src.SizeRangeId,
		trg.SizeClass = src.SizeClass,
		trg.SizeClassId = src.SizeClassId,
		trg.MUser = @CreatedBy, 
		trg.MDate = @CreatedDate
	FROM pStyleHeader trg
	LEFT JOIN pStyleHeader src ON src.StyleID = @StyleId
	WHERE trg.StyleID = @NewStyleID

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09824', GetDate())
GO
