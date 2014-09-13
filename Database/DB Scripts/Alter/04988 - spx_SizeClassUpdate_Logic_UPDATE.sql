/****** Object:  StoredProcedure [dbo].[spx_SizeClassUpdate_Logic_UPDATE]    Script Date: 02/06/2013 16:32:00 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SizeClassUpdate_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SizeClassUpdate_Logic_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SizeClassUpdate_Logic_UPDATE]    Script Date: 02/06/2013 16:32:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SizeClassUpdate_Logic_UPDATE]
	@SizeClassID UNIQUEIDENTIFIER
AS
BEGIN

	SET NOCOUNT ON;
	
	-- Updating 'Class Range' control panel
	UPDATE pGRMeasurementsClassRange 
	SET SizeClass = sc.Custom
	FROM pGRMeasurementsClassRange cr INNER JOIN
	pSizeClass sc ON sc.CustomID = cr.SizeClassId
	WHERE SizeClassId = @SizeClassID
	
	-- Updating 'Measurement Templates' control panel
	UPDATE pGRMeasurementsPOMTemplate
	SET SizeClass = sc.Custom,
	ClassRange = sc.Custom + ' (' + SizeRange + ')'
	FROM pGRMeasurementsPOMTemplate pt INNER JOIN
	pSizeClass sc ON pt.SizeClassId = sc.CustomID
	WHERE SizeClassId = @SizeClassID

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04988', GetDate())
GO
