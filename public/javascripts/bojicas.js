function bojicas_launchme(newURL, newWindow)
{
       if ((navigator.appName=='Microsoft Internet Explorer') && (window.PopWindow)) PopWindow.close();
       PopWindow = open(newURL, "PopWindow", newWindow + ",screenX=0,left=0,screenY=0,top=0,channelmode=0,dependent=0,directories=0,fullscreen=0,location=0,menubar=0,resizable=1,status=0,toolbar=0");
       if (PopWindow.opener == null) PopWindow.opener = window;
       PopWindow.focus();
}
