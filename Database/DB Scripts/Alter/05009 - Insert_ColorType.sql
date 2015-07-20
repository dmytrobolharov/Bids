DECLARE @Cnt int

SELECT @Cnt = COUNT(*) from ColorType where ColorType ='PANTONE Pastels & Neons UNCOATED'
--print @Cnt
IF @Cnt =0
BEGIN
	INSERT [dbo].[ColorType] ([ColorType], [ColorLibraryTypeID], [StyleColorway], [ColorLibrarySchema], [ColorLibrarySearchSchema], [ColorLibraryItemSchema], [Active], [ColorTypeName], [CorpColor]) VALUES (N'PANTONE Pastels & Neons UNCOATED', N'00000000-0000-0000-0000-000000000018', 0, N'Color_LibraryPantonePNUncoated_Default.xml', N'Color_LibraryPantonePNUncoated_Search.xml', N'Color_LibraryPantonePNUncoatedItem_Default.xml', 1, N'PANTONE Pastels & Neons UNCOATED', 0)
END
--DECLARE @Cnt int
SELECT @Cnt = COUNT(*) from ColorType where ColorType ='PANTONE Pastels & Neons COATED'
--print @Cnt
IF @Cnt = 0
BEGIN
	
	INSERT [dbo].[ColorType] ([ColorType], [ColorLibraryTypeID], [StyleColorway], [ColorLibrarySchema], [ColorLibrarySearchSchema], [ColorLibraryItemSchema], [Active], [ColorTypeName], [CorpColor]) VALUES (N'PANTONE Pastels & Neons COATED', N'00000000-0000-0000-0000-000000000019', 0, N'Color_LibraryPantonePNCoated_Default.xml', N'Color_LibraryPantonePNCoated_Search.xml', N'Color_LibraryPantonePNCoatedItem_Default.xml', 1, N'PANTONE Pastels & Neons COATED', 0)
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05009', GetDate())
GO
 