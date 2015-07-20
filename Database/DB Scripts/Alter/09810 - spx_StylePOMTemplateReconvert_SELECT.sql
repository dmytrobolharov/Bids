IF OBJECT_ID(N'[dbo].[spx_StylePOMTemplateReconvert_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StylePOMTemplateReconvert_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StylePOMTemplateReconvert_SELECT] (
@StyleID UNIQUEIDENTIFIER 
) 
AS
BEGIN

	DECLARE @Variation INT 
	DECLARE @StyleDevelopmentID UNIQUEIDENTIFIER 

	SELECT @Variation = b.Variation , @StyleDevelopmentID = StyleDevelopmentID
	FROM pStyleHeader a INNER JOIN pStyleDevelopmentItem b ON a.StyleId = b.StyleID
	where a.StyleID = @StyleID


	SELECT b.CustomID AS SizeClassId, b.Custom AS SizeClass, b.SpecConversion 
	FROM pStyleHeader a 
	INNER JOIN pSizeClass b ON (a.SizeClassId IS NOT NULL AND b.CustomID = a.SizeClassId) OR 
							   (a.SizeClassId IS NULL AND b.Custom = a.SizeClass)
	WHERE a.StyleID IN  ( 
		SELECT StyleID FROM pStyleDevelopmentItem WHERE StyleDevelopmentId  = @StyleDevelopmentID
		AND Variation = @Variation
	)

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09810', GetDate())
GO
