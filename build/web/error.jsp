<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
</head>
<body>
    <h1>An Error Occurred</h1>
    <%
        String errorMessage = (String) request.getAttribute("message");
        if (errorMessage != null) {
            out.println("<p>Error: " + errorMessage + "</p>");
        } else {
            out.println("<p>An unexpected error occurred. Please try again later.</p>");
        }
    %>
</body>
</html>
