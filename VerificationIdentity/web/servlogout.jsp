<%
if(session==null)
{
    response.sendRedirect("index.html");}
else
       {
    session.invalidate();
    response.sendRedirect("index.html");
}
              
%>