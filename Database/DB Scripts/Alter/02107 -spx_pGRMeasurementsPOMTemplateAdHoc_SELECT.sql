SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRMeasurementsPOMTemplateAdHoc_SELECT')
   DROP PROCEDURE spx_pGRMeasurementsPOMTemplateAdHoc_SELECT
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_pGRMeasurementsPOMTemplateAdHoc_SELECT]
(@POMTempID uniqueidentifier,
@PomCodeDefault varchar(5))
AS 

/*
SELECT COUNT(*)
FROM  pPOMTemplateItem WITH (NOLOCK)
WHERE (POMTempID = @POMTempID) AND (POM LIKE @PomCodeDefault + '%')
*/


DECLARE @POM as nvarchar ( 15 )
DECLARE @CodeLen  INT 
DECLARE @Count as nvarchar ( 15 )



SELECT TOP 1  @POM = POMCode  
FROM  pGRMeasurementsPOMTemplateItem WITH (NOLOCK)
WHERE (POMTempID = @POMTempID) AND (POMCode LIKE @PomCodeDefault + '%')
ORDER BY POMCode DESC


IF  @PomCodeDefault  IS NULL 
	SET @CodeLen = 0
else 
	SET @CodeLen  = LEN ( @PomCodeDefault ) 

IF @POM IS NULL 
	SET @Count = '0'
ELSE
BEGIN 
	SET @Count  = SUBSTRING ( @POM ,  @CodeLen + 1  , LEN ( @POM ) - @CodeLen  )
END 


SELECT  @Count

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02107'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02107', GetDate())
	END
GO