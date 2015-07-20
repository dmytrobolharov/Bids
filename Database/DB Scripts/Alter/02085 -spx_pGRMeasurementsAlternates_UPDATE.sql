SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRMeasurementsAlternates_UPDATE')
   DROP PROCEDURE spx_pGRMeasurementsAlternates_UPDATE
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_pGRMeasurementsAlternates_UPDATE]
(@AlternatesId uniqueidentifier,
@AlternatesCode nvarchar(10),
@AlternatesDesc nvarchar(100),
@MUser nvarchar(200),
@MDate datetime)
AS 


UPDATE    pGRMeasurementsAlternates
SET  AlternatesCode = @AlternatesCode, AlternatesDesc=@AlternatesDesc,
 MUser = @MUser,  MDate = @MDate
WHERE     AlternatesId = @AlternatesId

 GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02085'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02085', GetDate())
	END
GO