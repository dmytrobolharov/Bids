
/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_MeasQASample_Update]    Script Date: 07/14/2011 12:41:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_MeasQASample_Update]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_MeasQASample_Update]
GO

Create PROCEDURE [dbo].[spx_SampleRequest_MeasQASample_Update]
(
    @SampleRequestHeaderId UNIQUEIDENTIFIER,
    @SamplePomId UNIQUEIDENTIFIER,    
    @samplelabelid UNIQUEIDENTIFIER,    
    @SizeCol int,
    @SampleNo int,
    @Submit int,
    @SampMeasValue numeric(18,4),
    @ModifiedBy nvarchar(204),
    @ModifiedDate datetime
)
AS

SET NOCOUNT ON

declare @MeasValue numeric(18,4)
declare @SampDelta numeric(18,4)
declare @SampOutTol int
Declare @tolplus  numeric(18,4) 
Declare @tolminus numeric(18,4)  


BEGIN 
	select  @MeasValue = [MeasValue] from pQASampMeas WHERE SampleRequestHeaderId = @SampleRequestHeaderId
	and sizecol=@sizecol and samplepomid=@samplepomid and samplelabelid=@samplelabelid	and submit=@Submit							
	
	select @tolplus = Tolplus, @tolminus = TolMinus from pQApom WHERE 
	SampleRequestHeaderId = @SampleRequestHeaderId	and samplepomid=@samplepomid
	
	if @SampMeasValue = 0 
		begin
			set @SampDelta = 0	
			set @SampOutTol = 0
		end
	else
		begin
			set @SampDelta = @MeasValue - @SampMeasValue	
			if @SampDelta >= @tolminus and @SampDelta <= @tolplus
				begin
					set @SampOutTol = 0
				end
			else
				begin
					set @SampOutTol = 1
				end
		end								
    
    UPDATE pQASampMeas
    SET SampMeasValue = @SampMeasValue,
    SampOutTol=@SampOutTol,
    SampDelta=@SampDelta,
    MUser=@ModifiedBy,
    MDate=@ModifiedDate
    WHERE SampleRequestHeaderId = @SampleRequestHeaderId
    AND SamplePomId = @SamplePomId
    AND SizeCol = @SizeCol
    AND SampleNo = @SampleNo
    and submit=@Submit

END

SET NOCOUNT OFF
GO
			
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01643', GetDate())