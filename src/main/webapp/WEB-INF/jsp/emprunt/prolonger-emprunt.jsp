<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Créer un emprunt</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
<div class="container mt-5">
    <h2>Prolonger le livre ${livre}</h2>

    <c:if test="${not empty param.error}">
        <div class="alert alert-danger">${param.error}</div>
    </c:if>

    <form id="empruntForm" method="post" action="/emprunts/prolonger/${id}">

        <div class="form-group">
            <label for="typeEmprunt">Type d'emprunt</label>
            <select class="form-control" id="typeEmprunt" name="typePret" required>
                <option value="">Sélectionner un type</option>
                <c:forEach items="${typesEmprunt}" var="type">
                    <option value="${type.id}">${type.nom}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group" id="dateFinGroup">
            <label for="dateFin">Date de fin</label>
            <input id="dateFin" type="date" name="dateFin" class="form-control"
                   value="<%= java.time.LocalDate.now().plusWeeks(2) %>"
                   required>
        </div>

        <button type="submit" class="btn btn-primary">Créer l'emprunt</button>
        <a href="/emprunts">
            <button type="button" class="btn btn-secondary">Annuler</button>
        </a>
    </form>
</div>

</body>
</html>