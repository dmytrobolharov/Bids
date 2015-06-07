IF OBJECT_ID(N'[dbo].[spx_BodyPOMTemplate_Set_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_BodyPOMTemplate_Set_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_BodyPOMTemplate_Set_SELECT] (
@BodyID AS UNIQUEIDENTIFIER 
)
AS 

DECLARE @SizeRange nvarchar(200)
DECLARE @DevelopmentID UNIQUEIDENTIFIER 
DECLARE @POMTempID1 UNIQUEIDENTIFIER, @POMTempID2 UNIQUEIDENTIFIER, @POMTempID3 UNIQUEIDENTIFIER,@POMTempID4 UNIQUEIDENTIFIER 
DECLARE @PC1 NVARCHAR(50), @PC2 NVARCHAR(50), @PC3 NVARCHAR(50), @PC4 NVARCHAR(50)
DECLARE @BodySet int 
DECLARE @Variation INT 


SELECT @BodySet=BodySet, @SizeRange = SizeRange, @DevelopmentID=DevelopmentID
FROM pBody where BodyID = @BodyID


SELECT @POMTempID1 = POMTempID1 , @POMTempID2 = POMTempID2, @POMTempID3 = POMTempID3, @POMTempID4 = POMTempID4 
FROM pBody WHERE BodyID= @BodyID


CREATE TABLE  #tmpPOMTemplate(
BodySet INT , 
BodySetName NVARCHAR (50) ,
POMTempGroupID UNIQUEIDENTIFIER 
)

INSERT  INTO #tmpPOMTemplate ( BodySet , BodySetName , POMTempGroupID  )
SELECT T1.BodySet, T2.BodySetName , T2.POMTempGroupID FROM  (
SELECT 1 AS BodySet 
union 
SELECT 2 AS BodySet 
union 
SELECT 3 AS BodySet 
union 
SELECT 4 AS BodySet 
)  AS T1 
LEFT OUTER JOIN
(
SELECT POMTempGroupID, 1 AS BodySet, @PC1 AS BodySetName 
FROM pPOMTemplate WHERE POMTempID =  @POMTempID1  
union 
SELECT POMTempGroupID, 2 AS BodySet, @PC2 AS BodySetName 
FROM pPOMTemplate WHERE POMTempID =  @POMTempID2
union 
SELECT POMTempGroupID, 3 AS BodySet, @PC3 AS BodySetName 
FROM pPOMTemplate WHERE POMTempID =  @POMTempID3
union 
SELECT POMTempGroupID, 4 AS BodySet, @PC4 AS BodySetName 
FROM pPOMTemplate WHERE POMTempID =  @POMTempID4
) AS T2
ON T1.BodySet = T2.BodySet
WHERE T1.BodySet <= @BodySet



SELECT DISTINCT b.SizeClass 
FROM #tmpPOMTemplate a INNER JOIN pPOMTemplate b ON a.POMTempGroupID = b.POMTempGroupID
WHERE b.SizeClass NOT IN  (
	SELECT a.SizeClass 
	FROM pBody a 
	WHERE a.DevelopmentID = @DevelopmentID
) 
ORDER BY b.SizeClass 

SELECT * FROM #tmpPOMTemplate

select a.BodySet, b.POMTempID , b.SizeClass, b.SizeRange 
FROM #tmpPOMTemplate a INNER JOIN pPOMTemplate b ON a.POMTempGroupID = b.POMTempGroupID
WHERE b.SizeClass NOT IN  (
	SELECT a.SizeClass 
	FROM pBody a
	WHERE a.DevelopmentID = @DevelopmentID
) 
ORDER BY a.BodySet


DROP TABLE #tmpPOMTemplate

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09517', GetDate())
GO
