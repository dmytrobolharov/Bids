SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRMeasurementsAlternates_INSERT')
   DROP PROCEDURE spx_pGRMeasurementsAlternates_INSERT
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[spx_pGRMeasurementsAlternates_INSERT]
(@AlternatesId  uniqueidentifier,
@AlternatesCode nvarchar (4),
@AlternatesDesc nvarchar (100),
@CUser nvarchar(200),
@CDate datetime)
AS 

INSERT INTO pGRMeasurementsAlternates
    (AlternatesId, AlternatesCode, AlternatesDesc, Active, MUser,MDate,CUser,CDate)
VALUES (@AlternatesId, @AlternatesCode, @AlternatesDesc, 1, @CUser,@CDate,@CUser,@CDate)


 GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02086'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02086', GetDate())
	END
GO