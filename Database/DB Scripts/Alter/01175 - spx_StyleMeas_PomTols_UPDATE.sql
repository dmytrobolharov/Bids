/****** Object:  StoredProcedure [dbo].[spx_StyleMeas_PomTols_UPDATE]    Script Date: 02/21/2011 15:50:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_StyleMeas_PomTols_UPDATE') 
DROP PROCEDURE spx_StyleMeas_PomTols_UPDATE
GO
Create PROCEDURE [dbo].[spx_StyleMeas_PomTols_UPDATE]
(
    @AMLMeasHdrId UNIQUEIDENTIFIER,
    @AMLMeasPOMId UNIQUEIDENTIFIER,
    @pomrow int,
    @Refcode nvarchar(12),
    @Description nvarchar(204),
    @TolPlus numeric(18,4),
    @TolMinus numeric(18,4) , 
    @ModifiedBy nvarchar(204),
    @ModifiedDate datetime
)
AS

BEGIN 

    UPDATE pAMLMeaspom 
    SET RefCode = @Refcode,
    [Description]=@Description,
    TolPlus=@TolPlus,
    TolMinus=@TolMinus,
    MUser=@ModifiedBy,
    MDate=@ModifiedDate
    WHERE AMLMeasHdrId = @AMLMeasHdrId
    AND AMLMeasPOMId = @AMLMeasPOMId
    AND pom_row = @pomrow
   

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01175', GetDate())
