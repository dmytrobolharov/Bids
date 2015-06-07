IF OBJECT_ID(N'[dbo].[spx_StyleSpecReconvert_UPDATE]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StyleSpecReconvert_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_StyleSpecReconvert_UPDATE]( 
@StyleID  uniqueidentifier,
@StyleSet int
)

AS

DECLARE @Variation INT
DECLARE @StyleDevelopmentID nvarchar(40)


SELECT @StyleDevelopmentID = a.DevelopmentID , @Variation = b.Variation
FROM pStyleHeader a INNER JOIN pStyleDevelopmentItem b ON  a.StyleID  = b.StyleID 
WHERE a.StyleID = @StyleID


DECLARE @ConvSizeClass nvarchar(400)
DECLARE @ConvStyleID nvarchar(40)


SELECT @ConvSizeClass  = Custom 
FROM pSizeClass 
WHERE SpecConversion = 1 AND Custom IN (
	SELECT COALESCE(sc.Custom, a.SizeClass) 
	FROM pStyleHeader a 
	INNER JOIN pStyleDevelopmentItem b ON a.StyleID = b.StyleID
	LEFT JOIN pSizeClass sc ON sc.CustomID = a.SizeClassId
	WHERE a.DevelopmentID = @StyleDevelopmentID AND b.Variation  = @Variation 
)


SELECT @ConvStyleId = a.StyleID 
FROM pStyleHeader a 
INNER JOIN pStyleDevelopmentItem b ON a.StyleID = b.StyleID 
LEFT JOIN pSizeClass sc ON sc.CustomID = a.SizeClassId
WHERE a.DevelopmentID = @StyleDevelopmentID AND 
      COALESCE(sc.Custom, a.SizeClass) = @ConvSizeClass AND 
	  b.Variation  = @Variation 



UPDATE pStyleSpec SET pStyleSpec.Spec = pStyleSpec_1.Spec 
	FROM pStyleSpec INNER JOIN
	pStyleSpec pStyleSpec_1 ON pStyleSpec.POM = pStyleSpec_1.POM AND pStyleSpec.StyleSet = pStyleSpec_1.StyleSet
WHERE (pStyleSpec.StyleID = @StyleId AND pStyleSpec.StyleSet = @StyleSet) AND (pStyleSpec_1.StyleID = @ConvStyleId) AND (pStyleSpec_1.POMTempID IS NOT NULL)


DECLARE @POMTempID UNIQUEIDENTIFIER

SELECT @POMTempID = (
CASE @StyleSet 
WHEN 1 THEN POMTempID1
WHEN 2 THEN POMTempID2
WHEN 3 THEN POMTempID3
WHEN 4 THEN POMTempID4
END )
FROM pStyleHeader WHERE StyleID = @StyleID 


IF @POMTempID IS NOT NULL 
BEGIN 

	UPDATE pStyleSpec SET 
		pStyleSpec.Spec = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pStyleSpec.InitialSpec = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pStyleSpec.Proto0 = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pStyleSpec.Proto1 = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pStyleSpec.Proto2 = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pStyleSpec.Proto3 = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pStyleSpec.Proto4 = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pStyleSpec.Proto5 = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pStyleSpec.Proto6 = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pStyleSpec.Proto7 = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pStyleSpec.Proto8 = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pStyleSpec.Proto9 = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pStyleSpec.Proto10 = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pStyleSpec.Proto11 = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pStyleSpec.Proto12 = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pStyleSpec.Proto13 = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pStyleSpec.Proto14 = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pStyleSpec.Proto15 = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pStyleSpec.Proto16 = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pStyleSpec.Proto17 = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pStyleSpec.Proto18 = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pStyleSpec.Proto19 = (ISNULL(pStyleSpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0))
	FROM   pStyleSpec INNER JOIN pPOMTemplateItem ON pStyleSpec.POM = pPOMTemplateItem.POM
	WHERE  pStyleSpec.StyleID = @StyleId  
	AND pStyleSpec.StyleSet = @StyleSet 
	AND pPOMTemplateItem.POMTempID = @POMTempID


END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09830', GetDate())
GO
