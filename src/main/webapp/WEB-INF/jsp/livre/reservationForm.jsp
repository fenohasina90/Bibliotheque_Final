<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nouvelle Réservation</title>
    <link href="/css/reservationform.css" rel="stylesheet">
</head>
<body>
<div class="form-container">
    <h1>Nouvelle Réservation</h1>
    <form method="POST" action="${pageContext.request.contextPath}/reservation/create">
        <div class="form-group">
            <label for="date_debut">Date de début :</label>
            <input id="date_debut" type="date" name="dateDebut" required />
            <input type="hidden" name="livreId" value="${livreId}" />
        </div>

        <div class="btn-container">
            <button type="submit" class="btn">Créer la réservation</button>
            <button type="button" class="btn btn-secondary" onclick="window.location.href='/user/'">
                Retour
            </button>
        </div>
        <c:if test="${not empty erreur}">
            <div class="alert alert-danger text-center">${erreur}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success text-center">${success}</div>
        </c:if>
    </form>
</div>

<script>
    // Définir la date minimum à aujourd'hui
    document.addEventListener('DOMContentLoaded', function() {
        const dateInput = document.getElementById('date_debut');
        const today = new Date().toISOString().split('T')[0];
        dateInput.setAttribute('min', today);
        dateInput.value = today;
    });
</script>
</body>
</html>