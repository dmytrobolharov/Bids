/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_MeasQASize_SELECT]    Script Date: 07/14/2011 12:53:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_MeasQASize_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_MeasQASize_SELECT]
GO

Create PROCEDURE [dbo].[spx_SampleRequest_MeasQASize_SELECT]
(
@SampleRequestHeaderId nvarchar(50),
@AMLMeasHdrId nvarchar(50),
@AddSample nvarchar(4)
)
AS
 
SET NOCOUNT ON

if Len(@SampleRequestHeaderId) > 0 
	begin
		if Len(@AddSample) > 0
			begin
				select AMLMeasLblId, measlbl, 0 as SampleNo from pamlmeaslbl
				where AMLMeasHdrId = @AMLMeasHdrId  and AMLMeasLblId  in ( select AMLMeasLblId from pQASampLbl
				where AMLMeasHdrId = @AMLMeasHdrId and SampleRequestHeaderId = @SampleRequestHeaderId and SampleNo>0)
				ORDER BY Sizecol			
			end 
		else	
			begin
				select AMLMeasLblId, measlbl, 0 as SampleNo from pamlmeaslbl
				where AMLMeasHdrId = @AMLMeasHdrId and isvisible=1 and AMLMeasLblId not in ( select AMLMeasLblId from pQASampLbl
				where AMLMeasHdrId = @AMLMeasHdrId and SampleRequestHeaderId = @SampleRequestHeaderId)
				ORDER BY Sizecol			
			end
	end
else
	begin
		select AMLMeasLblId, measlbl , 0 as SampleNo from pamlmeaslbl
		where AMLMeasHdrId = @AMLMeasHdrId and isvisible=1 ORDER BY Sizecol
	end



SET NOCOUNT OFF
GO
			
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01645', GetDate())

