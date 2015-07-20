SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRMeasurementsPOMAlternates_INSERT')
   DROP PROCEDURE spx_pGRMeasurementsPOMAlternates_INSERT
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



Create PROCEDURE [dbo].[spx_pGRMeasurementsPOMAlternates_INSERT]
(@POMAlternatesId  uniqueidentifier,
@AlternatesId uniqueidentifier,
@POMId uniqueidentifier
)

AS 
Declare @POMCode nvarchar(50)
Declare @POMDesc nvarchar(200)
Declare @POMSort int
Declare @AlternatesSort int
Declare @AlternatesCode nvarchar(10)
Declare @AlternatesDesc nvarchar(100)
Declare @How2MeasName nvarchar(200)
Declare @How2MeasText nvarchar(4000)
Declare @Imageid nvarchar(50)


select @POMCode=POMCode, @POMDesc=POMDesc, @POMSort=Sort,  
@How2MeasName=How2MeasName, @How2MeasText=How2MeasText, @Imageid=Imageid
from pGRMeasurementsPOM where POMId=@POMId

select @AlternatesCode=AlternatesCode, @AlternatesDesc=AlternatesDesc, @AlternatesSort=Sort from pGRMeasurementsAlternates where
AlternatesId=@AlternatesId

INSERT INTO pGRMeasurementsPOMAlternates
    (POMAlternatesId, POMId, AlternatesId, POMCode, POMDesc, POMSort, AlternatesCode, AlternatesDesc, AlternateSort,
    islinked, Active, How2MeasName, How2MeasText, Imageid)
VALUES (@POMAlternatesId, @POMId, @AlternatesId, @POMCode, @POMDesc, @POMSort, @AlternatesCode, 
@AlternatesDesc, @AlternatesSort, 1, 1, @How2MeasName, @How2MeasText, @Imageid)


 GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02093'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02093', GetDate())
	END
GO