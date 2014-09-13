IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleImageMeasurementsSet4Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleImageMeasurementsSet4Update]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleImageMeasurementsSet4Update]    Script Date: 11/15/2011 14:19:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[spx_StyleImageMeasurementsSet4Update](
 @StyleId varchar(50),
 @ImageVersionSet4 int,
 @ImageSet4Id varchar(50),
 @MeasuremnetId varchar(50))
as
begin
IF (Select count(distinct MeasurementID) from pStyleImageMeasurements where MeasurementID = @MeasuremnetId) = 0
Insert into pStyleImageMeasurements (MeasurementID,StyleID,ImageSet4Id,ImageVersionSet4) values (@MeasuremnetId,@StyleId,@ImageSet4Id,@ImageVersionSet4)
else
Update pStyleImageMeasurements set ImageSet4Id = @ImageSet4Id, ImageVersionSet4 = @ImageVersionSet4  where (MeasurementID = @MeasuremnetId and StyleID = @StyleId)
end

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02181'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02181', GetDate())
	END
GO
