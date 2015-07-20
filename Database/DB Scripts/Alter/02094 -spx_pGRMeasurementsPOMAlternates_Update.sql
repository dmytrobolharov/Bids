SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRMeasurementsPOMAlternates_Update')
   DROP PROCEDURE spx_pGRMeasurementsPOMAlternates_Update
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



Create PROCEDURE [dbo].[spx_pGRMeasurementsPOMAlternates_Update]
(@POMId uniqueidentifier,
@MUser nvarchar(100),
@MDate datetime)


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


select @POMCode=POMCode, @POMDesc=POMDesc, @POMSort=Sort, @How2MeasName=How2MeasName, 
@How2MeasText=How2MeasText, @Imageid=Imageid 
from pGRMeasurementsPOM where
POMId=@POMId

UPDATE pGRMeasurementsPOMAlternates
  SET	POMCode = @POMCode,
		POMDesc = @POMDesc,		
		POMSort = @POMSort,	
		How2MeasName=@How2MeasName, How2MeasText=@How2MeasText, Imageid=@Imageid,			
		MUser = @MUser, 
		MDate = @MDate	
WHERE POMId=@POMId 

 GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02094'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02094', GetDate())
	END
GO