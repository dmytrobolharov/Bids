/****** Object:  StoredProcedure [dbo].[spx_TACalTemplate_Division_Used]    Script Date: 08/09/2014 11:13:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TACalTemplate_Division_Used]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TACalTemplate_Division_Used]
GO

/****** Object:  StoredProcedure [dbo].[spx_TACalTemplate_Division_Used]    Script Date: 08/09/2014 11:13:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_TACalTemplate_Division_Used](
	@TACalTemplateID uniqueidentifier,
	@DivisionID uniqueidentifier
)

AS 

DECLARE @styleRef integer,
@sampleBomRef integer,
@sampleRef integer,
@totalRef integer


select @styleRef = COUNT(*)  from pTACalReference cr
INNER JOIN pStyleHeader sh ON cr.ReferenceId = sh.StyleID
where TACalTemplateId = @TACalTemplateID and TACalReferenceTypeId in (2) and sh.DivisionID = @DivisionID

select  @sampleBomRef = COUNT(*)  from pTACalReference cr
INNER JOIN pSampleRequestBOMTrade srb ON cr.ReferenceId = srb.SampleRequestTradeID
INNER JOIN pStyleHeader sh ON srb.StyleID = sh.StyleID
where TACalTemplateId = @TACalTemplateID and TACalReferenceTypeId in (5) and sh.DivisionID = @DivisionID

select  @sampleRef = COUNT(*)  from pTACalReference cr
INNER JOIN pSampleRequestTrade srb ON cr.ReferenceId = srb.SampleRequestTradeID
INNER JOIN pStyleHeader sh ON srb.StyleID = sh.StyleID
where TACalTemplateId = @TACalTemplateID and TACalReferenceTypeId in (5) and sh.DivisionID = @DivisionID

Set @totalRef = @styleRef + @sampleBomRef + @sampleRef

SELECT @totalRef as refCount

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08662', GetDate())
GO
