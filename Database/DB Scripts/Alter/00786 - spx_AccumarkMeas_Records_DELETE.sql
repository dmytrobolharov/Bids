SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (select * from sysobjects where id = object_id('spx_spx_AccumarkMeas_Records_DELETE') and sysstat & 0xf = 4)
    drop procedure spx_spx_AccumarkMeas_Records_DELETE
GO
CREATE  PROCEDURE [dbo].[spx_AccumarkMeas_Records_DELETE]
 @AMLMeasHdrId UniqueIdentifier
AS
IF ((SELECT COUNT(*) FROM pAccumarkMeasurement where AMLMeasHdrId = @AMLMeasHdrId )>0 )
BEGIN
DELETE FROM pAccumarkMeasurement
WHERE AMLMeasHdrId = @AMLMeasHdrId 
END
---------------------------------------------------------------
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '786', GetDate())
GO