IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_GetUnitOfMeasurement]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_GetUnitOfMeasurement]
GO

CREATE FUNCTION [dbo].[fnx_GetUnitOfMeasurement]
(
    @UOMValue NVARCHAR(50)
)

RETURNS NVARCHAR(255)

AS

BEGIN
    DECLARE @UOM NVARCHAR (255)

	SELECT @UOM=UOM FROM UOM WHERE UOMValue=@UOMValue

    RETURN @UOM
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06094', GetDate())
GO
