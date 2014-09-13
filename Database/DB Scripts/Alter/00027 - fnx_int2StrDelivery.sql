
CREATE FUNCTION [dbo].[fnx_int2StrDelivery] (@X int) 	 
RETURNS varchar(10)
AS
BEGIN	
	DECLARE @Int2StrDelivery AS varchar(10)	
		
	If (@X = 1) 
	    SET @Int2StrDelivery = 'Yes' 
	Else
		SET @Int2StrDelivery = 'No'	
	
	RETURN @Int2StrDelivery 

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '027', GetDate())

GO

