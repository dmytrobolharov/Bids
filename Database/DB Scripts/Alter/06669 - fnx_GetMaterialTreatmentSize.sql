/****** Object:  UserDefinedFunction [dbo].[fnx_GetMaterialTreatmentSize]    Script Date: 11/22/2013 14:02:27 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetMaterialTreatmentSize]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetMaterialTreatmentSize]
GO

/****** Object:  UserDefinedFunction [dbo].[fnx_GetMaterialTreatmentSize]    Script Date: 11/22/2013 14:02:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE FUNCTION [dbo].[fnx_GetMaterialTreatmentSize]
(
    @MaterialDimension UNIQUEIDENTIFIER
)

RETURNS NVARCHAR(255)

AS

BEGIN
	DECLARE @MaterialTreatmentSize NVARCHAR (255)
	
	SELECT @MaterialTreatmentSize=MaterialSize
	FROM pMaterialSize WHERE MaterialSizeId=@MaterialDimension
	
	RETURN @MaterialTreatmentSize
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06669', GetDate())
GO