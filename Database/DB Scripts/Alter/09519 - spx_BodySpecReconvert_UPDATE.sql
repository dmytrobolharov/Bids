IF OBJECT_ID(N'[dbo].[spx_BodySpecReconvert_UPDATE]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_BodySpecReconvert_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_BodySpecReconvert_UPDATE]( 
@BodyID  uniqueidentifier,
@BodySet int
)

AS


DECLARE @DevelopmentID UNIQUEIDENTIFIER 

SELECT @DevelopmentID = a.DevelopmentID 
FROM pBody a 
WHERE a.BodyID = @BodyID


DECLARE @ConvSizeClass nvarchar(400)
DECLARE @ConvBodyID nvarchar(40)


SELECT @ConvSizeClass  = Custom 
FROM pSizeClass 
WHERE SpecConversion = 1 AND Custom IN (
	SELECT a.SizeClass
	FROM pBody a
	WHERE a.DevelopmentID = @DevelopmentID 
)


SELECT  @ConvBodyId = a.BodyID 
FROM pBody  a
WHERE a.DevelopmentID = @DevelopmentID 
AND a.SizeClass = @ConvSizeClass




UPDATE pBodySpec SET pBodySpec.Spec = pBodySpec_1.Spec 
FROM pBodySpec INNER JOIN
pBodySpec pBodySpec_1 ON pBodySpec.POM = pBodySpec_1.POM AND pBodySpec.BodySet = pBodySpec_1.BodySet
WHERE (pBodySpec.BodyID = @BodyId AND pBodySpec.BodySet = @BodySet) 
AND (pBodySpec_1.BodyID = @ConvBodyId) 
AND (pBodySpec_1.POMTempID IS NOT NULL)


DECLARE @POMTempID UNIQUEIDENTIFIER

SELECT @POMTempID = (
CASE @BodySet 
WHEN 1 THEN POMTempID1
WHEN 2 THEN POMTempID2
WHEN 3 THEN POMTempID3
WHEN 4 THEN POMTempID4
END )
FROM pBody WHERE BodyID = @BodyID 


IF @POMTempID IS NOT NULL 
BEGIN 

	UPDATE pBodySpec SET 
		pBodySpec.Spec = (ISNULL(pBodySpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pBodySpec.InitialSpec = (ISNULL(pBodySpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pBodySpec.Proto0 = (ISNULL(pBodySpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pBodySpec.Proto1 = (ISNULL(pBodySpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pBodySpec.Proto2 = (ISNULL(pBodySpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pBodySpec.Proto3 = (ISNULL(pBodySpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pBodySpec.Proto4 = (ISNULL(pBodySpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pBodySpec.Proto5 = (ISNULL(pBodySpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pBodySpec.Proto6 = (ISNULL(pBodySpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pBodySpec.Proto7 = (ISNULL(pBodySpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pBodySpec.Proto8 = (ISNULL(pBodySpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pBodySpec.Proto9 = (ISNULL(pBodySpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pBodySpec.Proto10 = (ISNULL(pBodySpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pBodySpec.Proto11 = (ISNULL(pBodySpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pBodySpec.Proto12 = (ISNULL(pBodySpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pBodySpec.Proto13 = (ISNULL(pBodySpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pBodySpec.Proto14 = (ISNULL(pBodySpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pBodySpec.Proto15 = (ISNULL(pBodySpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pBodySpec.Proto16 = (ISNULL(pBodySpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pBodySpec.Proto17 = (ISNULL(pBodySpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pBodySpec.Proto18 = (ISNULL(pBodySpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0)),
		pBodySpec.Proto19 = (ISNULL(pBodySpec.Spec,0) + ISNULL(pPOMTemplateItem.Conv,0))
	FROM   pBodySpec INNER JOIN pPOMTemplateItem ON pBodySpec.POM = pPOMTemplateItem.POM
	WHERE  pBodySpec.BodyID = @BodyId  
	AND pBodySpec.BodySet = @BodySet 
	AND pPOMTemplateItem.POMTempID = @POMTempID


END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09519', GetDate())
GO
