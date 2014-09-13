SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_pGRMeasurementsPOM_INSERT')
   DROP PROCEDURE spx_pGRMeasurementsPOM_INSERT
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[spx_pGRMeasurementsPOM_INSERT]
(@POMId  uniqueidentifier,
@POMCode nvarchar (50),
@POMDesc nvarchar (200),
@How2MeasText nvarchar (4000),
@Sort int,
@MUser nvarchar (200),
@MDate datetime,
@CUser nvarchar(200),
@CDate datetime)
AS 

BEGIN

INSERT INTO pGRMeasurementsPOM
    (POMId, POMCode, POMDesc, How2MeasText, Sort, Active, MUser, MDate,CUser,CDate)
VALUES (@POMId, @POMCode, @POMDesc,  @How2MeasText, @Sort, 1, @MUser,@MDate,@CUser,@CDate)

END

 GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02114'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02114', GetDate())
	END
GO