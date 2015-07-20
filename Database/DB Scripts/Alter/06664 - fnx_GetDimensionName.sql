/****** Object:  UserDefinedFunction [dbo].[fnx_GetDimensionName]    Script Date: 11/22/2013 12:22:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetDimensionName]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetDimensionName]
GO

/****** Object:  UserDefinedFunction [dbo].[fnx_GetDimensionName]    Script Date: 11/22/2013 12:22:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE FUNCTION [dbo].[fnx_GetDimensionName]
(
    @DimensionTypeID UNIQUEIDENTIFIER
)

RETURNS NVARCHAR(255)

AS

BEGIN
    DECLARE @DimensionName NVARCHAR (255)
    
	SELECT @DimensionName=DimtypeName FROM pStyleBOMDimType WHERE DimTypeID=@DimensionTypeID
	
    RETURN @DimensionName
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06664', GetDate())
GO
