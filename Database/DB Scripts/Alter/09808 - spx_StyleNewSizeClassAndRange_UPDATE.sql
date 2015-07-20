IF OBJECT_ID(N'[dbo].[spx_StyleNewSizeClassAndRange_UPDATE]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleNewSizeClassAndRange_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleNewSizeClassAndRange_UPDATE] (
@StyleID UNIQUEIDENTIFIER, 
@NewStyleID UNIQUEIDENTIFIER 

)
AS
BEGIN
	
	UPDATE trg
	SET trg.SizeRange = src.SizeRange,
	    trg.SizeRangeId = src.SizeRangeId,
		trg.SizeClass = src.SizeClass,
		trg.SizeClassId = src.SizeClassId
	FROM pStyleHeader trg
	LEFT JOIN pStyleHeader src ON src.StyleID = @StyleId
	WHERE trg.StyleID = @NewStyleID
	
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09808', GetDate())
GO
