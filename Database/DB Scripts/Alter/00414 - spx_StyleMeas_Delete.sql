/****** Object:  StoredProcedure [dbo].[spx_StyleMeas_Delete]    Script Date: 09/20/2010 08:35:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


Create PROCEDURE [dbo].[spx_StyleMeas_Delete]
(	@AMLMeasHdrId uniqueidentifier,
	@AMLMeasPOMId uniqueidentifier,	
	@POMRow int	
)

AS 


Begin
	Delete from pamlmeaspom where AMLMeasHdrId=@AMLMeasHdrId and 
	AMLMeasPOMId=@AMLMeasPOMId and POM_Row=@POMRow

	Delete from pamlmeasigc where AMLMeasHdrId=@AMLMeasHdrId and 
	AMLMeasPOMId=@AMLMeasPOMId and POM_Row=@POMRow
End

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '414', GetDate())
GO
