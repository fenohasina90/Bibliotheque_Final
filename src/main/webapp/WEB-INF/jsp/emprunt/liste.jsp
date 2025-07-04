<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Liste des prêts</title>
    <style>
        .retard { color: red; }
    </style>
</head>
<body>
<h2>Liste des prêts en cours</h2>

<table>
    <tr>
        <th>Livre</th>
        <th>Date début</th>
        <th>Date fin</th>
        <th>Statut</th>
        <th>Action</th>
    </tr>
    <c:forEach items="${emprunts}" var="emprunt">
        <tr>
            <td>${emprunt.livre.titre}</td>
            <td>${emprunt.dateDebut}</td>
            <td>${emprunt.dateFin}</td>
            <td>
                <c:choose>
                    <c:when test="${emprunt.dateFin.isBefore(today)}">
                        <span class="retard">En retard</span>
                    </c:when>
                    <c:otherwise>
                        En cours
                    </c:otherwise>
                </c:choose>
            </td>
            <td>
                <a href="/emprunts/retour/${emprunt.id}">Rendre</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>