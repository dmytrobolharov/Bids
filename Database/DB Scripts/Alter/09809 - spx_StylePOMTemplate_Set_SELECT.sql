IF OBJECT_ID(N'[dbo].[spx_StylePOMTemplate_Set_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_StylePOMTemplate_Set_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StylePOMTemplate_Set_SELECT] (
@StyleID AS UNIQUEIDENTIFIER 
)
AS 

DECLARE @DevelopmentID UNIQUEIDENTIFIER 
DECLARE @POMTempID1 UNIQUEIDENTIFIER, @POMTempID2 UNIQUEIDENTIFIER, @POMTempID3 UNIQUEIDENTIFIER,@POMTempID4 UNIQUEIDENTIFIER 
DECLARE @PC1 NVARCHAR(50), @PC2 NVARCHAR(50), @PC3 NVARCHAR(50), @PC4 NVARCHAR(50)
DECLARE @StyleSet int 

SELECT @StyleSet  = StyleSet, @DevelopmentID = DevelopmentID
FROM pStyleHeader where StyleID = @StyleID 

SELECT @POMTempID1 = POMTempID1 , @POMTempID2 = POMTempID2, @POMTempID3 = POMTempID3, @POMTempID4 = POMTempID4 FROM pStyleHeader WHERE StyleID = @StyleID 


CREATE TABLE  #tmpPOMTemplate(
StyleSet INT , 
StyleSetName NVARCHAR (50) ,
POMTempGroupID UNIQUEIDENTIFIER 
)

INSERT  INTO #tmpPOMTemplate ( StyleSet , StyleSetName , POMTempGroupID  )
SELECT T1.StyleSet, T2.StyleSetName , T2.POMTempGroupID FROM  (
SELECT 1 AS StyleSet 
union 
SELECT 2 AS StyleSet 
union 
SELECT 3 AS StyleSet 
union 
SELECT 4 AS StyleSet 
)  AS T1 
LEFT OUTER JOIN
(
SELECT POMTempGroupID, 1 AS StyleSet, @PC1 AS StyleSetName 
FROM pPOMTemplate WHERE POMTempID =  @POMTempID1  
union 
SELECT POMTempGroupID, 2 AS StyleSet, @PC2 AS StyleSetName 
FROM pPOMTemplate WHERE POMTempID =  @POMTempID2
union 
SELECT POMTempGroupID, 3 AS StyleSet, @PC3 AS StyleSetName 
FROM pPOMTemplate WHERE POMTempID =  @POMTempID3
union 
SELECT POMTempGroupID, 4 AS StyleSet, @PC4 AS StyleSetName 
FROM pPOMTemplate WHERE POMTempID =  @POMTempID4
) AS T2
ON T1.StyleSet = T2.StyleSet
WHERE T1.StyleSet <= @StyleSet


select DISTINCT b.SizeClass 
FROM #tmpPOMTemplate a INNER JOIN pPOMTemplate b ON a.POMTempGroupID = b.POMTempGroupID
WHERE b.SizeClass NOT IN  (
	SELECT SizeClass FROM pStyleHeader WHERE DevelopmentID = @DevelopmentID
) 
ORDER BY b.SizeClass 


SELECT * FROM #tmpPOMTemplate


select a.StyleSet, b.POMTempID , b.SizeClass, b.SizeRange 
FROM #tmpPOMTemplate a INNER JOIN pPOMTemplate b ON a.POMTempGroupID = b.POMTempGroupID
WHERE b.SizeClass NOT IN  (
	SELECT SizeClass FROM pStyleHeader WHERE DevelopmentID = @DevelopmentID
) 
ORDER BY a.StyleSet


DROP TABLE #tmpPOMTemplate

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09809', GetDate())
GO
