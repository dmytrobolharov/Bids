IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleImageMeasurementsSet2Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleImageMeasurementsSet2Update]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleImageMeasurementsSet2Update]    Script Date: 11/15/2011 14:19:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[spx_StyleImageMeasurementsSet2Update](
 @StyleId varchar(50),
 @ImageVersionSet2 int,
 @ImageSet2Id varchar(50),
 @MeasuremnetId varchar(50))
as
begin
IF (Select count(distinct MeasurementID) from pStyleImageMeasurements where MeasurementID = @MeasuremnetId) = 0
Insert into pStyleImageMeasurements (MeasurementID,StyleID,ImageSet2Id,ImageVersionSet2) values (@MeasuremnetId,@StyleId,@ImageSet2Id,@ImageVersionSet2)
else
Update pStyleImageMeasurements set ImageSet2Id = @ImageSet2Id, ImageVersionSet2 = @ImageVersionSet2  where (MeasurementID = @MeasuremnetId and StyleID = @StyleId)
end

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02179'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02179', GetDate())
	END
GO
