<%@ WebHandler Language="C#" Class="SketchExport" %>

using System;
using System.Web;
using System.IO;

public class SketchExport : IHttpHandler 
{
    private string fileName = string.Empty;
    private string fileType = string.Empty;
	private string fileData = string.Empty;
    
    public void ProcessRequest (HttpContext context) 
    {
        try
        {
            HttpPostedFile file = context.Request.Files["importFile"];
            int iLen = file.ContentLength;
            byte[] btArr = new byte[iLen];
            file.InputStream.Read(btArr, 0, iLen);
            context.Response.Write(Convert.ToBase64String(btArr));
        }
        catch (Exception ex)
        {
            //context.Response.Write(ex.Message);
        }
    }
 
    public bool IsReusable 
    {
        get 
        {
            return false;
        }
    }

}