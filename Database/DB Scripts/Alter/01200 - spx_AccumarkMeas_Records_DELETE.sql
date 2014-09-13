IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_AccumarkMeas_Records_DELETE') 
DROP PROCEDURE spx_AccumarkMeas_Records_DELETE
GO
/****** Object:  StoredProcedure [dbo].[spx_AccumarkMeas_Records_DELETE]    Script Date: 02/25/2011 17:06:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

Create  PROCEDURE [dbo].[spx_AccumarkMeas_Records_DELETE]
 @AMLMeasHdrId UniqueIdentifier
AS
IF ((SELECT COUNT(*) FROM pAccumarkMeasurement where AMLMeasHdrId = @AMLMeasHdrId )>0 )
BEGIN
DELETE FROM pAccumarkMeasurement WHERE AMLMeasHdrId = @AMLMeasHdrId 
END
IF ((SELECT COUNT(*) FROM pAccumarkMeasMap where AMLMeasHdrId = @AMLMeasHdrId )>0 )
BEGIN
DELETE FROM pAccumarkMeasMap WHERE AMLMeasHdrId = @AMLMeasHdrId 
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01200', GetDate())
