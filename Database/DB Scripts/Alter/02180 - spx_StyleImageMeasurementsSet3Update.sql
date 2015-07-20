IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleImageMeasurementsSet3Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleImageMeasurementsSet3Update]
GO
/****** Object:  StoredProcedure [dbo].[spx_StyleImageMeasurementsSet3Update]    Script Date: 11/15/2011 14:19:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[spx_StyleImageMeasurementsSet3Update](
 @StyleId varchar(50),
 @ImageVersionSet3 int,
 @ImageSet3Id varchar(50),
 @MeasuremnetId varchar(50))
as
begin
IF (Select count(distinct MeasurementID) from pStyleImageMeasurements where MeasurementID = @MeasuremnetId) = 0
Insert into pStyleImageMeasurements (MeasurementID,StyleID,ImageSet3Id,ImageVersionSet3) values (@MeasuremnetId,@StyleId,@ImageSet3Id,@ImageVersionSet3)
else
Update pStyleImageMeasurements set ImageSet3Id = @ImageSet3Id, ImageVersionSet3 = @ImageVersionSet3  where (MeasurementID = @MeasuremnetId and StyleID = @StyleId)
end

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02180'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02180', GetDate())
	END
GO
