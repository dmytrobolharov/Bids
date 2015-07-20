IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Body_Marker_CALCULATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_Body_Marker_CALCULATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_Body_Marker_CALCULATE]    Script Date: 03/08/2011 11:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[spx_Body_Marker_CALCULATE]  (
@Length float ,
@Marker_Plac_Bndl int,
 @Usage float OUTPUT,

 @LossFactor float OUTPUT,
 @pctLossFactor float OUTPUT,
 @TotalUsage float OUTPUT
  )

AS

--set @Length = @Length/36
Begin

if (@Marker_Plac_Bndl >0 and @Length is not null)
Begin
set @Usage = (@Length/@Marker_Plac_Bndl)
-- 1 yd = 36 inches

End
-- Code is added to calculate the LossFactor(Length loss per bundle) as per formula defined for it.
if (@pctLossFactor is not null and @Usage is not null)
Begin
if (@pctLossFactor >1)
Begin
 Set @LossFactor = (@pctLossFactor - 1) * @Usage
End
if (@pctLossFactor !> 1)
Begin
set @LossFactor = 0
End
End

-- Code is added to calculate the Percentage Loss Factor(%Loss per Bundle) as per formula defined for it.
/*
if (@LossFactor is not null and @Usage =0)
Begin
 SET @pctLossFactor =0
End
if (@LossFactor = 0)
Begin
 SET @pctLossFactor = 1
End
if (@LossFactor > 0)
Begin
SET @pctLossFactor = 1 + (@LossFactor/@Usage)
End
*/

if (@Usage is not null and  @pctLossFactor is null)
Begin
set @TotalUsage = @Usage
End
if (@Usage is not null and  @pctLossFactor is not null)
Begin
set @TotalUsage = ((@Usage * (@pctLossFactor -1)) +@Usage)
End
set @Usage = ROUND(@Usage,4)
set @LossFactor = ROUND(@LossFactor,4)
set @pctLossFactor = ROUND(@pctLossFactor,4)
set @TotalUsage  = ROUND (@TotalUsage ,4)
-- select @Usage,@LossFactor,@pctLossFactor,@TotalUsage
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01231', GetDate())
GO