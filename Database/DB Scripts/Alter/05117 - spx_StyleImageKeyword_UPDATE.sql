IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleImageKeyword_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleImageKeyword_UPDATE]
GO


CREATE PROCEDURE [dbo].[spx_StyleImageKeyword_UPDATE]
(
@StyleID UNIQUEIDENTIFIER
)
AS 

DECLARE @ImageID UNIQUEIDENTIFIER
DECLARE @Keywords VARCHAR(4000)
DECLARE @StyleTechPackNo VARCHAR(4000)

SELECT @StyleTechPackNo = StyleNo, @ImageID = DesignSketchID FROM pStyleHeader WHERE StyleID = @StyleID
SELECT @Keywords = ImageKeywords FROM pImage WHERE ImageID = @ImageID

IF NOT EXISTS(SELECT [value] FROM fnx_Split(@Keywords,',') WHERE value = @StyleTechPackNo)
BEGIN
	UPDATE pImage 
	SET ImageKeywords = CASE LEN(ISNULL(ImageKeywords,'')) WHEN 0 THEN '' ELSE ImageKeywords + ',' END + @StyleTechPackNo
	WHERE ImageID = @ImageID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05117', GetDate())
GO
