
/****** Object:  StoredProcedure [dbo].[spx_StyleMeas_Grade_UPDATE]    Script Date: 02/21/2011 15:50:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_StyleMeas_Grade_UPDATE') 
DROP PROCEDURE spx_StyleMeas_Grade_UPDATE
GO
Create PROCEDURE [dbo].[spx_StyleMeas_Grade_UPDATE]
(
    @AMLMeasHdrId UNIQUEIDENTIFIER,
    @AMLMeasPOMId UNIQUEIDENTIFIER,
    @pomrow int,
    @SizeCol int,
    @Incr numeric(18,4),
    @ModifiedBy nvarchar(204),
    @ModifiedDate datetime
)
AS

BEGIN 

    UPDATE pAMLMeasIGC 
    SET Incr = @Incr,
    MUser=@ModifiedBy,
    MDate=@ModifiedDate
    WHERE AMLMeasHdrId = @AMLMeasHdrId
    AND AMLMeasPOMId = @AMLMeasPOMId
    AND pom_row = @pomrow
    AND SizeCol = @SizeCol

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01176', GetDate())