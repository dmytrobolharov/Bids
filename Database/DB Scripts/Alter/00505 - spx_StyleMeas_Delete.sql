set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

IF EXISTS (select * from sysobjects where id = object_id('spx_StyleMeas_Delete') and sysstat & 0xf = 4)
    drop procedure spx_StyleMeas_Delete
GO

create PROCEDURE [dbo].[spx_StyleMeas_Delete]
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
VALUES     ('DB_Version', '4.0.0000', '505', GetDate())
GO

