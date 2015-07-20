/****** Object:  UserDefinedFunction [dbo].[fnx_Frac2Num]    Script Date: 01/07/2011 14:56:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[fnx_Frac2Num]
(
            @data nvarchar(50)
)
RETURNS decimal(18,4)
AS

BEGIN

declare @sBeforetheFrac  nvarchar(50)
declare @sAftertheFrac   nvarchar(50)
declare @sBeforetheSpace  nvarchar(50)
declare @sAftertheSpace  nvarchar(50)
declare @FracPos   int
declare @Fracspace   int
declare @intPart   int
declare @fractionPart   int
declare @Frac2Num decimal(18,4)

--return cast(@FracPos as decimal(18,4))


if (@data <> '') 
	begin
		set @data = ltrim(rtrim(@data))
		if (left(@data,1) = '+')
			begin
				set @data = substring(@data, 2, len(@data)-1)
				set @data = ltrim(rtrim(@data))
			end	
		else if (left(@data,1) = '-')	
			begin
				set @data = substring(@data, 2, len(@data)-1)
				set @data = ltrim(rtrim(@data))
				set @data= '-' + @data
			end	
	end
else
	begin
		set @data='0'
	end

set @FracPos = CharIndex ('/',convert(nvarchar(50),@data))

if (@FracPos > 0)
	begin
		set @sBeforetheFrac = substring (convert(nvarchar(50),@data),
		 1,
		 @FracPos-1)
		
		--set @sAftertheFrac = substring (convert(nvarchar(50),@data),
		--  @FracPos,
		--  len(convert(nvarchar(50),@data))-@FracPos+1)

		set @sAftertheFrac = substring (convert(nvarchar(50),@data),
		  @FracPos+1,
		  len(convert(nvarchar(50),@data))-@FracPos)


		--set @intPart = convert (int,@sBeforetheFrac)
		--set @fractionPart = convert (int,@sAftertheFrac)

		set @Fracspace = CharIndex (' ',convert(nvarchar(50),@sBeforetheFrac))	

		if (@Fracspace > 0)
			begin					
				set @sBeforetheSpace = substring (convert(nvarchar(50),@sBeforetheFrac),
					 1,
					 @Fracspace-1)
				set @sAftertheSpace = substring (convert(nvarchar(50),@sBeforetheFrac),
						  @Fracspace+1,
						  len (convert(nvarchar(50),@sBeforetheFrac))-@Fracspace)
                if (left(@sBeforetheSpace,1)='-')
					begin
						set @sBeforetheSpace = substring (convert(nvarchar(50),@sBeforetheSpace),
						 2,
						len (convert(nvarchar(50),@sBeforetheSpace))-2+1)
					set @Frac2Num = convert(decimal(18,4),@sBeforetheSpace) + (convert(decimal(18,4),@sAftertheSpace)/convert(decimal(18,4),@sAftertheFrac))
					set @Frac2Num = - + @Frac2Num
					end
				else
					begin						
						set @Frac2Num = convert(decimal(18,4),@sBeforetheSpace) + (convert(decimal(18,4),@sAftertheSpace)/convert(decimal(18,4),@sAftertheFrac))
					end
				
			end
		else 
			begin
				set @Frac2Num = convert(decimal(18,4),@sBeforetheFrac)/convert(decimal(18,4),@sAftertheFrac)
			end	
		--return @Frac2Num	
	end		
else
	begin		
		set @Frac2Num = cast(@data as decimal(18,4))			
	end
return @Frac2Num

--return cast(@sAftertheFrac as decimal(18,4))
end

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '953', GetDate())
GO

