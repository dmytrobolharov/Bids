DECLARE @Cnt int

SELECT @Cnt = COUNT(*) from ColorType where ColorType ='PANTONE UNCOATED'
IF @Cnt =0
BEGIN
	INSERT [dbo].[ColorType] ([ColorType], [ColorLibraryTypeID], [StyleColorway], [ColorLibrarySchema], [ColorLibrarySearchSchema], [ColorLibraryItemSchema], [Active], [ColorTypeName], [CorpColor]) VALUES (N'PANTONE UNCOATED', N'00000000-0000-0000-0000-00000000000d', 0, N'Color_LibraryUncoated_Default.xml', N'Color_LibraryUncoated_Search.xml', N'Color_LibraryUncoatedItem_Default.xml', 1, N'PANTONE UNCOATED', 0)
END

SELECT @Cnt = COUNT(*) from ColorType where ColorType ='PANTONE COATED'
IF @Cnt = 0
BEGIN
	INSERT [dbo].[ColorType] ([ColorType], [ColorLibraryTypeID], [StyleColorway], [ColorLibrarySchema], [ColorLibrarySearchSchema], [ColorLibraryItemSchema], [Active], [ColorTypeName], [CorpColor]) VALUES (N'PANTONE COATED', N'00000000-0000-0000-0000-00000000000e', 0, N'Color_LibraryCoated_Default.xml', N'Color_LibraryCoated_Search.xml', N'Color_LibraryCoatedItem_Default.xml', 1, N'PANTONE COATED', 0)
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '03860', GetDate())
GO
 