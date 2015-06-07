IF OBJECT_ID(N'[dbo].[spx_BodyClassReconvert_Check_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_BodyClassReconvert_Check_SELECT]
GO

CREATE PROCEDURE  [dbo].[spx_BodyClassReconvert_Check_SELECT] (
@BodyID UNIQUEIDENTIFIER  , 
@BodySet INT ,
@SizeClass NVARCHAR(400)
)
AS 

DECLARE @POMTempID UNIQUEIDENTIFIER
DECLARE @SizeClassTemp NVARCHAR(400)

SELECT @POMTempID = (
CASE @BodySet 
WHEN 1 THEN POMTempID1
WHEN 2 THEN POMTempID2
WHEN 3 THEN POMTempID3
WHEN 4 THEN POMTempID4
END )
FROM pBody WHERE BodyID = @BodyID

SELECT @SizeClassTemp = SizeClass from pPOMTemplate 
WHERE POMTempGroupID = ( SELECT POMTempGroupID  FROM pPOMTemplate  WHERE  POMTempID = @POMTempID  ) 
AND LTRIM(RTRIM(LOWER(SizeClass))) = LTRIM(RTRIM(LOWER(@SizeClass)))


IF @SizeClassTemp IS NULL 
	SELECT 0 AS Res
ELSE 
	SELECT 1 AS Res

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09513', GetDate())
GO
