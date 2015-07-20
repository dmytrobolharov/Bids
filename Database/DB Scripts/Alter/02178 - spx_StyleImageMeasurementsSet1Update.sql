IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleImageMeasurementsSet1Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleImageMeasurementsSet1Update]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleImageMeasurementsSet1Update]    Script Date: 11/15/2011 14:19:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[spx_StyleImageMeasurementsSet1Update](
 @StyleId varchar(50),
 @ImageVersionSet1 int,
 @ImageSet1Id varchar(50),
 @MeasuremnetId varchar(50))
as
begin
IF (Select count(distinct MeasurementID) from pStyleImageMeasurements where MeasurementID = @MeasuremnetId) = 0
Insert into pStyleImageMeasurements (MeasurementID,StyleID,ImageSet1Id,ImageVersionSet1) values (@MeasuremnetId,@StyleId,@ImageSet1Id,@ImageVersionSet1)
else
Update pStyleImageMeasurements set ImageSet1Id = @ImageSet1Id, ImageVersionSet1 = @ImageVersionSet1  where (MeasurementID = @MeasuremnetId and StyleID = @StyleId)
end

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02178'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02178', GetDate())
	END
GO
