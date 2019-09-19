# How to use SharePoint-Online-Discard CheckOut recursevely.ps1

The aim of this script is to automatize the process of having to discard checkout manually for a significant number of files on a document library on SharePoint Online.

The Script provides a recursive file check for an entire Folder or Document Library.

It is quite essential but it provides also a log of all the files it discarded the check out.

It will also create an output transcript.

To use the script:

- Make sure you update the path with your document library or folder. Make sure you give a correct path for the transcript (so change C:\Support to what you want)

- Connect to SharePoint Online Management Shell - https://www.microsoft.com/en-gb/download/details.aspx?id=35588

- Connect to the SharePoint Site: Connect-PnPOnline -Url https://yoursite.sharepoint.com

- Navigate to the path of the script and run it: .\script.ps1
