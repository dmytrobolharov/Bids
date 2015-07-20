IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteItem_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteItem_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- Stored Procedure

CREATE PROCEDURE [dbo].[spx_StyleQuoteItem_INSERT]
(
@QuoteItemID uniqueidentifier,
@SourcingHeaderID uniqueidentifier,
@SourcingStyleID uniqueidentifier,
@StyleID uniqueidentifier,
@CUser nvarchar(200),
@CDate datetime
)
AS 

BEGIN
DECLARE 
@DevelopmentID uniqueidentifier,
@StyleSeasonYearID	uniqueidentifier

SELECT @DevelopmentID = DevelopmentID from pStyleHeader WITH (NOLOCK) where StyleID = @StyleID

SELECT @StyleSeasonYearID = StyleSeasonYearID from pStyleSeasonYear WITH (NOLOCK) where StyleID = @StyleID

INSERT INTO pStyleQuoteItem 
           (StyleQuoteItemID 
           ,StyleQuoteItemShare
           ,StyleQuoteItemStatusId
           ,StyleDevelopmentID
           ,StyleID
           ,StyleColorID
           ,StyleSourcingID
           ,StyleSeasonYearID
           ,SourcingHeaderID 
           ,CUser
           ,CDate)  
           values 
           (
           @QuoteItemID
           ,0
           ,-1
           ,@DevelopmentID
           ,@StyleID
           ,'00000000-0000-0000-0000-000000000000'
           ,@SourcingStyleID
           ,@StyleSeasonYearID 
           ,@SourcingHeaderID
           ,@CUser
           ,@CDate
           )   

END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04194', GetDate())
GO

