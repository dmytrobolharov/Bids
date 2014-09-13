IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnx_Num2Frac_KeepNegative]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnx_Num2Frac_KeepNegative]
GO

CREATE FUNCTION [dbo].[fnx_Num2Frac_KeepNegative] (@X float) 	 
RETURNS varchar(20)
AS
BEGIN
	DECLARE @Fixed AS float
	DECLARE @Temp AS varchar(10)
	DECLARE @Num2Frac AS varchar(20)
	DECLARE @Fraction AS float
	DECLARE @Negative INT
	
	/*Check the sign.*/
	IF(@X < 0)
		BEGIN
			SET @Negative = 1		
		END
	ELSE
		BEGIN
			SET @Negative = 0
		END

		
	If (@X = 0) 
	    SET @Num2Frac = '0' 
	
	SET @X = ABS(@X)
	SET @Fixed = FLOOR(@X)
	
	SET @Fraction = @X - @Fixed
		
	IF (@Fraction >= 0.939)
	BEGIN
		SET @Fixed = @Fixed + 1
		SET @Fraction = 0.0
	END
		
	SET @Temp = CASE  
	        	WHEN (@Fraction BETWEEN 0.060 AND 0.123) THEN '1/16'
	        	WHEN (@Fraction BETWEEN 0.124 AND 0.164) THEN '1/8'
			WHEN (@Fraction BETWEEN 0.165 AND 0.185) THEN '1/6'
			WHEN (@Fraction BETWEEN 0.186 AND 0.198) THEN '3/16'
			WHEN (@Fraction BETWEEN 0.199 AND 0.245) THEN '1/5'
			WHEN (@Fraction BETWEEN 0.246 AND 0.259) THEN '1/4'
			WHEN (@Fraction BETWEEN 0.260 AND 0.329) THEN '5/16'
			WHEN (@Fraction BETWEEN 0.330 AND 0.369) THEN '1/3'
			WHEN (@Fraction BETWEEN 0.370 AND 0.395) THEN '3/8'
			WHEN (@Fraction BETWEEN 0.396 AND 0.436) THEN '2/5'
			WHEN (@Fraction BETWEEN 0.437 AND 0.495) THEN '7/16'
			WHEN (@Fraction BETWEEN 0.496 AND 0.550) THEN '1/2'
			WHEN (@Fraction BETWEEN 0.551 AND 0.580) THEN '9/16'
			WHEN (@Fraction BETWEEN 0.581 AND 0.619) THEN '3/5'
			WHEN (@Fraction BETWEEN 0.620 AND 0.650) THEN '5/8'
			WHEN (@Fraction BETWEEN 0.651 AND 0.686) THEN '2/3'
			WHEN (@Fraction BETWEEN 0.687 AND 0.730) THEN '11/16'
			WHEN (@Fraction BETWEEN 0.731 AND 0.780) THEN '3/4'
			WHEN (@Fraction BETWEEN 0.781 AND 0.810) THEN '4/5'
			WHEN (@Fraction BETWEEN 0.811 AND 0.860) THEN '13/16'	
			WHEN (@Fraction BETWEEN 0.861 AND 0.876) THEN '7/8'	
			WHEN (@Fraction BETWEEN 0.877 AND 0.938) THEN '15/16'	
			ELSE ''			
		   END
	
	
	IF (@Temp <> '') AND (@Fixed > 0) 
		BEGIN				
			SET @Num2Frac = CAST(@Fixed AS varchar(5)) + ' ' + @Temp 
		END
	ELSE 
		IF (@Temp <> '') AND (@Fixed = 0) 
			BEGIN
				SET @Num2Frac = @Temp
			END	
	ELSE
		IF (@Temp = '')
			BEGIN
				SET @Num2Frac = CAST(@Fixed AS varchar(20))
			END
	
	
	/*Add minus sign for negative value.*/
	IF(@Negative = 1)
		BEGIN
			SET @Num2Frac = '-' + @Num2Frac
		END
	
	
	RETURN @Num2Frac 

END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01191', GetDate())
GO